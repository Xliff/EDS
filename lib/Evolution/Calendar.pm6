use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar;

use GLib::GList;
use Evolution::Client;

our subset ECalClientAncestry is export of Mu
  where ECalClient | EClientAncestry;

class Evolution::Calendar is Evolution::Client {
  has ECalClient $!ecal;

  submethod BUILD (:$calendar) {
    self.setECalClient($calendar) if $calendar;
  }

  method setECalClient (ECalClientAncestry $_) {
    my $to-parent;

    $!c = do {
      when ECalClient {
        $to-parent = cast(EClient, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalClient, $_);
      }
    }
    self.setEClient($to-parent);
  }

  method Evolution::Raw::Definitions::ECalClient
  { $!ecalc }

  method new (ECalClientAncestry $calendar, :$ref = True) {
    return Nil unless $calendar;

    my $o = self.bless( :$calendar );
    $o.ref if $ref;
    $o;
  }

  proto method add_timezone (|)
  { * }

  multi method add_timezone (
    ICalTimezone() $zone,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($zone. $cancellable, &callback, $user_data);
  }
  multi method add_timezone (
    ICalTimezone() $zone,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_add_timezone($!ecal, $zone, $cancellable, $callback, $user_data);
  }

  method add_timezone_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_client_add_timezone_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method add_timezone_sync (
    ICalTimezone()          $zone,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_cal_client_add_timezone_sync(
      $!ecal,
      $zone,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method check_one_alarm_only {
    so e_cal_client_check_one_alarm_only($!ecal);
  }

  method check_organizer_must_accept {
    so e_cal_client_check_organizer_must_accept($!ecal);
  }

  method check_organizer_must_attend {
    so e_cal_client_check_organizer_must_attend($!ecal);
  }

  method check_recurrences_no_master {
    so e_cal_client_check_recurrences_no_master($!ecal);
  }

  method check_save_schedules {
    so e_cal_client_check_save_schedules($!ecal);
  }

  multi method connect (
    ESource()      $source,
    Int()          $source_type,
    Int()          $wait_for_connected_seconds,
                   &callback,
    gpointer       $user_data                   = gpointer,
    GCancellable() :$cancellable                = GCancellable
  ) {
    samewith(
      $source,
      $source_type,
      $wait_for_connected_seconds,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method connect (
    ESource()      $source,
    Int()          $source_type,
    Int()          $wait_for_connected_seconds,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data                   = gpointer
  ) {
    my ECalClientSourceType $s = $source_type;
    my guint32              $w = $wait_for_connected_seconds;

    e_cal_client_connect($source, $s, $w, $cancellable, &callback, $user_data);
  }

  method connect_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_client_connect_finish($result, $error);
    set_error($error);
    $rv;
  }

  method connect_sync (
    ESource()               $source,
    Int()                   $source_type,
    Int()                   $wait_for_connected_seconds,
    GCancellable()          $cancellable                 = GCancellable,
    CArray[Pointer[GError]] $error                       = gerror
  ) {
    my ECalClientSourceType $s = $source_type;
    my guint32              $w = $wait_for_connected_seconds;

    clear_error;
    my $rv = so e_cal_client_connect_sync(
      $source,
      $s,
      $w,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method create_object (|)
  { * }

  method create_object (
    ICalComponent() $icalcomp,
    Int()           $opflags,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith(
      $icalcomp,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  method create_object (
    ICalComponent() $icalcomp,
    Int()           $opflags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_cal_client_create_object(
      $!ecal,
      $icalcomp,
      $o,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method create_object_finish (|)
  { * }

  multi method create_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror,
                            :$all     = False
  ) {
    (my $ou = CArray[Str].new)[0] = Str;

    my $rv = samewith($result, $ou, $error, :all);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method create_object_finish (
    GAsyncResult()          $result,
    CArray[Str]             $out_uid,
    CArray[Pointer[GError]] $error    = gerror,
                            :$all     = False
  ) {
    clear_error;
    my $rv = so e_cal_client_create_object_finish(
      $!ecal,
      $result,
      $out_uid,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, CStringArrayToArray($out_uid) );
  }

  proto method create_object_sync (|)
  { * }

  multi method create_object_sync (
    ICalComponent()         $icalcomp,
    Int()                   $opflags,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable            :$cancellable = GCancellable
  ) {
    (my $ou = CArray[Str].new)[0] = Str;

    my $rv = samewith
      $icalcomp,
      $opflags,
      $ou,
      $cancellable,
      $error,
      :all
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method create_object_sync (
    ICalComponent           $icalcomp,
    Int()                   $opflags,
    CArray[Str]             $out_uid,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
                            :$all         = False
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_cal_client_create_object_sync(
      $!ecal,
      $icalcomp,
      $opflags,
      $out_uid,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, CStringArrayToArray($out_uid) );
  }

  proto method create_objects (|)

  multi method create_objects (
                 @icalcomps,
    Int()        $opflags,
                 &callback (GObject, GAsyncResult, gpointer),
    gpointer     $user_data     = gpointer,
    GCancellable :$cancellable  = GCancellable
  ) {
    samewith(
      $!ecal,
      GLib::GSList.new(@icalcomps),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create_objects (
    ECalClient   $client,
    GSList       $icalcomps,
    Int()        $opflags,
    GCancellable $cancellable,
                 &callback (GObject, GAsyncResult, gpointer),
    gpointer     $user_data
  ) {
    my guint32 $o = $opflags;

    e_cal_client_create_objects(
      $!ecal,
      $icalcomps,
      $opflags,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method create_objects_finish (|)
  { * }

  multi method create_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    (my $ou = CArray[Str].new)[0] = Str;

    my $rv = samewith($result, $ou, $error, :all);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method create_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_uids,
    CArray[Pointer[GError]] $error = gerror,
                            :$all  = False
  ) {
    clear_error;
    my $rv = e_cal_client_create_objects_finish(
      $!ecal,
      $result,
      $out_uids,
      $error
    );
    set_error($error);

    return $rv if $all.not;

    # GList is more reliable than GSList
    my $ol = GLib::GList.new( ppr($out_uids) ) but GLib::Roles::TypedData[Str];
    ( $rv, $ol.Array )
  }

  proto method create_objects_sync (|)
  { * }

  multi method create_objects_sync (
    GSList()                $icalcomps,
    Int()                   $opflags,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    my guint32 $o = $opflags;
    (my $ou = CArray[Str].new)[0] = Str;

    my $rv = samewith(
      $icalcomps,
      $o,
      $out_uids,
      $cancellable,
      $error
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method create_objects_sync (
    GSList()                $icalcomps,
    Int()                   $opflags,
    CArray[Pointer[GSList]] $out_uids,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$all        = False
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_client_create_objects_sync(
      $!ecal,
      $icalcomps,
      $o,
      $out_uids,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv if $all.not;

    # GList is more reliable than GSList
    my $ol = GLib::GList.new( ppr($out_uids) ) but GLib::Roles::TypedData[Str];
    ( $rv, $ol.Array )
  }

  proto method discard_alarm (|)
  { * }

  multi method discard_alarm (
    Str()          $uid,
    Str()          $rid,
    Str()          $auid,
    Int()          $opflags,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable,
  ) {
    samewith(
      $uid,
      $rid,
      $auid,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method discard_alarm (
    Str()          $uid,
    Str()          $rid,
    Str()          $auid,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    so e_cal_client_discard_alarm(
      $!ecal,
      $uid,
      $rid,
      $auid,
      $o,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method discard_alarm_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so e_cal_client_discard_alarm_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method discard_alarm_sync (
    Str()                   $uid,
    Str()                   $rid,
    Str()                   $auid,
    Int()                   $opflags,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_cal_client_discard_alarm_sync(
      $!ecal,
      $uid,
      $rid,
      $auid,
      $opflags,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method error_to_string (Evolution::Calendar:U: Int() $code) {
    my ECalClientError $c = $code;

    e_cal_client_error_to_string($c);
  }

  proto method generate_instances (|)
  { * }

  method generate_instances (
    Int()          $start,
    Int()          $end,
                   &cb,
    gpointer       $cb_data         = gpointer,
                   &destroy_cb_data = Callable,
    GCancellable() :$cancellable    = GCancellable
  ) {
    samewith(
      $start,
      $end,
      $cancellable,
      &cb,
      $cb_data,
      &destroy_cb_data
    );
  }
  method generate_instances (
    Int()          $start,
    Int()          $end,
    GCancellable() $cancellable,
                   &cb,
    gpointer       $cb_data         = gpointer,
                   &destroy_cb_data = Callable
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_client_generate_instances(
      $!ecal,
      $s,
      $e,
      $cancellable,
      &cb,
      $cb_data,
      &destroy_cb_data
    );
  }

  proto method generate_instances_for_object (|)

  multi method generate_instances_for_object (
    ICalComponent() $icalcomp,
    Int()           $start,
    Int()           $end,
                    &cb,
    gpointer        $cb_data         = gpointer,
                    &destroy_cb_data = Callable
    GCancellable()  :$cancellable    = GCancellable,
  ) {
    samewith(
      $icalcomp,
      $start,
      $end,
      $cancellable,
      &cb,
      $cb_data,
      &destroy_cb_data
    )
  }
  multi method generate_instances_for_object (
    ICalComponent() $icalcomp,
    Int()           $start,
    Int()           $end,
    GCancellable()  $cancellable,
                    &cb,
    gpointer        $cb_data         = gpointer,
                    &destroy_cb_data = Callable
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_client_generate_instances_for_object(
      $!ecal,
      $icalcomp,
      $s,
      $e,
      $cancellable,
      &cb,
      $cb_data,
      &destroy_cb_data
    );
  }

  proto method generate_instances_for_object_sync (|)
  { * }

  multi method generate_instances_for_object_sync (
    ICalComponent() $icalcomp,
    Int()           $start,
    Int()           $end,
                    &cb,
    gpointer        $cb_data      = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith(
      $icalcomp,
      $start,
      $end,
      $cancellable,
      &cb,
      $cb_data
    )
  }
  multi method generate_instances_for_object_sync (
    ICalComponent() $icalcomp,
    Int()           $start,
    Int()           $end,
    GCancellable()  $cancellable,
                    &cb,
    gpointer        $cb_data      = gpointer
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_client_generate_instances_for_object_sync(
      $!ecal,
      $icalcomp,
      $s,
      $e,
      $cancellable,
      &cb,
      $cb_data
    );
  }

  proto method generate_instances_sync (|)
  { * }

  multi method generate_instances_sync (
    Int()        $start,
    Int()        $end,
                 &cb,
    gpointer     $cb_data      = gpointer,
    GCancellable :$cancellable
  ) {
    samewith(
      $start,
      $end,
      $cancellable,
      &cb,
      $cb_data
    )
  }
  multi method generate_instances_sync (
    Int()          $start,
    Int()          $end,
    GCancellable() $cancellable,
                   &cb,
    gpointer       $cb_data = gpointer
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_client_generate_instances_sync(
      $!ecal,
      $s,
      $e,
      $cancellable,
      &cb,
      $cb_data
    );
  }

  proto method get_attachment_uris (|)
  { * }

  multi method get_attachment_uris (
    Str()          $uid,
    Str()          $rid,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $uid,
      $rid,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method get_attachment_uris (
    Str()          $uid,
    Str()          $rid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_get_attachment_uris(
      $!ecal,
      $uid,
      $rid,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_attachment_uris_finish (|)
  { * }

  multi method get_attachment_uris_finish (
    GAsyncResult()          $result
    CArray[Pointer[GError]] $error  = gerror
                            :$glist = False,
                            :$raw   = False
  ) {
    (my $oau = CArray[Str].new)[0] = Str;

    $rv = samewith(
      $result,
      $oau,
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }

  multi method get_attachment_uris_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_attachment_uris,
    CArray[Pointer[GError]] $error                = gerror
                            :$all                 = False,
                            :$glist               = False,
                            :$raw                 = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_attachment_uris_finish(
      $!ecal,
      $result,
      $out_attachment_uris,
      $error
    );
    set_error($error);

    return $rv unless $all;

    (
      $rv,
      returnGList(
        ppr($out_attachment_uris),
        $glist,
        $raw
      )
    )
  }

  proto method get_attachment_uris_sync (|)
  { * }

  multi method get_attachment_uris_sync (
    Str                     $uid,
    Str                     $rid,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = error,
                            :$all                 = False,
                            :$glist               = False,
                            :$raw                 = False
  ) {
    samewith(
      $uid,
      $rid,
      $out_attachment_uris,
      $cancellable,
      $error,
      :all
      :$glist
      :$raw
    );
  }
  multi method get_attachment_uris_sync (
    Str                     $uid,
    Str                     $rid,
    CArray[Pointer[GSList]] $out_attachment_uris,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = error,
                            :$all                 = False,
                            :$glist               = False,
                            :$raw                 = False
  ) {
    my $rv = e_cal_client_get_attachment_uris_sync(
      $!ecal,
      $uid,
      $rid,
      $out_attachment_uris,
      $cancellable,
      $error
    );

    return $rv unless $all;

    (
      $rv,
      returnGList(
        ppr($out_attachment_uris),
        $glist,
        $raw
      )
    );
  }

  method get_component_as_string (ICalComponent() $icalcomp) {
    e_cal_client_get_component_as_string($!ecal, $icalcomp);
  }

  proto method get_default_object (|)
  { * }

  multi method get_default_object (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method get_default_object (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_get_default_object(
      $!ecal,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method get_default_object_finish (|)
  { * }

  multi method get_default_object_finish (
    GAsyncResult()                 $result,
    CArray[Pointer[GError]]        $error         = gerror
  ) {
    (my $oi = CArray[Pointer[ICalComponent]].new)[0] = Pointer[ICalComponent];
    my $rv = samewith($result, $oi, $error);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_default_object_finish (
    GAsyncResult()                 $result,
    CArray[Pointer[ICalComponent]] $out_icalcomp,
    CArray[Pointer[GError]]        $error         = gerror,
                                   :$all          = False,
                                   :$raw          = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_default_object_finish(
      $!ecal,
      $result,
      $out_icalcomp,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $oi = ppr($out_icalcomp);
    (
      $rv,
      $oi ??
        ( $raw ?? $oi !! ICal::Component.new($oi) )
        !!
        Nil
    )
  }

  proto method get_default_object_sync (|)
  { * }

  multi method get_default_object_sync
    CArray[Pointer[GError]]        $error         = gerror,
    GCancellable()                 :$cancellable  = GCancellable,
                                   :$all          = False,
                                   :$raw          = False
  ) {
    (my $oi = CArray[Pointer[ICalComponent]].new)[0] = Pointer[ICalComponent];

    my $rv = samewith($oi, $cancellable, $error, :all, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_default_object_sync (
    CArray[Pointer[ICalComponent]] $out_icalcomp,
    GCancellable()                 $cancellable   = GCancellable,
    CArray[Pointer[GError]]        $error         = gerror,
                                   :$all          = False,
                                   :$raw          = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_default_object_sync(
      $!ecal,
      $out_icalcomp,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $oi = ppr($out_icalcomp);
    (
      $rv,
      $oi ??
        ( $raw ?? $oi !! ICal::Component.new($oi) )
        !!
        Nil
    )
  }

  method get_default_timezone (:$raw = False) {
    #icaltimezone
    my $tz = e_cal_client_get_default_timezone($!ecal);

    $tz ??
      ( $raw ?? $tz !! ICal::Timezone.new($tz) )
      !!
      Nil;
  }

  method get_free_busy (
    Int()          $start,
    Int()          $end,
                   @users,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable,
  ) {
    samewith(
      $start,
      $end,
      GLib::GSList.new(@users),
      $cancellable,
      &callback,
      $user_data
    );
  }
  method get_free_busy (
    Int()          $start,
    Int()          $end,
    GSList()       $users,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_client_get_free_busy(
      $!ecal,
      $s,
      $e,
      $users,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_free_busy_finish (|)
  { * }

  multi method get_free_busy_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$glist  = False,
                            :$raw    = False
  ) {
    (my $ofb = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samewith($result, $ofb, $error, :all, :$glist, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_free_busy_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_freebusy,
    CArray[Pointer[GError]] $error         = gerror
                            :$all          = False,
                            :$glist        = False,
                            :$raw          = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_free_busy_finish(
      $!ecal,
      $result,
      $out_freebusy,
      $error
    );
    set_error($error);

    return $rv unless $callback;

    my $ofb = ;
    (
      $rv,
      returnGList(
        ppr($out_freebusy),
        $glist,
        $raw,
        ECalComponent
        Evolution::Calendar::Component
      )
    );
  }

  proto method get_free_busy_sync (|)
  { * }

  method get_free_busy_sync (
    Int()                   $start,
    Int()                   $end,
                            @users,
    CArray[Pointer[GError]] $error         = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$all          = False,
                            :$glist        = False,
                            :$raw          = False
  ) {
    (my $ofb = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samdwith(
      $start,
      $end,
      GLib::GSList.new(@users),
      $ofb,
      $cancellable,
      $error
      :all
      :$glist
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  method get_free_busy_sync (
    Int()                   $start,
    Int()                   $end,
    GSList()                $users,
    CArray[Pointer[GSList]] $out_freebusy,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False,
                            :$glist        = False,
                            :$raw          = False
  ) {
    my time_t ($s, $e) = ($start, $end);

    clear_error;
    my $rv = e_cal_client_get_free_busy_sync(
      $!ecal,
      $start,
      $end,
      $users,
      $out_freebusy,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $ofb = ppr($out_freebusy);
    (
      $rv,
      returnGList(
        $ofb,
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  method get_local_attachment_store {
    e_cal_client_get_local_attachment_store($!ecal);
  }

  proto method get_object (|)
  { * }

  multi method get_object (
    Str()        $uid,
    Str()        $rid,
                 &callback,
    gpointer     $user_data    = gpointer,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith(
      $uid,
      $rid,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method get_object (
    Str()        $uid,
    Str()        $rid,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data    = gpointer
  ) {
    e_cal_client_get_object(
      $!ecal, 
      $uid, 
      $rid, 
      $cancellable, 
      $callback, 
      $user_data
    );
  }

  proto method get_object_finish (|)
  { * }

  multi method get_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my $oi = ICalComponent.new;
    my $rv = samewith($result, $oi, $error, :all);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_finish (
    GAsyncResult()          $result,
    ICalComponent()         $out_icalcomp,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_finish(
      $!ecal,
      $result,
      $out_icalcomp,
      $error
    );
    set_error($error);

    return $rv unless $all;

    (
      $rv,
      $raw ?? $out_icalcomp !! ICal::Component.new($out_icalcomp)
    );
  }

  proto method get_object_list (|)
  { * }
  
  multi method get_object_list (
    Str()          $sexp, 
                   &callback, 
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $sexp,
      $cancellable,
      &callback,
      $user_data 
    );
  }
  multi method get_object_list (
    Str()          $sexp, 
    GCancellable() $cancellable, 
                   &callback, 
    gpointer       $user_data = gpointer
  ) {
    e_cal_client_get_object_list(
      $!ecal, 
      $sexp, 
      $cancellable, 
      $callback, 
      $user_data
    );
  }
  
  # ...

  proto method get_object_list_as_comps (|)
  { * }
  
  multi method get_object_list_as_comps (
    Str()          $sexp, 
                   &callback, 
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $sexp, 
      $cancellable, 
      &callback, 
      $user_data
    );
  }
  multi method get_object_list_as_comps (
    Str()          $sexp, 
    GCancellable() $cancellable, 
                   &callback, 
    gpointer       $user_data    = gpointer
  ) {    
    e_cal_client_get_object_list_as_comps(
      $!ecal, 
      $sexp, 
      $cancellable, 
      $callback, 
      $user_data
    );
  }

  proto method get_object_list_as_comps_finish (|)
  { * }

  multi method get_object_list_as_comps_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error          = gerror,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    
    my $rv = samewith($result, $oe, $error, :all, :$glist, :$raw);
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_as_comps_finish (
    GAsyncResult()          $result, 
    CArray[Pointer[GSList]] $out_ecalcomps, 
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_list_as_comps_finish(
      $!ecal, 
      $result, 
      $out_ecalcomps, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_ecalcomps),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  proto method get_object_list_as_comps_sync (|)
  { * }
  
  multi method get_object_list_as_comps_sync (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error          = gerror
    GCancellable()          :$cancellable   = GCancellable, 
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    
    my $rv = samewith(
      $sexp,
      $oe,
      $cancellable 
      $error 
      :all 
      :$glist 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_as_comps_sync (
    Str()                   $sexp, 
    CArray[Pointer[GSList]] $out_ecalcomps, 
    GCancellable()          $cancellable    = GCancellable, 
    CArray[Pointer[GError]] $error          = gerror
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_list_as_comps_sync(
      $!ecal, 
      $sexp, 
      $out_ecalcomps, 
      $cancellable, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_ecalcomps),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  proto method get_object_list_finish (|)
  { * }
  
  multi method get_object_list_finish (
    GAsyncResult()          $result, 
    CArray[Pointer[GError]] $error          = gerror,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    
    my $rv = samewith(
      $result,
      $oe,
      $error 
      :all 
      :$glist 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_finish (
    GAsyncResult()          $result, 
    CArray[Pointer[GSList]] $out_icalcomps, 
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_list_finish(
      $!ecal, 
      $result, 
      $out_icalcomps, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_ecalcomps),
        $glist,
        $raw,
        ICalComponent,
        ICal::Component
      )
    );
  }

  proto method get_object_list_sync (|)
  { * }
  
  multi method get_object_list_sync (
    Str()                   $sexp, 
    CArray[Pointer[GError]] $error          = gerror,
    GCancellable ()         :$cancellable   = GCancellable, 
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    
    my $rv = samewith(
      $sexp,
      $oi,
      $cancellable 
      $error 
      :$all 
      :$glist 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_sync (
    Str()                   $sexp, 
    CArray[Pointer[GSList]] $out_icalcomps, 
    GCancellable ()         $cancellable    = GCancellable, 
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_list_sync(
      $!ecal, 
      $sexp,
      $out_icalcomps, 
      $cancellable, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_icalcomps),
        $glist,
        $raw,
        ICalComponent,
        ICal::Component
      )
    );
  }

  proto method get_object_sync (|)
  { * }
  
  multi method get_object_sync (
    Str()                          $uid, 
    Str()                          $rid, 
    CArray[Pointer[GError]]        $error         = gerror
    GCancellable()                 :$cancellable  = GCancellable, 
                                   :$raw          = False
  ) {
    (my $oi = CArray[Pointer[ICalComponent]])[0] = Pointer[ICalComponent];
    
    my $rv = samewith(
      $uid,
      $rid,
      $oi,
      $cancellable 
      $error 
      :all 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }  
  multi method get_object_sync (
    Str()                          $uid, 
    Str()                          $rid, 
    CArray[Pointer[ICalComponent]] $out_icalcomp, 
    GCancellable()                 $cancellable   = GCancellable, 
    CArray[Pointer[GError]]        $error         = gerror
                                   :$all          = False
                                   :$raw          = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_object_sync(
      $!ecal, 
      $uid, 
      $rid, 
      $out_icalcomp, 
      $cancellable, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    my $oi = ppr($out_icalcomp);
    (
      $rv,
      $oi ??
        ( $raw ?? $oi !! ICal::Component.new($oi) )
        !!
        Nil
    );
  }

  proto method get_objects_for_uid (|)
  { * }
  multi method get_objects_for_uid (
    Str()          $uid, 
                   &callback, 
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $uid, 
      $cancellable, 
      &callback, 
      $user_data
    )
  }
  multi method get_objects_for_uid (
    Str()          $uid, 
    GCancellable() $cancellable, 
                   &callback, 
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_get_objects_for_uid(
      $!ecal, 
      $uid, 
      $cancellable, 
      $callback, 
      $user_data
    );
  }

  proto method get_objects_for_uid_finish (|)
  { * }
  
  multi method get_objects_for_uid_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error          = gerror,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    
    my $rv = samewith(
      $result,
      $oe,
      $error 
      :all 
      :$glist 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  method get_objects_for_uid_finish (
    GAsyncResult()          $result, 
    CArray[Pointer[GSList]] $out_ecalcomps, 
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False,
  ) {
    clear_error;
    my $rv = e_cal_client_get_objects_for_uid_finish(
      $!ecal, 
      $result, 
      $out_ecalcomps, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_ecalcomps),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  proto method get_objects_for_uid_sync (|)
  { * }
  
  multi method get_objects_for_uid_sync (
    Str()                   $uid, 
    CArray[Pointer[GError]] $error          = gerror
    GCancellable            :$cancellable   = GCancellable, 
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samewith(
      $uid,
      $oe,
      $cancellable,
      $error, 
      :all 
      :$glist 
      :$raw 
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }

  multi method get_objects_for_uid_sync (
    Str()                   $uid, 
    CArray[GSList]]         $out_ecalcomps, 
    GCancellable()          $cancellable    = GCancellable, 
    CArray[Pointer[GError]] $error          = gerror
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_objects_for_uid_sync(
      $!ecal, 
      $uid, 
      $out_ecalcomps, 
      $cancellable, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      returnGList(
        ppr($out_ecalcomps),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  method get_source_type {
    ECalClientSourceTypeEnum( e_cal_client_get_source_type($!ecal) );
  }

  proto method get_timezone (|)
  { * }
  
  multi method get_timezone (
    Str()          $tzid, 
                   &callback, 
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $tzid,
      $cancellable,
      &callback,
      $user_data 
    );
  }
  multi method get_timezone (
    Str()          $tzid, 
    GCancellable() $cancellable, 
                   &callback, 
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_get_timezone($!ecal, $tzid, $cancellable, $callback, $user_data);
  }

  proto method get_timezone_finish (|)
  { * }
  
  method get_timezone_finish (
    GAsyncResult()                $result, 
    CArray[Pointer[GError]]       $error   = gerror,
                                  :$raw    = False
  ) {
    (my $oz = CArray[Pointer[ICalTimezone]].new)[0] = Pointer[ICalTimezone];

    my $rv = samewith(
      $result, 
      $out_zone, 
      $error,
      :all,
      :$raw
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  method get_timezone_finish (
    GAsyncResult()                $result, 
    CArray[Pointer[ICalTimezone]] $out_zone, 
    CArray[Pointer[GError]]       $error     = gerror,
                                  :$all      = False,
                                  :$raw      = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_timezone_finish(
      $!ecal, 
      $result, 
      $out_zone, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      $oi ??
        ( $raw ?? $oi !! ICal::Timezone.new($oi) )
        !!
        Nil
    );
  }

  proto method get_timezone_sync (|)
  { * }
  
  multi method get_timezone_sync (
    Str()                         $tzid,
    CArray[Pointer[GError]]       $error        = gerror,
    GCancellable()                :$cancellable = GCancellable,
                                  :$raw         = False
  ) {
    (my $oz = CArray[Pointer[ICalTimezone]].new)[0] = Pointer[ICalTimezone];
    
    my $rv = samewith(
      $tzid,
      $out_zone,
      $cancellable,
      $error,
      :all,
      :$raw
    );
    
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_timezone_sync (
    Str()                         $tzid, 
    CArray[Pointer[ICalTimezone]] $out_zone, 
    GCancellable()                $cancellable  = GCancellable, 
    CArray[Pointer[GError]]       $error        = gerror,
                                  :$all         = False,
                                  :$raw         = False
  ) {
    clear_error;
    my $rv = e_cal_client_get_timezone_sync(
      $!ecal, 
      $tzid, 
      $out_zone, 
      $cancellable, 
      $error
    );
    set_error($error);
    
    return $rv unless $all;
    
    (
      $rv,
      $oi ??
        ( $raw ?? $oi !! ICal::Timezone.new($oi) )
        !!
        Nil
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      e_cal_client_get_type,
      $n,
      $t
    );
  }

  method get_view (Str $sexp, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_get_view($!ecal, $sexp, $cancellable, $callback, $user_data);
  }

  method get_view_finish (GAsyncResult $result, ECalClientView $out_view, CArray[Pointer[GError]] $error) {
    e_cal_client_get_view_finish($!ecal, $result, $out_view, $error);
  }

  method get_view_sync (Str $sexp, ECalClientView $out_view, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_get_view_sync($!ecal, $sexp, $out_view, $cancellable, $error);
  }

  method modify_object (ICalComponent $icalcomp, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_modify_object($!ecal, $icalcomp, $mod, $opflags, $cancellable, $callback, $user_data);
  }

  method modify_object_finish (GAsyncResult $result, CArray[Pointer[GError]] $error) {
    e_cal_client_modify_object_finish($!ecal, $result, $error);
  }

  method modify_object_sync (ICalComponent $icalcomp, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_modify_object_sync($!ecal, $icalcomp, $mod, $opflags, $cancellable, $error);
  }

  method modify_objects (GSList $icalcomps, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_modify_objects($!ecal, $icalcomps, $mod, $opflags, $cancellable, $callback, $user_data);
  }

  method modify_objects_finish (GAsyncResult $result, CArray[Pointer[GError]] $error) {
    e_cal_client_modify_objects_finish($!ecal, $result, $error);
  }

  method modify_objects_sync (GSList $icalcomps, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_modify_objects_sync($!ecal, $icalcomps, $mod, $opflags, $cancellable, $error);
  }

  method receive_objects (ICalComponent $icalcomp, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_receive_objects($!ecal, $icalcomp, $opflags, $cancellable, $callback, $user_data);
  }

  method receive_objects_finish (GAsyncResult $result, CArray[Pointer[GError]] $error) {
    e_cal_client_receive_objects_finish($!ecal, $result, $error);
  }

  method receive_objects_sync (ICalComponent $icalcomp, guint32 $opflags, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_receive_objects_sync($!ecal, $icalcomp, $opflags, $cancellable, $error);
  }

  method remove_object (Str $uid, Str $rid, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_remove_object($!ecal, $uid, $rid, $mod, $opflags, $cancellable, $callback, $user_data);
  }

  method remove_object_finish (GAsyncResult $result, CArray[Pointer[GError]] $error) {
    e_cal_client_remove_object_finish($!ecal, $result, $error);
  }

  method remove_object_sync (Str $uid, Str $rid, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_remove_object_sync($!ecal, $uid, $rid, $mod, $opflags, $cancellable, $error);
  }

  method remove_objects (GSList $ids, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_remove_objects($!ecal, $ids, $mod, $opflags, $cancellable, $callback, $user_data);
  }

  method remove_objects_finish (GAsyncResult $result, CArray[Pointer[GError]] $error) {
    e_cal_client_remove_objects_finish($!ecal, $result, $error);
  }

  method remove_objects_sync (GSList $ids, ECalObjModType $mod, guint32 $opflags, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_remove_objects_sync($!ecal, $ids, $mod, $opflags, $cancellable, $error);
  }

  method send_objects (ICalComponent $icalcomp, guint32 $opflags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    e_cal_client_send_objects($!ecal, $icalcomp, $opflags, $cancellable, $callback, $user_data);
  }

  method send_objects_finish (GAsyncResult $result, GSList $out_users, ICalComponent $out_modified_icalcomp, CArray[Pointer[GError]] $error) {
    e_cal_client_send_objects_finish($!ecal, $result, $out_users, $out_modified_icalcomp, $error);
  }

  method send_objects_sync (ICalComponent $icalcomp, guint32 $opflags, GSList $out_users, ICalComponent $out_modified_icalcomp, GCancellable $cancellable, CArray[Pointer[GError]] $error) {
    e_cal_client_send_objects_sync($!ecal, $icalcomp, $opflags, $out_users, $out_modified_icalcomp, $cancellable, $error);
  }

  method set_default_timezone (ICalTimezone $zone) {
    e_cal_client_set_default_timezone($!ecal, $zone);
  }

}
