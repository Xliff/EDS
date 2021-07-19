use v6.c;

use Method::Also;

use NativeCall;

use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar;

use GLib::GList;
use ICal::GLib::Component;
use Evolution::Client;

use Evolution::Roles::TimezoneCache;

our subset ECalClientAncestry is export of Mu
  where ECalClient | ETimezoneCache | EClientAncestry;

class Evolution::Calendar is Evolution::Client {
  also does Evolution::Roles::TimezoneCache;

  has ECalClient $!ecal is implementor;

  submethod BUILD (:$calendar) {
    self.setECalClient($calendar) if $calendar;
  }

  method setECalClient (ECalClientAncestry $_) {
    my $to-parent;

    $!ecal = do {
      when ECalClient {
        $to-parent = cast(EClient, $_);
        $_;
      }

      when ETimezoneCache {
        $to-parent = cast(EClient, $_);
        $!etzc = $_;
        cast(ECalClient, $_);
      }

      default {
        $to-parent = $_;
        cast(ECalClient, $_);
      }
    }
    self.setEClient($to-parent);
    self.roleInit-ETimezoneCache;
  }

  method Evolution::Raw::Definitions::ECalClient
    is also<ECalClient>
  { $!ecal }

  method new (ECalClientAncestry $calendar, :$ref = True) {
    return Nil unless $calendar;

    my $o = self.bless( :$calendar );
    $o.ref if $ref;
    $o;
  }

  proto method add_timezone (|)
      is also<add-timezone>
  { * }

