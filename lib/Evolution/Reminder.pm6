use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GLib::Raw::Types;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Types;
use Evolution::Raw::Reminder;

use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset EReminderWatcherAncestry is export of Mu
  where EReminderWatcher | GObject;

class Evolution::Reminder {
  also does GLib::Roles::Object;

  has EReminderWatcher $!eds-rw is implementor;

  submethod BUILD ( :$e-reminder-watcher ) {
    self.setEReminderWatcher($e-reminder-watcher) if $e-reminder-watcher
  }

  method setEReminderWatcher (EReminderWatcherAncestry $_) {
    my $to-parent;

    $!eds-rw = do {
      when EReminderWatcher {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EReminderWatcher, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EReminderWatcher
    is also<EReminderWatcher>
  { $!eds-rw }

  multi method new (
    $e-reminder-watcher where * ~~ EReminderWatcherAncestry,

    :$ref = True
  ) {
    return unless $e-reminder-watcher;

    my $o = self.bless( :$e-reminder-watcher );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESourceRegistry() $reg) {
    my $e-reminder-watcher = e_reminder_watcher_new($reg);

    $e-reminder-watcher ?? self.bless( $e-reminder-watcher ) !! Nil;
  }

  method describe_data (
    EReminderData() $rd,
    Int()           $flags = E_REMINDER_WATCHER_DESCRIBE_FLAG_NONE
  )
    is also<describe-data>
  {
    my guint32 $f = $flags;

    e_reminder_watcher_describe_data($!eds-rw, $rd, $f);
  }

  proto method dismiss (|)
  { * }

  multi method dismiss (
    EReminderData()  $rd,
                     &callback,
    gpointer         $user_data    = gpointer,
    GCancellable()  :$cancellable  = GCancellable
  ) {
    samewith($rd, $cancellable, &callback, $user_data);
  }
  multi method dismiss (
    EReminderData() $rd,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    e_reminder_watcher_dismiss(
      $!eds-rw,
      $rd,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method dismiss_all (|)
    is also<dismiss-all>
  { * }

  multi method dismiss_all (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method dismiss_all (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    e_reminder_watcher_dismiss_all(
      $!eds-rw,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method dismiss_all_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<dismiss-all-finish>
  {
    clear_error;
    my $rv = so e_reminder_watcher_dismiss_all_finish(
      $!eds-rw,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method dismiss_all_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<dismiss-all-sync>
  {
    clear_error;
    my $rv = so e_reminder_watcher_dismiss_all_sync(
      $!eds-rw,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method dismiss_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<dismiss-finish>
  {
    clear_error;
    my $rv = e_reminder_watcher_dismiss_finish($!eds-rw, $result, $error);
    set_error($error);
    $rv;
  }

  method dismiss_sync (
    EReminderData()         $rd,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<dismiss-sync>
  {
    clear_error;
    my $rv = e_reminder_watcher_dismiss_sync(
      $!eds-rw,
      $rd,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method dup_default_zone ( :$raw = False ) is also<dup-default-zone> {
    propReturnObject(
      e_reminder_watcher_dup_default_zone($!eds-rw),
      $raw,
      |ICal::GLib::Timezone.getTypePair
    );
  }

  method dup_past ( :$raw = False, :glist(:$gslist) = False )
    is also<dup-past>
  {
    returnGSList(
      e_reminder_watcher_dup_past($!eds-rw),
      $raw,
      $gslist,
      |Evolution::Reminder::Data.getTypePair
    );
  }

  method dup_snoozed ( :$raw = False, :glist(:$gslist) = False )
    is also<dup-snoozed>
  {
    returnGSList(
      e_reminder_watcher_dup_snoozed($!eds-rw);
      $raw,
      $gslist,
      |Evolution::Reminder::Data.getTypePair
    );
  }

  method get_registry ( :$raw = False ) is also<get-registry> {
    propReturnObject(
      e_reminder_watcher_get_registry($!eds-rw),
      $raw,
      |Evolution::Source::Registry.getTypePair
    );
  }

  method get_timers_enabled is also<get-timers-enabled> {
    so e_reminder_watcher_get_timers_enabled($!eds-rw);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_reminder_watcher_get_type, $n, $t );
  }

  method ref_opened_client (Str() $source_uid, :$raw = False)
    is also<ref-opened-client>
  {
    propReturnObject(
      e_reminder_watcher_ref_opened_client($!eds-rw, $source_uid);
      $raw,
      |Evolution::Calendar::Client.getTypePair
    );
  }

  method set_default_zone (ICalTimezone() $zone) is also<set-default-zone> {
    e_reminder_watcher_set_default_zone($!eds-rw, $zone);
  }

  method set_timers_enabled (Int() $enabled) is also<set-timers-enabled> {
    my gboolean $e = $enabled.so.Int;

    e_reminder_watcher_set_timers_enabled($!eds-rw, $e);
  }

  method snooze (EReminderData() $rd, Int() $until) {
    my gint64 $u = $until;

    e_reminder_watcher_snooze($!eds-rw, $rd, $u);
  }

  method timer_elapsed is also<timer-elapsed> {
    e_reminder_watcher_timer_elapsed($!eds-rw);
  }

}

class Evolution::Reminder::Data {
  also does GLib::Roles::Implementor;

  has EReminderData $!eds-rd is implementor;

  submethod BUILD ( :$e-reminder-data ) {
    $!eds-rd = $e-reminder-data if $e-reminder-data;
  }

  method new (
    Str()                        $source_uid,
    ECalComponent()              $component,
    ECalComponentAlarmInstance() $instance
  ) {
    my $e-reminder-data = e_reminder_data_new(
      $source_uid,
      $component,
      $instance
    );

    $e-reminder-data ?? self.bless( :$e-reminder-data ) !! Nil;
  }

  method copy {
    e_reminder_data_copy($!eds-rd);
  }

  method free {
    e_reminder_data_free($!eds-rd);
  }

  method get_component ( :$raw = False ) is also<get-component> {
    propReturnObject(
      e_reminder_data_get_component($!eds-rd),
      $raw,
      |Evolution::Calendar::Component.getTypePair
    );
  }

  method get_instance ( :$raw = False ) is also<get-instance> {
    propReturnObject(
      e_reminder_data_get_instance($!eds-rd),
      $raw,
      |Evolution::Calendar::Component::AlarmInstance.getTypePair
    );
  }

  method get_source_uid is also<get-source-uid> {
    e_reminder_data_get_source_uid($!eds-rd);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_reminder_data_get_type, $n, $t );
  }

  method set_component (ECalComponent() $component) is also<set-component> {
    e_reminder_data_set_component($!eds-rd, $component);
  }

  method set_instance (ECalComponentAlarmInstance() $instance)
    is also<set-instance>
  {
    e_reminder_data_set_instance($!eds-rd, $instance);
  }

  method set_source_uid (Str() $source_uid) is also<set-source-uid> {
    e_reminder_data_set_source_uid($!eds-rd, $source_uid);
  }

}
