use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Backend::Sync;

use GLib::GList;
use Evolution::Calendar::Backend;

our subset ECalBackendSyncAncestry is export of Mu
  where ECalBackendSync | ECalBackendAncestry;

class Evolution::Calendar::Backend::Sync is Evolution::Calendar::Backend {
  has ECalBackendSync $!ecbs;

  submethod BUILD (:$calendar-sync) {
    self.setECalBackendSync($calendar-sync) if $calendar-sync;
  }

  method setECalBackendSync (ECalBackendSyncAncestry $_) {
    my $to-parent;

    $!ecbs = do {
      when ECalBackendSync {
        $to-parent = cast(ECalBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalBackendSync, $_);
      }
    }
    self.setECalBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ECalBackendSync
  { $!ecbs }

  proto method add_timezone (|)
  { * }

  multi method add_timezone (
    EDataCal()              $cal,
    Str()                   $tzobject,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cal, $cancellable, $tzobject, $error);
  }
  multi method add_timezone (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $tzobject,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    e_cal_backend_sync_add_timezone(
      $!ecbs,
      $cal,
      $cancellable,
      $tzobject,
      $error
    );
    set_error($error);
  }

  proto method create_objects (|)
  { * }

  multi method create_objects (
    EDataCal()              $cal,
    GSList()                $calobjs,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable,
                            :$glist       = False,
                            :$raw         = False
  ) {
    (my $uids = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    (my $nc   = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    samewith(
      $cal,
      $cancellable,
      $calobjs,
      $opflags,
      $uids,
      $nc,
      $error,
      :$glist,
      :$raw
    );
  }
  multi method create_objects (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    GSList()                $calobjs,
    Int()                   $opflags,
    CArray[Pointer[GSList]] $uids,
    CArray[Pointer[GSList]] $new_components,
    CArray[Pointer[GError]] $error,
                            :$glist          = False,
                            :$raw            = False
  ) {
    my guint32 $o = $opflags;

    clear_error;
    e_cal_backend_sync_create_objects(
      $!ecbs,
      $cal,
      $cancellable,
      $calobjs,
      $opflags,
      $uids,
      $new_components,
      $error
    );
    set_error($error);

    (
      returnGList(
        ppr($uids),
        $glist,
        $raw
      ),

      # Transfer: full
      returnGList(
        ppr($new_components),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component,
        :!ref
      )
    );
  }

  proto method discard_alarm (|)
  { * }

  multi method discard_alarm (
    EDataCal()              $cal,
    Str()                   $uid,
    Str()                   $rid,
    Str()                   $auid,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $cal,
      $cancellable,
      $uid,
      $rid,
      $auid,
      $opflags,
      $error
    );
  }
  multi method discard_alarm (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $uid,
    Str()                   $rid,
    Str()                   $auid,
    Int()                   $opflags,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    e_cal_backend_sync_discard_alarm(
      $!ecbs,
      $cal,
      $cancellable,
      $uid,
      $rid,
      $auid,
      $opflags,
      $error
    );
    set_error($error);
  }

  proto method get_attachment_uris (|)
  { * }

  multi method get_attachment_uris (
    EDataCal()              $cal,
    Str()                   $uid,
    Str()                   $rid,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable            :$cancellable = GCancellable,
                            :$glist       = False,
                            :$raw         = False
  ) {
    samewith(
      $cal,
      $cancellable,
      $uid,
      $rid,
      createReturnArray(GSList),
      $error
    );
  }
  multi method get_attachment_uris (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str                     $uid,
    Str                     $rid,
    CArray[Pointer[GSList]] $attachments,
    CArray[Pointer[GError]] $error        = gerror,
                            :$glist       = False,
                            :$raw         = False
  ) {
    clear_error;
    e_cal_backend_sync_get_attachment_uris(
      $!ecbs,
      $cal,
      $cancellable,
      $uid,
      $rid,
      $attachments,
      $error
    );
    set_error($error);

    returnGList( ppr($attachments), $glist, $raw );
  }

  proto method get_free_busy (|)
  { * }

  multi method get_free_busy (
    EDataCal()              $cal,
    GSList()                $users,
    Int()                   $start,
    Int()                   $end,
    CArray[Pointer[GError]] $error       = gerror,
    GCancellable()          $cancellable = GCancellable,
                            :$glist      = False,
                            :$raw        = False
  ) {
    samewith(
      $cal,
      $cancellable,
      $users,
      $start,
      $end,
      createReturnArray(GSList),
      $error,
      :$glist,
      :$raw
    );
  }
  multi method get_free_busy (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    GSList()                $users,
    Int()                   $start,
    Int()                   $end,
    CArray[Pointer[GSList]] $freebusyobjects,
    CArray[Pointer[GError]] $error            = gerror,
                            :$glist           = False,
                            :$raw             = False
  ) {
    clear_error;
    e_cal_backend_sync_get_free_busy(
      $!ecbs,
      $cal,
      $cancellable,
      $users,
      $start,
      $end,
      $freebusyobjects,
      $error
    );
    set_error($error);

    returnGList( ppr($freebusyobjects), $glist, $raw );
  }

  proto method get_object (|)
  { * }

  multi method get_object (
    EDataCal()              $cal,
    Str()                   $uid,
    Str()                   $rid,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $cal,
      $cancellable,
      $uid,
      $rid,
      createReturnArray(Str),
      $error
    );
  }
  multi method get_object (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $uid,
    Str()                   $rid,
    CArray[Str]             $calobj,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    e_cal_backend_sync_get_object(
      $!ecbs,
      $cal,
      $cancellable,
      $uid,
      $rid,
      $calobj,
      $error
    );
    set_error($error);

    $calobj;
  }

