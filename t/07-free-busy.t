use Test;

use Evolution::Raw::Types;
use Evolution::Raw::TestServerUtils;

use Evolution::Calendar::Client;

use Evolution::TestServerUtils;

constant MAIL_ACCOUNT_UID   = 'test-email-account';
constant MAIL_IDENTITY_UID  = 'test-email-identity';
constant USER_EMAIL         = 'user@example.com';

my $cal-closure             = ETestServerClosure.new;
my $received-free-busy-data = False;

sub setup-fixture ($f, $d) {
  Evolution::TestServerUtils.setup($f, $d);

  my $scratch = Evolution::Source.new-with-uid(MAIL_IDENTITY_UID);
  die "Failed to create scratch source: { $ERROR.message }"
    unless $scratch;

  ( my $mail-identity = $scratch.get-extension(
    E_SOURCE_EXTENSION_MAIL_IDENTITY
  ) ).address = USER_EMAIL;

  die "Unable to add new scratch mail identity source to the registry: {
      $ERROR.message }"
  unless $f.registry.commit-source-sync($scratch);

  $scratch.unref;

  $scratch = Evolution::Source.new-with-uid(MAIL_ACCOUNT_UID);
  die "Failed to create scratch source: { $ERROR.message }"
    unless $scratch;

  ( my $mail-account = $scratch.get-extension(
    E_SOURCE_EXTENSION_MAIL_ACCOUNT
  ) ).identity-uid = MAIL_IDENTITY_UID;

  die "Unable to add new scratch mail identity source to the registry: {
      $ERROR.message }"
  unless $f.registry.commit-source-sync($scratch);

  $scratch.unref;
}

sub teardown-fixture ($f, $d) {
  die 'Unable to fetch mail account!'
    unless ( my $source = $f.registry.ref-source(MAIL_ACCOUNT_UID) );

  die "Unable to remove mail account: { $ERROR.message }"
    unless $source.remove-sync;

  $source.unref;

  die 'Unable to fetch mail identity!'
    unless ( $source = $f.registry.ref-source(MAIL_IDENTITY_UID) );

  die "Unable to remove mail identity: { $ERROR.message }"
    unless $source.remove-sync;

  Evolution::TestServerUtils.teardown($f, $d);
}

sub add-component-sync ($c) {
  my $icomp = ICal::GLib::Component.new-from-string( q:to/VEVENT/ );
    BEGIN:VEVENT\r
		UID:test-fb-event-1\r
		DTSTAMP:20040212T000000Z\r
		DTSTART:20040213T060000Z\r
		DTEND:20040213T080000Z\r
		SUMMARY:Test event\r
		TRANSP:OPAQUE\r
		CLASS:PUBLIC\r
		CREATED:20040211T080000Z\r
		LAST-MODIFIED:20040211T080000Z\r
		END:VEVENT\r
    VEVENT

  ok $icomp, 'ICal Component can initialize from event string';

  lives-ok {
    die "Failed to add component: { $ERROR.message }"
      unless $c.create-object-sync($icomp, E_CAL_OPERATION_FLAG_NONE);
  }

  $icomp.unref;
}

sub wait-for-dbus-signal ($l) {
  my $r  = 0;
  my $mc = GLib::MainLoop.get-context($l);

  while $received-free-busy-data.not && $r < 5 {
    $r++;
    $mc.iteration(True);
  }
}

sub free-busy-callback ( *@a ) {
  CATCH { default { .message.say } }

  $received-free-busy-data = True if GLib::GSList.new( @a[1] ).elems > 0
}

sub test-get-free-busy-sync ($f, $d) {
  my $freebusy-data = GLib::GSList.new;

  my $cal-client = $f.service.getGenericService(
    |Evolution::Calendar::Client.getTypePair
  );

  add-component-sync($cal-client);

  $received-free-busy-data = False;

  $cal-client.free-busy-data.tap( -> *@a { free-busy-callback( |@a ) });

  my $utc   = ICal::GLib::Timezone.get-utc-timezone;
  my $start = Evolution::Calendar::TimeUtil.from_isodate('20040212T000000Z');
  my $end   = $start.add_day_with_zone(2, $utc);

  die "get free busy sync error: { $ERROR.message }"
    unless $cal-client.get-free-busy-sync( $start, $end, [ USER_EMAIL ] );

  wait-for-dbus-signal($f.loop);

  ok $received-free-busy-data, 'Received free-busy data.';
  ok $freebusy-data,          'free-busy data is not undefined';

  # Unref all $free-busy-data
}

sub async-get-free-busy-result-ready ($cc, $r, $l) {
  my $freebusy-data = GLib::GSList.new;

  die "Create object finish error: { $ERROR.message }"
    unless $cc.get-free-busy-finish($r, $freebusy-data);

  wait-for-dbus-signal($l);

  ok $received-free-busy-data, 'Received free-busy data.';
  ok $freebusy-data,           'free-busy data is not undefined';

  $l.quit;
}

sub test-get-free-busy-async ($f, $d) {
  my $cal-client = $f.service.getGenericService(
    |Evolution::Calendar::Client.getTypePair
  );

  add-component-sync($cal-client);

  $received-free-busy-data = False;

  my $utc   = ICal::Timezone.get-utc-timezone();
  my $start = Evolution::Calendar::TimeUtil.get-from-isodate(
    '20040212T000000Z'
  );
  my $end   = $start.add-day-with-zone(2, $utc);

  $cal-client.free-busy-data.tap( -> *@a { free-busy-callback( |@a ) });

  $cal-client.get-free-busy(
    $start,
    $end,
    [ USER_EMAIL ],
    -> *@a { async-get-free-busy-result-ready( |@a ) },
    $f.loop
  );

  $f.loop.run;
}