  multi method add_timezone (
    ICalTimezone() $zone,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($zone, $cancellable, &callback, $user_data);
  }
  multi method add_timezone (
    ICalTimezone() $zone,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_add_timezone(
      $!ecal,
      $zone,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method add_timezone_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<add-timezone-finish>
  {
    clear_error;
    my $rv = so e_cal_client_add_timezone_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method add_timezone_sync (
    ICalTimezone()          $zone,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-timezone-sync>
  {
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

  method check_one_alarm_only is also<check-one-alarm-only> {
    so e_cal_client_check_one_alarm_only($!ecal);
  }

  method check_organizer_must_accept is also<check-organizer-must-accept> {
    so e_cal_client_check_organizer_must_accept($!ecal);
  }

  method check_organizer_must_attend is also<check-organizer-must-attend> {
    so e_cal_client_check_organizer_must_attend($!ecal);
  }

  method check_recurrences_no_master is also<check-recurrences-no-master> {
    so e_cal_client_check_recurrences_no_master($!ecal);
  }

  method check_save_schedules is also<check-save-schedules> {
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
  )
    is also<connect-finish>
  {
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
  )
    is also<connect-sync>
  {
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
      is also<create-object>
  { * }

  multi method create_object (
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
  multi method create_object (
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
      &callback,
      $user_data
    );
  }

  proto method create_object_finish (|)
      is also<create-object-finish>
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
      is also<create-object-sync>
  { * }

  multi method create_object_sync (
    ICalComponent()         $icalcomp,
    Int()                   $opflags      = E_CAL_OPERATION_FLAG_NONE,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable            :$cancellable = GCancellable
  ) {
    (my $ou = CArray[Str].new)[0] = Str;

    my $rv = samewith(
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
    ICalComponent()         $icalcomp,
    Int()                   $opflags,
    CArray[Str]             $out_uid,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror,
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
      is also<create-objects>
  { * }

  multi method create_objects (
                 @icalcomps,
    Int()        $opflags,
                 &callback,
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
                 &callback,
    gpointer     $user_data
  ) {
    my guint32 $o = $opflags;

    e_cal_client_create_objects(
      $!ecal,
      $icalcomps,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method create_objects_finish (|)
      is also<create-objects-finish>
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
      is also<create-objects-sync>
  { * }

  multi method create_objects_sync (
    GSList()                $icalcomps,
    Int()                   $opflags,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$glist       = False,
                            :$raw         = False
  ) {
    my guint32 $o = $opflags;

    my $rv = samewith(
      $icalcomps,
      $o,
      $,
      $cancellable,
      $error,
      :all,
      :$glist,
      :$raw,
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method create_objects_sync (
    GSList()                $icalcomps,
    Int()                   $opflags,
                            $out_uids    is rw,
    GCancellable()          $cancellable =  GCancellable,
    CArray[Pointer[GError]] $error       =  gerror,
                            :$glist      =  False,
                            :$raw        =  False;
                            :$all        =  False
  ) {
    my guint32 $o = $opflags;

    ($out_uids = CArray[Pointer[GSList]].new)[0] = Pointer[GSList]
      unless $out_uids;

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
    $out_uids = returnGList( ppr($out_uids), $glist, $raw );
    ( $rv, $out_uids )
  }

  proto method discard_alarm (|)
      is also<discard-alarm>
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
      &callback,
      $user_data
    );
  }

  method discard_alarm_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<discard-alarm-finish>
  {
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
  )
    is also<discard-alarm-sync>
  {
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

  method error_to_string (Evolution::Calendar:U: Int() $code)
    is also<error-to-string>
  {
    my ECalClientError $c = $code;

    e_cal_client_error_to_string($c);
  }

  proto method generate_instances (|)
      is also<generate-instances>
  { * }

  multi method generate_instances (
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
  multi method generate_instances (
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
      is also<generate-instances-for-object>
  { * }

  multi method generate_instances_for_object (
    ICalComponent() $icalcomp,
    Int()           $start,
    Int()           $end,
                    &cb,
    gpointer        $cb_data         = gpointer,
                    &destroy_cb_data = Callable,
    GCancellable()  :$cancellable    = GCancellable
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
      is also<generate-instances-for-object-sync>
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
      is also<generate-instances-sync>
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
      is also<get-attachment-uris>
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
      is also<get-attachment-uris-finish>
  { * }

  multi method get_attachment_uris_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror,
                            :$glist = False,
                            :$raw   = False
  ) {
    my $rv = samewith(
      $result,
      $,
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }

  multi method get_attachment_uris_finish (
    GAsyncResult()          $result,
                            $out_attachment_uris  is rw,
    CArray[Pointer[GError]] $error                =  gerror,
                            :$all                 =  False,
                            :$glist               =  False,
                            :$raw                 =  False
  ) {
    clear_error;
    ($out_attachment_uris = CArray[Pointer[GSList]].new)[0] = Pointer[GSList]
      unless $out_attachment_uris;
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
      is also<get-attachment-uris-sync>
  { * }

  multi method get_attachment_uris_sync (
    Str                     $uid,
    Str                     $rid,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = gerror,
                            :$all                 = False,
                            :$glist               = False,
                            :$raw                 = False
  ) {
    samewith(
      $uid,
      $rid,
      $,
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
    CArray[Pointer[GError]] $error                = gerror,
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

  method get_component_as_string (ICalComponent() $icalcomp)
    is also<get-component-as-string>
  {
    e_cal_client_get_component_as_string($!ecal, $icalcomp);
  }

  proto method get_default_object (|)
      is also<get-default-object>
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
      &callback,
      $user_data
    );
  }

  proto method get_default_object_finish (|)
      is also<get-default-object-finish>
  { * }

  multi method get_default_object_finish (
    GAsyncResult()                 $result,
    CArray[Pointer[GError]]        $error         = gerror
  ) {
    my $rv = samewith($result, $, $error);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_default_object_finish (
    GAsyncResult()                 $result,
                                   $out_icalcomp  is rw,
    CArray[Pointer[GError]]        $error         =  gerror,
                                   :$all          =  False,
                                   :$raw          =  False
  ) {
    clear_error;

    unless $out_icalcomp {
      ($out_icalcomp = CArray[Pointer[ICalComponent]].new)[0] =
        CArray[Pointer[ICalComponent]]
    }
    my $rv = so e_cal_client_get_default_object_finish(
      $!ecal,
      $result,
      $out_icalcomp,
      $error
    );
    set_error($error);

    return $rv unless $all;

    (
      $rv,
      # cw: Warning. Doing a lot here, and trying to be compact. Feel free
      #     to break this up if it isn't reliable.
      $out_icalcomp = ( $out_icalcomp = ppr($out_icalcomp) ) ??
        ( $raw ?? $out_icalcomp !! ICal::Component.new($out_icalcomp) )
        !!
        Nil
    )
  }

  proto method get_default_object_sync (|)
      is also<get-default-object-sync>
  { * }

  multi method get_default_object_sync (
    CArray[Pointer[GError]]        $error         = gerror,
    GCancellable()                 :$cancellable  = GCancellable,
                                   :$raw          = False
  ) {
    my $rv = samewith($, $cancellable, $error, :all, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_default_object_sync (
                                   $out_icalcomp  is rw,
    GCancellable()                 $cancellable   =  GCancellable,
    CArray[Pointer[GError]]        $error         =  gerror,
                                   :$all          =  False,
                                   :$raw          =  False
  ) {
    ($out_icalcomp = CArray[Pointer[ICalComponent]].new)[0] =
      Pointer[ICalComponent]
    unless $out_icalcomp;

    clear_error;
    my $rv = so e_cal_client_get_default_object_sync(
      $!ecal,
      $out_icalcomp,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    (
      $rv,
      $out_icalcomp = ( $out_icalcomp = ppr($out_icalcomp) ) ??
        ( $raw ?? $out_icalcomp !! ICal::Component.new($out_icalcomp) )
        !!
        Nil
    )
  }

  method get_default_timezone (:$raw = False) is also<get-default-timezone> {
    #ICalTimezone
    my $tz = e_cal_client_get_default_timezone($!ecal);

    $tz ??
      ( $raw ?? $tz !! ICal::Timezone.new($tz) )
      !!
      Nil;
  }

  proto method get_free_busy (|)
    is also<get-free-busy>
  { * }

  multi method get_free_busy (
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
  multi method get_free_busy (
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
      is also<get-free-busy-finish>
  { * }

  multi method get_free_busy_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$glist  = False,
                            :$raw    = False
  ) {
    my $rv = samewith($result, $, $error, :all, :$glist, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_free_busy_finish (
    GAsyncResult()          $result,
                            $out_freebusy  is rw,
    CArray[Pointer[GError]] $error         =  gerror,
                            :$all          =  False,
                            :$glist        =  False,
                            :$raw          =  False
  ) {
    ($out_freebusy = CArray[Pointer[GSList]].new)[0] =
      CArray[Pointer[GSList]]
    unless $out_freebusy;

    clear_error;
    my $rv = e_cal_client_get_free_busy_finish(
      $!ecal,
      $result,
      $out_freebusy,
      $error
    );
    set_error($error);

    return $rv unless $all;

    (
      $rv,
      returnGList(
        ppr($out_freebusy),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  proto method get_free_busy_sync (|)
      is also<get-free-busy-sync>
  { * }

  multi method get_free_busy_sync (
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

    my $rv = samewith(
      $start,
      $end,
      GLib::GSList.new(@users),
      $ofb,
      $cancellable,
      $error,
      :all,
      :$glist
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_free_busy_sync (
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

  method get_local_attachment_store is also<get-local-attachment-store> {
    e_cal_client_get_local_attachment_store($!ecal);
  }

  proto method get_object (|)
      is also<get-object>
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
      &callback,
      $user_data
    );
  }

  proto method get_object_finish (|)
      is also<get-object-finish>
  { * }

  multi method get_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    my $rv = samewith($result, $, $error, :all, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_finish (
    GAsyncResult()          $result,
                            $out_icalcomp  is rw ,
    CArray[Pointer[GError]] $error         =  gerror,
                            :$all          =  False,
                            :$raw          =  False
  ) {
    ($out_icalcomp = CArray[ICalComponent].new)[0] = ICalComponent
      unless $out_icalcomp;

    clear_error;
    my $rv = e_cal_client_get_object_finish(
      $!ecal,
      $result,
      $out_icalcomp,
      $error
    );
    set_error($error);

    return $rv unless $all;

    $out_icalcomp = ppr($out_icalcomp);
    (
      $rv,
      $out_icalcomp = $raw ?? $out_icalcomp
                           !! ICal::Component.new($out_icalcomp)
    );
  }

  proto method get_object_list (|)
      is also<get-object-list>
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
      &callback,
      $user_data
    );
  }

  # ...

  proto method get_object_list_as_comps (|)
      is also<get-object-list-as-comps>
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
      &callback,
      $user_data
    );
  }

  proto method get_object_list_as_comps_finish (|)
      is also<get-object-list-as-comps-finish>
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
      is also<get-object-list-as-comps-sync>
  { * }

  multi method get_object_list_as_comps_sync (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error          = gerror,
    GCancellable()          :$cancellable   = GCancellable,
                            :$all           = False,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oe = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samewith(
      $sexp,
      $oe,
      $cancellable,
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_as_comps_sync (
    Str()                   $sexp,
    CArray[Pointer[GSList]] $out_ecalcomps,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror,
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
      is also<get-object-list-finish>
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
      $error,
      :all,
      :$glist,
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
        ppr($out_icalcomps),
        $glist,
        $raw,
        ICalComponent,
        ICal::GLib::Component
      )
    );
  }

  proto method get_object_list_sync (|)
      is also<get-object-list-sync>
  { * }

  multi method get_object_list_sync (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error          = gerror,
    GCancellable()          :$cancellable   = GCancellable,
                            :$glist         = False,
                            :$raw           = False
  ) {
    (my $oi = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samewith(
      $sexp,
      $oi,
      $cancellable,
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_list_sync (
    Str()                   $sexp,
    CArray[Pointer[GSList]] $out_icalcomps,
    GCancellable()          $cancellable    = GCancellable,
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
        ICal::GLib::Component
      )
    );
  }

  proto method get_object_sync (|)
      is also<get-object-sync>
  { * }

  multi method get_object_sync (
    Str()                          $uid,
    Str()                          $rid,
    CArray[Pointer[GError]]        $error         = gerror,
    GCancellable()                 :$cancellable  = GCancellable,
                                   :$raw          = False
  ) {
    (my $oi = CArray[Pointer[ICalComponent]])[0] = Pointer[ICalComponent];

    my $rv = samewith(
      $uid,
      $rid,
      $oi,
      $cancellable,
      $error,
      :all,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_object_sync (
    Str()                          $uid,
    Str()                          $rid,
    CArray[Pointer[ICalComponent]] $out_icalcomp,
    GCancellable()                 $cancellable   = GCancellable,
    CArray[Pointer[GError]]        $error         = gerror,
                                   :$all          = False,
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
      is also<get-objects-for-uid>
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
      &callback,
      $user_data
    );
  }

  proto method get_objects_for_uid_finish (|)
      is also<get-objects-for-uid-finish>
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
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_objects_for_uid_finish (
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
      is also<get-objects-for-uid-sync>
  { * }

  multi method get_objects_for_uid_sync (
    Str()                   $uid,
    CArray[Pointer[GError]] $error          = gerror,
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
    CArray[Pointer[GSList]] $out_ecalcomps,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror,
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

  method get_source_type is also<get-source-type> {
    ECalClientSourceTypeEnum( e_cal_client_get_source_type($!ecal) );
  }

  proto method get_timezone (|)
      is also<get-timezone>
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
    e_cal_client_get_timezone(
      $!ecal,
      $tzid,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_timezone_finish (|)
      is also<get-timezone-finish>
  { * }

  multi method get_timezone_finish (
    GAsyncResult()                $result,
    CArray[Pointer[GError]]       $error   = gerror,
                                  :$raw    = False
  ) {
    (my $oz = CArray[Pointer[ICalTimezone]].new)[0] = Pointer[ICalTimezone];

    my $rv = samewith(
      $result,
      $oz,
      $error,
      :all,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_timezone_finish (
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

    my $oz = ppr($out_zone);
    (
      $rv,
      $oz ??
        ( $raw ?? $oz !! ICal::Timezone.new($oz) )
        !!
        Nil
    );
  }

  proto method get_timezone_sync (|)
      is also<get-timezone-sync>
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
      $oz,
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

    my $oz = ppr($out_zone);
    (
      $rv,
      $oz ??
        ( $raw ?? $oz !! ICal::Timezone.new($oz) )
        !!
        Nil
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      e_cal_client_get_type,
      $n,
      $t
    );
  }


  proto method get_view (|)
      is also<get-view>
  { * }

  multi method get_view (
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
  multi method get_view (
    Str()          $sexp,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_client_get_view($!ecal, $sexp, $cancellable, &callback, $user_data);
  }

  proto method get_view_finish (|)
      is also<get-view-finish>
  { * }

  multi method get_view_finish (
    GAsyncResult()                  $result,
    CArray[Pointer[GError]]         $error     = gerror
  ) {
    (my $ov = CArray[Pointer[ECalClientView]].new)[0] = Pointer[ECalClientView];

    my $rv = samewith($result, $ov, $error);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_view_finish (
    GAsyncResult()                  $result,
    CArray[Pointer[ECalClientView]] $out_view,
    CArray[Pointer[GError]]         $error     = gerror,
                                    :$all      = False,
                                    :$raw      = False
  ) {
    clear_error;
    my $rv = so e_cal_client_get_view_finish(
      $!ecal,
      $result,
      $out_view,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $ov = ppr($out_view);
    (
      $rv,
      $ov ??
        ( $raw ?? $ov !! Evolution::Calendar::ClientView.new($ov) )
        !!
        Nil
     )
  }

  proto method get_view_sync (|)
    is also<get-view-sync>
  { * }

  multi method get_view_sync (
    Str()                           $sexp,
    CArray[Pointer[GError]]         $error        = gerror,
    GCancellable()                  :$cancellable = GCancellable,
                                    :$raw         = False
  ) {
    my $rv = samewith($sexp, $, $cancellable, $error, :all, :$raw);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method get_view_sync (
    Str()                           $sexp,
                                    $out_view     is rw,
    GCancellable()                  $cancellable  =  GCancellable,
    CArray[Pointer[GError]]         $error        =  gerror,
                                    :$all         =  False,
                                    :$raw         =  False
  ) {
    ($out_view = CArray[Pointer[ECalClientView]].new)[0] =
      Pointer[ECalClientView];

    clear_error;
    my $rv = so e_cal_client_get_view_sync(
      $!ecal,
      $sexp,
      $out_view,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $ov = ppr($out_view);
    (
      $rv,
      $ov ??
        ( $raw ?? $ov !! Evolution::Calendar::ClientView.new($ov) )
        !!
        Nil
     )
  }

  proto method modify_object (|)
      is also<modify-object>
  { * }

  multi method modify_object (
    ICalComponent() $icalcomp,
    Int()           $mod,
    Int()           $opflags,
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable()  :$cancellable = GCancellable
  ) {
    samewith(
      $icalcomp,
      $mod,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method modify_object (
    ICalComponent() $icalcomp,
    Int()           $mod,
    Int()           $opflags,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_modify_object(
      $!ecal,
      $icalcomp,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method modify_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<modify-object-finish>
  {
    clear_error;
    my $rv = so e_cal_client_modify_object_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method modify_object_sync (
    ICalComponent()         $icalcomp,
    Int()                   $mod         = E_CAL_OBJ_MOD_ALL,
    Int()                   $opflags     = E_CAL_OPERATION_FLAG_NONE,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<modify-object-sync>
  {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    my $rv = so e_cal_client_modify_object_sync(
      $!ecal,
      $icalcomp,
      $m,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method modify_objects (|)
      is also<modify-objects>
  { * }

  multi method modify_objects (
    GSList()       $icalcomps,
    Int()          $mod,
    Int()          $opflags,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $icalcomps,
      $mod,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method modify_objects (
    GSList()       $icalcomps,
    Int()          $mod,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_modify_objects(
      $!ecal,
      $icalcomps,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method modify_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<modify-objects-finish>
  {
    clear_error;
    my $rv = so e_cal_client_modify_objects_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method modify_objects_sync (
    GSList()                $icalcomps,
    Int()                   $mod,
    Int()                   $opflags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<modify-objects-sync>
  {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_modify_objects_sync(
      $!ecal,
      $icalcomps,
      $mod,
      $o,
      $cancellable,
      $error
    );
  }

  proto method receive_objects (|)
      is also<receive-objects>
  { * }

  multi method receive_objects (
    ICalComponent() $icalcomp,
    Int()           $opflags,
    GCancellable    $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    samewith(
      $icalcomp,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method receive_objects (
    ICalComponent() $icalcomp,
    Int()           $opflags,
    GCancellable    $cancellable,
                    &callback,
    gpointer        $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_cal_client_receive_objects(
      $!ecal,
      $icalcomp,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method receive_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<receive-objects-finish>
  {
    clear_error;
    my $rv = so e_cal_client_receive_objects_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  multi method receive_objects_sync (
    ICalComponent()         $icalcomp,
    Int()                   $opflags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<receive-objects-sync>
  {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_client_receive_objects_sync(
      $!ecal,
      $icalcomp,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_object (|)
      is also<remove-object>
  { * }

  multi method remove_object (
    Str()          $uid,
    Str()          $rid,
    Int()          $mod,
    Int()          $opflags,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable,
  ) {
    samewith(
      $uid,
      $rid,
      $mod,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method remove_object (
    Str()          $uid,
    Str()          $rid,
    Int()          $mod,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data   = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_remove_object(
      $!ecal,
      $uid,
      $rid,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method remove_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<remove-object-finish>
  {
    clear_error;
    my $rv = so e_cal_client_remove_object_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_object_sync (
    Str()                   $uid,
    Str()                   $rid,
    Int()                   $mod         = E_CAL_OBJ_MOD_ALL,
    Int()                   $opflags     = E_CAL_OPERATION_FLAG_NONE,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<remove-object-sync>
  {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    my $rv = so e_cal_client_remove_object_sync(
      $!ecal,
      $uid,
      $rid,
      $m,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_objects (|)
      is also<remove-objects>
  { * }

  multi method remove_objects (
    GSList()       $ids,
    Int()          $mod,
    Int()          $opflags,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $ids,
      $mod,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method remove_objects (
    GSList()       $ids,
    Int()          $mod,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data   = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_remove_objects(
      $!ecal,
      $ids,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method remove_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  )
    is also<remove-objects-finish>
  {
    clear_error;
    my $rv = so e_cal_client_remove_objects_finish($!ecal, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_objects_sync (
    GSList()        $ids,
    Int()           $mod,
    Int()           $opflags,
    GCancellable()  $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-objects-sync>
  {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_client_remove_objects_sync(
      $!ecal,
      $ids,
      $m,
      $o,
      $cancellable,
      $error
    );
  }

  proto method send_objects (|)
      is also<send-objects>
  { * }

  multi method send_objects (
    ICalComponent()  $icalcomp,
    Int()            $opflags,
                     &callback,
    gpointer         $user_data    = gpointer,
    GCancellable()   :$cancellable = GCancellable
  ) {
    samewith(
      $icalcomp,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method send_objects (
    ICalComponent()  $icalcomp,
    Int()            $opflags,
    GCancellable()   $cancellable,
                     &callback,
    gpointer         $user_data   = gpointer
  ) {
    my guint32 $o = $opflags;

    e_cal_client_send_objects(
      $!ecal,
      $icalcomp,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method send_objects_finish (|)
      is also<send-objects-finish>
  { * }

  multi method send_objects_finish (
    GAsyncResult()                 $result,
    CArray[Pointer[GError]]        $error,
                                   :gslist(:$glist)        = False,
                                   :$raw                   = False
  ) {
    (my $ou  = CArray[Pointer[GSList]].new)[0]        = Pointer[GSList];
    (my $omi = CArray[Pointer[ICalComponent]].new)[0] = Pointer[ICalComponent];

    my $rv = samewith(
      $result,
      $ou,
      $omi,
      $error,
      :$glist
      :all
      :$raw
    );

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method send_objects_finish (
    GAsyncResult()                 $result,
    CArray[Pointer[GSList]]        $out_users,
    CArray[Pointer[ICalComponent]] $out_modified_icalcomp,
    CArray[Pointer[GError]]        $error,
                                   :gslist(:$glist)        = False,
                                   :$all                   = False,
                                   :$raw                   = False
  ) {
    clear_error;
    my $rv = e_cal_client_send_objects_finish(
      $!ecal,
      $result,
      $out_users,
      $out_modified_icalcomp,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my $omi = ppr($out_modified_icalcomp);
    (
      $rv,
      returnGList(
        $out_users,
        $glist,
        $raw
      ),
      $omi ??
         ( $raw ?? $omi !! ICalendar::Component.new($omi) )
         !!
         Nil
     )
  }

  proto method send_objects_sync (|)
      is also<send-objects-sync>
  { * }

  multi method send_objects_sync (
    ICalComponent()                $icalcomp,
    Int()                          $opflags,
    CArray[Pointer[GError]]        $error                  = gerror,
    GCancellable()                 :$cancellable           = GCancellable,
                                   :gslist(:$glist)        = False,
                                   :$raw                   = False
  ) {
    (my $ou  = CArray[Pointer[GSList]].new)[0]        = Pointer[GSList];
    (my $omi = CArray[Pointer[ICalComponent]].new)[0] = Pointer[ICalComponent];

    my $rv = samewith(
      $icalcomp,
      $opflags,
      $ou,
      $omi,
      $cancellable,
      $error,
      :all,
      :$glist,
      :$raw
    );

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method send_objects_sync (
    ICalComponent()                $icalcomp,
    Int()                          $opflags,
    CArray[Pointer[GSList]]        $out_users,
    CArray[Pointer[ICalComponent]] $out_modified_icalcomp,
    GCancellable()                 $cancellable            = GCancellable,
    CArray[Pointer[GError]]        $error                  = gerror,
                                   :$all                   = False,
                                   :gslist(:$glist)        = False,
                                   :$raw                   = False

  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_client_send_objects_sync(
      $!ecal,
      $icalcomp,
      $o,
      $out_users,
      $out_modified_icalcomp,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    my ($ou, $omi) = ppr($out_users, $out_modified_icalcomp);
    (
      $rv,
      returnGList($ou, $glist, $raw),
      $omi ??
        ( $raw ?? $omi !! ICalendar::Component.new($omi) )
        !!
        Nil
    )
  }

  method set_default_timezone (ICalTimezone() $zone)
    is also<set-default-timezone>
  {
    e_cal_client_set_default_timezone($!ecal, $zone);
  }

}