  proto method get_object_list (|)
  { * }

  multi method get_object_list (
    EDataCal()              $cal,
    Str()                   $sexp,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(
      $cal,
      $cancellable,
      $sexp,
      createReturnArray(Str),
      $error
    );
  }
  multi method get_object_list (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $sexp,
    CArray[Pointer[GSList]] $calobjs,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    e_cal_backend_sync_get_object_list(
      $!ecbs,
      $cal,
      $cancellable,
      $sexp,
      $calobjs,
      $error
    );
    set_error($error);
  }

  proto method get_timezone (|)
  { * }

  multi method get_timezone (
    EDataCal()              $cal,
    Str()                   $tzid,
    CArray[Pointer[GError]] $error       = gerror,
    GCancellable()          $cancellable = GCancellable
  ) {
    samewith(
      $cal,
      $cancellable,
      $tzid,
      createReturnArray(Str),
      $error
    );
  }
  multi method get_timezone (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $tzid,
    CArray[Str]             $tzobject,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    e_cal_backend_sync_get_timezone(
      $!ecbs,
      $cal,
      $cancellable,
      $tzid,
      $tzobject,
      $error
    );
    set_error($error);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_backend_sync_get_type, $n, $t );
  }

  proto method modify_objects (|)
  { * }

  multi method modify_objects (
    EDataCal()              $cal,
    GSList()                $calobjs,
    CArray[Pointer[GError]] $error           = gerror,
    GCancellable()          :$cancellable    = GCancellable,
    Int()                   :$mod            = E_CAL_OBJ_MOD_THIS,
    Int()                   :$opflags        = 0,
                            :$glist          = False,
                            :$raw            = False
  ) {
    samewith(
      $cal,
      $cancellable,
      $calobjs,
      $mod,
      $opflags,
      createReturnArray(GSList),
      createReturnArray(GSList),
      $error,
      :$glist,
      :$raw
    );
  }
  multi method modify_objects (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    GSList()                $calobjs,
    Int()                   $mod,
    Int()                   $opflags,
    CArray[Pointer[GSList]] $old_components,
    CArray[Pointer[GSList]] $new_components,
    CArray[Pointer[GError]] $error           = gerror,
                            :$glist          = False,
                            :$raw            = False
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    e_cal_backend_sync_modify_objects(
      $!ecbs,
      $cal,
      $cancellable,
      $calobjs,
      $m,
      $o,
      $old_components,
      $new_components,
      $error
    );
    set_error($error);

    (
      returnGList(
        ppr($old_components),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      ),

      returnGList(
        ppr($new_components),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  method open (
    EDataCal()              $cal,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    e_cal_backend_sync_open($!ecbs, $cal, $cancellable, $error);
    set_error($error);
  }

  proto method receive_objects (|)
  { * }

  multi method receive_objects (
    EDataCal()              $cal,
    Str()                   $calobj,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
    Int()                   :$opflags     = 0
  ) {
    samewith(
      $cal,
      $cancellable,
      $calobj,
      $opflags,
      $error
    );
  }
  multi method receive_objects (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $calobj,
    Int()                   $opflags,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    e_cal_backend_sync_receive_objects(
      $!ecbs,
      $cal,
      $cancellable,
      $calobj,
      $o,
      $error
    );
    set_error($error);
  }

  method refresh (
    EDataCal()              $cal,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    e_cal_backend_sync_refresh($!ecbs, $cal, $cancellable, $error);
  }


  proto method remove_objects (|)
  { * }

  multi method remove_objects (
    EDataCal()              $cal,
    GSList()                $ids,
    CArray[Pointer[GError]] $error           = gerror,
    GCancellable()          :$cancellable    = GCancellable,
    Int()                   :$mod            = E_CAL_OBJ_MOD_THIS,
    Int()                   :$opflags        = 0,
                            :$glist          = False,
                            :$raw            = False
  ) {
    samewith(
      $cal,
      $cancellable,
      $ids,
      $mod,
      $opflags,
      createReturnArray(GSList),
      createReturnArray(GSList),
      $error,
      :$glist,
      :$raw
    );
  }
  multi method remove_objects (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    GSList()                $ids,
    Int()                   $mod,
    Int()                   $opflags,
    CArray[Pointer[GSList]] $old_components,
    CArray[Pointer[GSList]] $new_components,
    CArray[Pointer[GError]] $error           = gerror,
                            :$glist          = False,
                            :$raw            = False
  ) {
    my ECalObjModType $m = $mod;
    my guint32        $o = $opflags;

    clear_error;
    e_cal_backend_sync_remove_objects(
      $!ecbs,
      $cal,
      $cancellable,
      $ids,
      $m,
      $o,
      $old_components,
      $new_components,
      $error
    );
    set_error($error);

    (
      returnGList(
        ppr($old_components),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      ),

      returnGList(
        ppr($new_components),
        $glist,
        $raw,
        ECalComponent,
        Evolution::Calendar::Component
      )
    );
  }

  proto method send_objects (|)
  { * }

  multi method send_objects (
    EDataCal()              $cal,
    Str()                   $calobj,
    GSList()                $users,
    CArray[Pointer[GError]] $error            = gerror,
    GCancellable            :$cancellable     = GCancellable,
    Int()                   :$opflags         = 0
  ) {
    samewith(
      $cal,
      $cancellable,
      $calobj,
      $opflags,
      $users,
      createReturnArray(GSList),
      $error
    )
  }
  multi method send_objects (
    EDataCal()              $cal,
    GCancellable()          $cancellable,
    Str()                   $calobj,
    Int()                   $opflags,
    GSList()                $users,
    CArray[Str]             $modified_calobj,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    e_cal_backend_sync_send_objects(
      $!ecbs,
      $cal,
      $cancellable,
      $calobj,
      $o,
      $users,
      $modified_calobj,
      $error
    );
    set_error($error);
  }

}
