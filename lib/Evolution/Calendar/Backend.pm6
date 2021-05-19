use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Backend::Calendar;

use ICal::Raw::Enums;
use GLib::GList;
use GLib::Queue;
use GIO::SimpleAsyncResult;
use Evolution::Backend;
use Evolution::DataCal;
use Evolution::DataCal::View;
use Evolution::Source::Registry;

use GIO::Roles::ProxyResolver;
use Evolution::Roles::TimezoneCache;

our subset ECalendarBackendAncestry is export of Mu
  where ECalendarBackend | ETimezoneCache | EDBusServerAncestry;

class Evolution::Calendar::Backend is Evolution::Backend {
  also does Evolution::Roles::TimezoneCache;

  has ECalBackend $!ecb is implementor;

  submethod BUILD (:$calendar-backend) {
    self.setECalendarBackend($calendar-backend) if $calendar-backend;
  }

  method setECalendarBackend (ECalendarBackendAncestry $_) {
    my $to-parent;

    $!ecb = do {
      when ECalendarBackend {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when ETimezoneCache {
        $to-parent = cast(GObject, $_);
        $!etzc = $_;
        cast(ECalendarBackend, $_);
      }

      default {
        $to-parent = $_;
        cast(ECalendarBackend, $_);
      }
    }
    self.setEBackend($to-parent);
    self.roleInit-ETimezoneCache;
  }

  method Evolution::Raw::Definitions::ECalendarBackend
  { $!ecb }

  method new (ECalendarBackendAncestry $calendar-backend, :$ref = True) {
    return Nil unless $calendar-backend;

    my $o = self.bless( :$calendar-backend );
    $o.ref if $ref;
    $o;
  }

  proto method add_timezone (|)
  { * }

  multi method add_timezone (
                   $tzobject,
                   &callback,
    gpointer       $user_data    = gpointer
                   :$cancellable = GCancellable,
  ) {
    samewith(
      $tzobject,
      $cancellable,
      $callback,
      $user_data
    );
  }
  multi method add_timezone (
    Str()          $tzobject,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_cal_backend_add_timezone(
      $!ecb,
      $tzobject,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method add_timezone_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_add_timezone_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  method add_timezone_sync (
    Str()                   $tzobject,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_add_timezone_sync(
      $!ecb,
      $tzobject,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method add_view (EDataCalView() $view) {
    e_cal_backend_add_view($!ecb, $view);
  }

  method create_cache_filename (Str() $uid, Str() $filename, Int() $fileindex) {
    my gint $f = $fileindex;

    e_cal_backend_create_cache_filename($!ecb, $uid, $filename, $f);
  }

  proto method create_objects (|)
  { * }

  multi method create_objects (
    Str()          $calobjs,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $calobjs,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create_objects (
    Str()          $calobjs,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_cal_backend_create_objects(
      $!ecb,
      $calobjs,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_objects_finish (
    GAsyncResult()          $result,
    GQueue()                $out_uids = GQueue.new,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_create_objects_finish(
      $!ecb,
      $result,
      $out_uids,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method create_objects_sync (|)
  { * }

  multi method create_objects_sync (
                            $calobjs,
    CArray[Pointer[GError]] $error        = gerror,
                            :$opflags     = 0,
                            :$out_uids    = GQueue.new,
                            :$cancellable = GCancellable,
                            :$raw         = False,
                            :$array       = True
  ) {
    samewith(
      $calobjs,
      $opflags,
      $out_uids,
      $cancellable,
      $error
    );

    my $q = $out_uids ??
      ( $raw ?? $out_uids !! GLib::Queue.new($out_uids, :!ref) )
      !!
      Nil;

    return $q unless $array || $raw.not;

    ( $q but GLib::Roles::TypedQueue[Str] ).Array;
  }
  multi method create_objects_sync (
    Str()                   $calobjs,
    Int()                   $opflags,
    GQueue()                $out_uids,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_create_objects_sync(
      $!ecb,
      $calobjs,
      $o,
      $out_uids,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method discard_alarm (|)
  { * }

  multi method discard_alarm (
                   $uid,
                   $alarm_uid,
                   &callback,
    gpointer       $user_data    = gpointer,
                   :$rid         = Str,
                   :$opflags     = 0,
                   :$cancellable = GCancellable
  ) {
    samewith(
      $uid,
      $rid,
      $alarm_uid,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method discard_alarm (
    Str()          $uid,
    Str()          $rid,
    Str()          $alarm_uid,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_cal_backend_discard_alarm(
      $!ecb,
      $uid,
      $rid,
      $alarm_uid,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method discard_alarm_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    e_cal_backend_discard_alarm_finish($!ecb, $result, $error);
  }

  proto method discard_alarm_sync (|)
  { * }

  method discard_alarm_sync (
                            $uid,
                            $alarm_uid,
    CArray[Pointer[GError]] $error        = gpointer
                            :$rid         = Str,
                            :$opflags     = 0,
                            :$cancellable = GCancellable,
  ) {
    samewith(
      $uid,
      $rid,
      $alarm_uid,
      $opflags,
      $cancellable,
      $error
    );
  }
  method discard_alarm_sync (
    Str()                   $uid,
    Str()                   $rid,
    Str()                   $alarm_uid,
    Int()                   $opflags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gpointer
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_discard_alarm_sync(
      $!ecb,
      $uid,
      $rid,
      $alarm_uid,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method dup_cache_dir {
    e_cal_backend_dup_cache_dir($!ecb);
  }

  method foreach_view (&func, gpointer $user_data = gpointer) {
    e_cal_backend_foreach_view($!ecb, &func, $user_data);
  }

  method foreach_view_notify_progress (
    Int() $only_completed_views,
    Int() $percent,
    Str() $message
  ) {
    my gboolean $o = $only_completed_views.so.Int;

    e_cal_backend_foreach_view_notify_progress(
      $!ecb,
      $o,
      $percent,
      $message
    );
  }

  proto method get_attachment_uris (|)
  { * }

  multi method get_attachment_uris (
    Str()          $uid,
                   &callback,
    gpointer       $user_data    = gpointer,
    Str()          :$rid         = Str,
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
    e_cal_backend_get_attachment_uris(
      $!ecb,
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
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error,
                            :$raw    = False,
                            :$array  = True
  ) {
    my $q  = GQueue.new;
    my $rv = samewith($result, $q, $error);

    return Nil unless $rv;

    $q = $q ??
      ( $raw ?? $q !! GLib::Queue.new($q, :!ref) )
      !!
      Nil;

    return $q unless $array || $raw.not;

    ( $q but GLib::Roles::TypedQueue[Str] ).Array;
  }
  multi method get_attachment_uris_finish (
    GAsyncResult()          $result,
    GQueue()                $out_attachment_uris,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so e_cal_backend_get_attachment_uris_finish(
      $!ecb,
      $result,
      $out_attachment_uris,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_attachment_uris_sync (|)
  { * }

  multi method get_attachment_uris_sync (
    Str                     $uid,
    CArray[Pointer[GError]] $error                = gerror,
    Str                     :$rid                 = Str,
    GCancellable            :$cancellable         = GCancellable,
                            :$raw                 = False,
                            :$array               = True
  ) {
    my $q  = GQueue.new;
    my $rv = samewith(
      $uid,
      $rid,
      $q,
      $cancellable,
      $error
    );

    return Nil unless $rv;

    # Transfer: full (newly created)
    $q = $q ??
      ( $raw ?? $q !! GLib::Queue.new($q, :!ref) )
      !!
      Nil

    return $q unless $array || $raw.not;

    ( $q but GLib::Roles::TypedQueue[Str] ).Array;
  }
  multi method get_attachment_uris_sync (
    Str                     $uid,
    Str                     $rid,
    GQueue()                $out_attachment_uris,
    GCancellable            $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so e_cal_backend_get_attachment_uris_sync(
      $!ecb,
      $uid,
      $rid,
      $out_attachment_uris,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_backend_property (Str() $prop_name) {
    e_cal_backend_get_backend_property($!ecb, $prop_name);
  }

  method get_cache_dir {
    e_cal_backend_get_cache_dir($!ecb);
  }

  proto method get_free_busy (|)
  { * }

  method get_free_busy (
    Int()          $start,
    Int()          $end,
                   @users,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $start,
      $end,
      ArrayToCArray(@users, typed => Str),
      $cancellable,
      &callback,
      $user_data
    );
  }
  method get_free_busy (
    Int()          $start,
    Int()          $end,
    CArray[Str]    $users,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_backend_get_free_busy(
      $!ecb,
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
    my $rv   = samewith($result, $ofb, $error, :all);

    return Nil unless $rv[0];

    returnGList($rv[1], $glist, $raw, Str);
  }
  multi method get_free_busy_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_freebusy,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    clear_error;
    my $rv = so e_cal_backend_get_free_busy_finish(
      $!ecb,
      $result,
      $out_freebusy,
      $error
    );
    set_error($error);
    return $rv unless $all;

    ( $rv, ppr($out_freebusy) )
  }

  proto method get_free_busy_sync (|)
  { * }

  multi method get_free_busy_sync (
                            $start,
                            $end,
                            @users,
    CArray[Pointer[GError]] $error        = gerror,
                            :$cancellable = GCancellable,
                            :$glist       = False,
                            :$raw         = False
  ) {
    (my $ofb = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my $rv = samewith(
      $start,
      $end,
      ArrayToCArray(@users, typed => Str),
      $ofb,
      $cancellable,
      :all
    );

    return Nil unless $rv[0];

    returnGList($rv[1], $glist, $raw, Str);
  }
  multi method get_free_busy_sync (
    Int()                   $start,
    Int()                   $end,
    CArray[Str]             $users,
    CArray[Pointer[GSList]] $out_freebusy,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    my time_t ($s, $e) = ($start, $end);

    my $rv = so e_cal_backend_get_free_busy_sync(
      $!ecb,
      $s,
      $e,
      $users,
      $out_freebusy,
      $cancellable,
      $error
    );

    return $rv unless $all;

    ( $rv, ppr($out_freebusy) )
  }

  method get_kind {
    icalcomponent_kindEnum( e_cal_backend_get_kind($!ecb) );
  }

  proto method get_object (|)
  { * }

  multi method get_object (
    Str()          $uid,
                   &callback,
    gpointer       $user_data,
    Str()          :$rid         = Str,
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
  multi method get_object (
    Str()          $uid,
    Str()          $rid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_cal_backend_get_object(
      $!ecb,
      $uid,
      $rid,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method get_object_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $ecal-comp-str = e_cal_backend_get_object_finish($!ecb, $result, $error);
    set_error($error);
    $ecal-comp-str;
  }

  proto method get_object_list (|)
  { * }

  multi method get_object_list (
    Str()          $query,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $query,
      $cancellable,
      $callback,
      $user_data
    );
  }
  multi method get_object_list (
    Str()          $query,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_cal_backend_get_object_list(
      $!ecb,
      $query,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method get_object_list_finish (|)
  { * }

  multi method get_object_list_finish (
    GAsyncResult()          $result
    CArray[Pointer[GError]] $error  = gerror,
                            :$raw   = False
  ) {
    my $q  = GQueue.new;
    my $rv = samewith($result, $q, $error);

    # Transfer: full (newly created)
    $q ??
      ( $raw ?? $q !! GLib::Queue.new($q, :!ref) )
      !!
      Nil;
  }

  multi method get_object_list_finish (
    GAsyncResult()          $result,
    GQueue()                $out_objects,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_get_object_list_finish(
      $!ecb,
      $result,
      $out_objects,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_object_list_sync (|)
  { * }

  multi method get_object_list_sync (
    Str()                   $query,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False,
                            :$array       = True
  ) {
    my $q  = GQueue.new;
    my $rv = samewith($query, $q, $cancellable, $error);

    return Nil unless $rv;

    # Transfer: full (newly created)
    $q = $q ??
      ( $raw ?? $q !! GLib::Queue.new($q, :!ref) )
      !!
      Nil;

    return $q unless $array || $raw.not;

    ( $q but GLib::Roles::TypedQueue[Str] ).Array;
  }
  multi method get_object_list_sync (
    Str()                   $query,
    GQueue()                $out_objects,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_get_object_list_sync(
      $!ecb,
      $query,
      $out_objects,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_object_sync (|)
  { * }

  multi method get_object_sync (
    Str()                   $uid,
    CArray[Pointer[GError]] $error        = gerror
    Str()                   :$rid         = Str,
    GCancellable()          :$cancellable = GCancellable,
  ) {
    samewith(
      $uid,
      $rid,
      $cancellable,
      $error
    );
  }
  multi method get_object_sync (
    Str()                   $uid,
    Str()                   $rid,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $ecal-comp-str = e_cal_backend_get_object_sync(
      $!ecb,
      $uid,
      $rid,
      $cancellable,
      $error
    );
    set_error($error);
    $ecal-comp-str;
  }

  method get_registry (:$raw = False) {
    my $r = e_cal_backend_get_registry($!ecb);

    # Transfer: none (Registry may owned by "source")
    $r ??
      ( $raw ?? $r !! Evolution::Source::Registry.new($r) )
      !!
      Nil;
  }

  proto method get_timezone (|)
  { * }

  multi method get_timezone (
    Str()          $tzid,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCallable
  ) {
    samewith($tzid, $cancellable, $callback, $user_data);
  }
  multi method get_timezone (
    Str()          $tzid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_cal_backend_get_timezone(
      $!ecb,
      $tzid,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method get_timezone_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $ical-str = e_cal_backend_get_timezone_finish($!ecb, $result, $error);
    set_error($error);
    $ical-str;
  }

  method get_timezone_sync (
    Str()                   $tzid,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $ical-str = e_cal_backend_get_timezone_sync(
      $!ecb,
      $tzid,
      $cancellable,
      $error
    );
    set_error($error);
    $ical-str;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_backend_get_type, $n, $t );
  }

  method get_writable {
    so e_cal_backend_get_writable($!ecb);
  }

  method is_opened {
    so e_cal_backend_is_opened($!ecb);
  }

  method is_readonly {
    so e_cal_backend_is_readonly($!ecb);
  }

  method list_views (:$glist = False, :$raw = False) {
    # cw: Object?
    returnGList(
      e_cal_backend_list_views($!ecb),
      $glist,
      $raw,
      EDataCalView,
      Evolution::DataCal::View
    );
  }

  proto method modify_objects (|)
  { * }

  multi method modify_objects (
    Str()            $calobjs,
                     &callback,
    gpointer         $user_data    = gpointer,
    Int()            :$mod         = 0,
    Int()            :$opflags     = 0,
    GCancellable()   :$cancellable = GCancellable
 ) {
   samewith(
     $calobjs,
     $mod,
     $opflags,
     $cancellable,
     $callback,
     $user_data
   );
 }
 multi method modify_objects (
    Str()            $calobjs,
    Int()            $mod,
    Int()            $opflags,
    GCancellable()   $cancellable,
                     &callback,
    gpointer         $user_data    = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    e_cal_backend_modify_objects(
      $!ecb,
      $calobjs,
      $m,
      $o,
      $cancellable,
      $callback,
      $user _data
    );
  }

  method modify_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_modify_objects_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  proto method modify_objects_sync (|)
  { * }

  multi method modify_objects_sync (
    Str()                   $calobjs,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$mod         = 0,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $calobjs,
      $mod,
      $opflags,
      $cancellable,
      $error
    );
  }
  multi method modify_objects_sync (
    Str()                   $calobjs,
    Int()                   $mod,
    Int()                   $opflags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_modify_objects_sync(
      $!ecb,
      $calobjs,
      $m,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method notify_component_created (ECalComponent() $component) {
    e_cal_backend_notify_component_created($!ecb, $component);
  }

  method notify_component_modified (
    ECalComponent() $old_component,
    ECalComponent() $new_component
  ) {
    e_cal_backend_notify_component_modified(
      $!ecb,
      $old_component,
      $new_component
    );
  }

  method notify_component_removed (
    ECalComponentId() $id,
    ECalComponent()   $old_component,
    ECalComponent()   $new_component
  ) {
    e_cal_backend_notify_component_removed(
      $!ecb,
      $id,
      $old_component,
      $new_component
    );
  }

  method notify_error (Str() $message) {
    e_cal_backend_notify_error($!ecb, $message);
  }

  method notify_property_changed (Str() $prop_name, Str() $prop_value) {
    e_cal_backend_notify_property_changed($!ecb, $prop_name, $prop_value);
  }

  multi method open (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, $callback, $user_data);
  }
  multi method open (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    clear_error;
    e_cal_backend_open($!ecb, $cancellable, $callback, $user_data);
    set_error($error);
  }

  method open_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_open_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  method open_sync (
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_open_sync($!ecb, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method prepare_for_completion (
    Int()    $opid,
    GQueue() $result_queue,
             :$raw          = False
  ) {
    my guint $o = $opid;

    my $sar = e_cal_backend_prepare_for_completion($!ecb, $o, $result_queue);

    # Transfer: full (newly created)

    # cw: 2021-05-16
    # The return value is an object that has been completely deprecated in ]
    # GIO: a GSimpleAsyncResult. I could add support for it, but I suspect
    # that effort may not be worth the time I will put in.
    #
    # It is so decided that I will NOT create a GIO::SimpleAsyncResult
    # and just return the pointer for the caller to do with as they will.
    # The raw functions used by GIO::SimpleAsyncResult will remain in
    # p6-GIO, and remain an undocumented feature.
    #
    # $sar ??
    #   ( $raw ?? $sar !! GIO::SimpleAsyncResult.new($sar, :!ref) )
    #   !!
    #   Nil;
  }

  proto method receive_objects (|)
  { * }

  multi method receive_objects (
    Str()          $calobj,
                   &callback,
    gpointer       $user_data    = gpointer
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable,
  ) {
    samewith(
      $calobj,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method receive_objects (
    Str()          $calobj,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_receive_objects(
      $!ecb,
      $calobj,
      $o,
      $cancellable,
      $callback,
      $user_data
    );
    set_error($error);
    $rv;
  }

  method receive_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerrpr
  ) {
    clear_error;
    my $rv = so _cal_backend_receive_objects_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  method receive_objects_sync (
    Str()                   $calobj,
    Int()                   $opflags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_receive_objects_sync(
      $!ecb,
      $calobj,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method ref_data_cal (:$raw = False) {
    my $dc = e_cal_backend_ref_data_cal($!ecb);

    # Transfer: full (newly created)
    $dc ??
      ( $raw ?? $dc !! Evolution::DataCal.new($dc, :!ref) )
      !!
      Nil;
  }

  method ref_proxy_resolver (:$raw = False) {
    my $pr = e_cal_backend_ref_proxy_resolver($!ecb);

    # Transfer:full (newly created)
    $pr ??
      ( $raw ?? $pr !! GIO::ProxyResolver.new($pr, :!ref) )
      !!
      Nil
  }

  multi method refresh (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method refresh (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_cal_backend_refresh($!ecb, $cancellable, &callback, $user_data);
  }

  method refresh_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_refresh_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  method refresh_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_refresh_sync($!ecb, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method remove_objects (|)
  { * }

  multi method remove_objects (
    GList()        $component_ids,
                   &callback,
    gpointer       $user_data      = gpointer,
    Int()          :$mod           = 0,
    Int()          :$opflags       = 0,
    GCancellable() :$cancellable   = GCancellable
  ) {
    samewith(
      $component_ids,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method remove_objects (
    GList()        $component_ids,
    Int()          $mod,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data      = gpointer
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_remove_objects(
      $!ecb,
      $component_ids,
      $m,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
    set_error($error);
    $rv;
  }

  method remove_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_cal_backend_remove_objects_finish($!ecb, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_objects_sync (
    GList()                 $component_ids,
    Int()                   $mod,
    Int()                   $opflags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_remove_objects_sync(
      $!ecb,
      $component_ids,
      $m,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_view (EDataCalView() $view) {
    e_cal_backend_remove_view($!ecb, $view);
  }

  proto method schedule_custom_operation (|)
  { * }

  multi method schedule_custom_operation (
                   &func,
    gpointer       $user_data        = gpointer,
                   &user_data_free   = Callable,
    GCancellable() :$use_cancellable = GCancellable
  {
    samewith(
      $use_cancellable,
      $func,
      $user_data,
      $user_data_free
    );
  }
  multi method schedule_custom_operation (
    GCancellable() $use_cancellable,
                   &func,
    gpointer       $user_data        = gpointer,
                   &user_data_free   = Callable
  ) {
    e_cal_backend_schedule_custom_operation(
      $!ecb,
      $use_cancellable,
      $func,
      $user_data,
      $user_data_free
    );
  }

  proto method send_objects (|)
  { * }

  multi method send_objects (
    Str()        $calobj,
                 &callback,
    gpointer     $user_data    = gpointer
    Int()        :$opflags     = 0,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith($calobj, $opflags, $cancellable, $callback, $user_data);
  }
  multi method send_objects (
    Str()          $calobj,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer,
                   $all          = False
  ) {
    my guint32 $o = $opflags;

    e_cal_backend_send_objects(
      $!ecb,
      $calobj,
      $o,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method send_objects_finish (|)
  { * }

  multi method send_objects_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    my $rv = samewith($result, $, $error, :all);

    return Nil unless (my $ou = $rv[0]);

    # Transfer: full (newly created)
    $ou ??
      ( $raw ?? $ou !! GLib::Queue.new($ou, :!ref) )
      !!
      Nil
  }
  multi method send_objects_finish (
    GAsyncResult()          $result,
    GQueue()                $out_users = GQueue.new,
    CArray[Pointer[GError]] $error     = gerror,
                            :$all      = False
  ) {
    clear_error;
    my $rv = so e_cal_backend_send_objects_finish(
      $!ecb,
      $result,
      $out_users,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ($rv, $out_users);
  }

  proto method send_objects_sync (|)
  { * }

  multi method send_objects_sync (
    Str()                   $calobj,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    my $rv = samewith(
      $calobj,
      $opflags,
      $,
      $cancellable,
      $error,
      :!all
    );

    return Nil unless ($ou = $rv[1]);

    # Transfer: Full -- $ou ostentiably belongs to the caller.
    $ou
      ( $raw ?? $ou !! GLib::Queue.new($ou, :!ref) )
      !!
      Nil;
  }
  multi method send_objects_sync (
    Str()                   $calobj,
    Int()                   $opflags,
    GQueue()                $out_users   = GQueue.new,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$all        = False
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_cal_backend_send_objects_sync(
      $!ecb,
      $calobj,
      $o,
      $out_users,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ($rv, $out_users);
  }

  method set_cache_dir (Str() $cache_dir) {
    e_cal_backend_set_cache_dir($!ecb, $cache_dir);
  }

  method set_data_cal (EDataCal() $data_cal) {
    e_cal_backend_set_data_cal($!ecb, $data_cal);
  }

  method set_writable (Int() $writable) {
    my gboolean $w = $writable.so.Int;

    e_cal_backend_set_writable($!ecb, $w);
  }

  method start_view (EDataCalView() $view) {
    e_cal_backend_start_view($!ecb, $view);
  }

  method stop_view (EDataCalView() $view) {
    e_cal_backend_stop_view($!ecb, $view);
  }

}
