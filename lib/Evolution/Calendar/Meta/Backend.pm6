use  v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Meta::Backend;

use GLib::GSList;
use Evolution::Calendar::Backend::Sync;

use GLib::Roles::Implementor;

class Evolution::Calendar::Meta::Backend
  is Evolution::Calendar::Backend::Sync
{
  has ECalMetaBackend $!eds-ecmb is implementor;

  proto method connect_sync (|)
  { * }

  multi method connect_sync (
    CArray[Pointer[GError]]      $error       = gerror,
    ENamedParameters()          :$credentials = ENamedParameters,
    GCancellable()              :$cancellable = GCancellable
  ) {
    samewith(
       $credentials,
       $,
       newCArray(Str),
       $,
       $cancellable,
       $error,
      :all,
    );
  }
  multi method connect_sync (
    ENamedParameters()       $credentials,
                             $out_auth_result        is rw,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors is rw,
    GCancellable()           $cancellable                   = GCancellable,
    CArray[Pointer[GError]]  $error                         = gerror,
                            :$all                           = False
  ) {
    my ESourceAuthenticationResult $oar = 0;
    my GTlsCertificateFlags        $oce = 0;

    clear_error;
    my $rv = so e_cal_meta_backend_connect_sync(
      $!eds-ecmb,
      $credentials,
      $oar,
      $out_certificate_pem,
      $oce,
      $cancellable,
      $error
    );
    set_error($error);
    ($out_auth_result, $out_certificate_errors) = ($oar, $oce);

    if $rv {
      return $all.not ?? $rv !! ( $oar, ppr($out_certificate_pem), $oce );
    }
    Nil;
  }

  proto method disconnect_sync (|)
  { * }

  multi method disconnect_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method disconnect_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_disconnect_sync(
      $!eds-ecmb,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method dup_sync_tag {
    e_cal_meta_backend_dup_sync_tag($!eds-ecmb);
  }

  proto method empty_cache_sync (|)
  { * }

  multi method empty_cache_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method empty_cache_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_empty_cache_sync(
      $!eds-ecmb,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method ensure_connected_sync (|)
  { * }

  multi method ensure_connected_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method ensure_connected_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_ensure_connected_sync(
      $!eds-ecmb,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method gather_timezones_sync (|)
  { * }

  multi method gather_timezones_sync (
    ICalComponent()         $vcalendar,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror,

    Int()                   :remove(:remove-existing(:$remove_existing))
                              = False
  ) {
    samewith($vcalendar, $remove_existing, $cancellable, $error);
  }
  multi method gather_timezones_sync (
    ICalComponent()         $vcalendar,
    Int()                   $remove_existing  = False,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my gboolean $r = $remove_existing;

    clear_error;
    my $rv = so e_cal_meta_backend_gather_timezones_sync(
      $!eds-ecmb,
      $vcalendar,
      $r,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_capabilities {
    e_cal_meta_backend_get_capabilities($!eds-ecmb);
  }

  proto method get_changes_sync (|)
  { * }

  multi method get_changes_sync (
    CArray[Pointer[GError]]  $error                          = gerror,
    Str()                   :$last_sync_tag                  = Str,
    GCancellable()          :$cancellable                    = GCancellable,
    Int()                   :repeat(:is-repeat(:$is_repeat)) = False,
                            :$all                            = False,
                            :$raw                            = False,
                            :glist(:$gslist)                 = False
  ) {
    samewith(
       $last_sync_tag,
       $is_repeat,
       newCArray(Str),
       $,
       newCArray(GSList),
       newCArray(GSList),
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method get_changes_sync (
    Str()                    $last_sync_tag,
    Int()                    $is_repeat,
    CArray[Str]              $out_new_sync_tag,
                             $out_repeat            is rw,
    CArray[GSList]           $out_created_objects,
    CArray[GSList]           $out_modified_objects,
    CArray[GSList]           $out_removed_objects,
    GCancellable             $cancellable                  = GCancellable,
    CArray[Pointer[GError]]  $error                        = gerror,
                            :$all                          = False,
                            :$raw                          = False,
                            :glist(:$gslist)               = False
  ) {
    my gboolean $i = $is_repeat.so.Int;
    my gboolean $o = 0;

    clear_error;
    my $rv = so e_cal_meta_backend_get_changes_sync(
      $!eds-ecmb,
      $last_sync_tag,
      $is_repeat,
      $out_new_sync_tag,
      $o,
      $out_created_objects,
      $out_modified_objects,
      $out_removed_objects,
      $cancellable,
      $error
    );
    set_error($error);
    $out_repeat = $o;

    my $oco = returnGSList(
      ppr($out_created_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    my $omo = returnGSList(
      ppr($out_modified_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    my $oro = returnGSList(
      ppr($out_removed_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    if $rv {
      return $all.not ?? $rv
                      !! ( ppr($out_new_sync_tag), $o, $oco, $omo, $oro );
    }
    Nil;
  }

  method get_connected_writable {
    so e_cal_meta_backend_get_connected_writable($!eds-ecmb);
  }

  method get_ever_connected {
    so e_cal_meta_backend_get_ever_connected($!eds-ecmb);
  }

  proto method get_ssl_error_details (|)
  { * }

  multi method get_ssl_error_details {
    samewith( newCArray(Str), $ );
  }
  multi method get_ssl_error_details (
    CArray[Str] $out_certificate_pem,
                $out_certificate_errors is rw
  ) {
    my GTlsCertificateFlags $o = 0;

    e_cal_meta_backend_get_ssl_error_details(
      $!eds-ecmb,
      $out_certificate_pem,
      $o
    );
    $out_certificate_errors = $o;
    ( ppr($out_certificate_pem), $o );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_meta_backend_get_type, $n, $t );
  }

  proto method inline_local_attachments_sync (|)
  { * }

  multi method inline_local_attachments_sync (
    ICalComponent()          $component,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith($component, $cancellable, $error);
  }
  multi method inline_local_attachments_sync (
    ICalComponent()         $component,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_inline_local_attachments_sync(
      $!eds-ecmb,
      $component,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method list_existing_sync (|)
  { * }

  multi method list_existing_sync (
    CArray[Pointer[GError]]  $error          = gerror,
    GCancellable()          :$cancellable    = GCancellable,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
      newCArray(Str),
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method list_existing_sync (
    CArray[Str]             $out_new_sync_tag,
    CArray[GSList]          $out_existing_objects,
    GCancellable            $cancellable           = GCancellable,
    CArray[Pointer[GError]] $error                 = gerror,
                            :$all                  = False,
                            :$raw                  = False,
                            :glist(:$gslist)       = False
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_list_existing_sync(
      $!eds-ecmb,
      $out_new_sync_tag,
      $out_existing_objects,
      $cancellable,
      $error
    );
    set_error($error);

    my $oco = returnGSList(
      ppr($out_existing_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    if $rv {
      return $all.not ?? $rv !! ( ppr($out_new_sync_tag), $oco )
    }
    Nil;
  }

  proto method load_component_sync (|)
  { * }

  multi method load_component_sync (
    Str()                    $uid,
    Str()                    $extra,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  ) {
    samewith(
      $uid,
      $extra,
      newCArray(ICalComponent),
      newCArray(Str),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method load_component_sync (
    Str()                    $uid,
    Str()                    $extra,
    CArray[ICalComponent]    $out_component,
    CArray[Str]              $out_extra,
    GCancellable             $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_load_component_sync(
      $!eds-ecmb,
      $uid,
      $extra,
      $out_component,
      $out_extra,
      $cancellable,
      $error
    );
    set_error($error);

    my $oc = propReturnObject(
      ppr($out_component),
      $raw,
      |Evolution::Calendar::Component.getTypePair
    );

    if $rv {
      return $all.not ?? $rv !! ( $oc, ppr($out_extra) )
    }
    Nil;
  }

  method merge_instances (
    GSList() $instances,
    Int()    $replace_tzid_with_location
  ) {
    my gboolean $r = $replace_tzid_with_location.so.Int;

    e_cal_meta_backend_merge_instances($!eds-ecmb, $instances, $r);
  }

  proto method process_changes_sync (|)
  { * }

  multi method process_changes_sync (
    GSList()                 $created_objects,
    GSList()                 $modified_objects,
    GSList()                 $removed_objects,
    CArray[Pointer[GError]]  $error             = gerror,
    GCancellable()          :$cancellable       = GCancellable
  ) {
    samewith(
      $created_objects,
      $modified_objects,
      $removed_objects,
      $cancellable,
      $error
    );
  }
  multi method process_changes_sync (
    GSList()                $created_objects,
    GSList()                $modified_objects,
    GSList()                $removed_objects,
    GCancellable()          $cancellable        = GCancellable,
    CArray[Pointer[GError]] $error              = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_process_changes_sync(
      $!eds-ecmb,
      $created_objects,
      $modified_objects,
      $removed_objects,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method ref_cache {
    e_cal_meta_backend_ref_cache($!eds-ecmb);
    self
  }

  proto method refresh_sync (|)
  { * }

  multi method refresh_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method refresh_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_refresh_sync(
      $!eds-ecmb,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_component_sync (|)
  { * }

  multi method remove_component_sync (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error                = gerror,
    Str()                   :$extra                = Str,
    Str()                   :$object               = Str,
    Int()                   :$opflags              = 0,
    GCancellable()          :$cancellable          = GCancellable,

    Int()                   :resolve(
                              :conflict-resolution(:$conflict_resolution)
                            ) = E_CONFLICT_RESOLUTION_USE_NEWER
  ) {
    samewith(
      $conflict_resolution,
      $uid,
      $extra,
      $object,
      $opflags,
      $cancellable,
      $error
    )
  }
  multi method remove_component_sync (
    Int()                   $conflict_resolution,
    Str()                   $uid,
    Str()                   $extra                = Str,
    Str()                   $object               = Str,
    Int()                   $opflags              = 0,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = gerror
  ) {
    my ECalOperationFlags  $o = $opflags;
    my EConflictResolution $c = $conflict_resolution;

    clear_error;
    e_cal_meta_backend_remove_component_sync(
      $!eds-ecmb,
      $c,
      $uid,
      $extra,
      $object,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method requires_reconnect {
    so e_cal_meta_backend_requires_reconnect($!eds-ecmb);
  }

  proto method save_component_sync (|)
  { * }

  multi method save_component_sync (
    GSList()                 $instances,
    CArray[Pointer[GError]]  $error               = gerror,
    Str()                   :$extra               = Str,
    Int()                   :$opflags             = 0,
    GCancellable()          :$cancellable         = GCancellable,

    Int()                   :w(:over(
                              :overwrite-existing(:$overwrite_existing)
                             )) = False,
    Int()                   :resolve(
                              :conflict-resolution(:$conflict_resolution)
                            )   = E_CONFLICT_RESOLUTION_USE_NEWER
  ) {
    samewith(
      $overwrite_existing,
      $conflict_resolution,
      $instances,
      $extra,
      $opflags,
      newCArray(Str),
      newCArray(Str),
      $cancellable,
      $error,
      :all
    );
  }
  multi method save_component_sync (
    Int()                    $overwrite_existing,
    Int()                    $conflict_resolution,
    GSList()                 $instances,
    Str()                    $extra,
    Int()                    $opflags,
    CArray[Str]              $out_new_uid,
    CArray[Str]              $out_new_extra,
    GCancellable()           $cancellable          = GCancellable,
    CArray[Pointer[GError]]  $error                = gerror,
                            :$all                  = False

  ) {
    my gboolean            $o = $overwrite_existing.so.Int;
    my EConflictResolution $c = $conflict_resolution;
    my ECalOperationFlags  $f = $opflags;

    my $rv = so e_cal_meta_backend_save_component_sync(
      $!eds-ecmb,
      $overwrite_existing,
      $conflict_resolution,
      $instances,
      $extra,
      $opflags,
      $out_new_uid,
      $out_new_extra,
      $cancellable,
      $error
    );

    if $rv {
      return $all.not ?? $rv !! ppr($out_new_uid, $out_new_extra);
    }
    Nil;
  }

  method schedule_refresh {
    so e_cal_meta_backend_schedule_refresh($!eds-ecmb);
  }

  proto method search_components_sync (|)
  { * }

  multi method search_components_sync (
    Str()                    $expr,
    CArray[Pointer[GError]]  $error           = gerror,
    GCancellable()          :$cancellable     = GCancellable,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    samewith(
      $expr,
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw,
      :$gslist;
    )
  }
  multi method search_components_sync (
    Str()                    $expr,
    CArray[GSList]           $out_components,
    GCancellable()           $cancellable     = GCancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                            :$all             = False,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_search_components_sync(
      $!eds-ecmb,
      $expr,
      $out_components,
      $cancellable,
      $error
    );
    set_error($error);

    my $oc = returnGSList(
      ppr($out_components),
      $raw,
      $gslist,
      |Evolution::Calendar::Component.getTypePair
    );

    if $rv {
      return $all.not ?? $rv !! $oc;
    }
    Nil;
  }

  proto method search_sync (|)
  { * }

  multi method search_sync (
    CArray[Pointer[GError]]  $error           = gerror,
    Str()                   :e(:$expr)         = Str,
    GCancellable()          :$cancellable     = GCancellable,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    samewith(
       $expr,
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    )
  };
  multi method search_sync (
    Str()                    $expr,
    CArray[GSList]           $out_icalstrings,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error,
                            :$all             = False,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_search_sync(
      $!eds-ecmb,
      $expr,
      $out_icalstrings,
      $cancellable,
      $error
    );
    set_error($error);

    my $oi = returnGSList(
      ppr($out_icalstrings),
      True,
      $gslist,
      Str
    );

    if $rv {
      return $all.not ?? $rv !! $oi;
    }
    Nil;
  }

  method set_cache (ECalCache() $cache) {
    e_cal_meta_backend_set_cache($!eds-ecmb, $cache);
  }

  method set_connected_writable (Int() $value) {
    my gboolean $v = $value;

    e_cal_meta_backend_set_connected_writable($!eds-ecmb, $v);
  }

  method set_ever_connected (Int() $value) {
    my gboolean $v = $value;

    e_cal_meta_backend_set_ever_connected($!eds-ecmb, $v);
  }

  proto method split_changes_sync (|)
  { * }

  multi method split_changes_sync (
    GSList()                 $objects,
    CArray[Pointer[GError]]  $error                = gerror,
    GCancellable()          :$cancellable          = GCancellable,
                            :$raw                  = False,
                            :glist(:$gslist)       = False
  ) {
    samewith(
       $objects,
       newCArray(GSList),
       newCArray(GSList),
       newCArray(GSList),
       $cancellable,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method split_changes_sync (
    GSList()                 $objects,
    CArray[GSList]           $out_created_objects,
    CArray[GSList]           $out_modified_objects,
    CArray[GSList]           $out_removed_objects,
    GCancellable()           $cancellable          = GCancellable,
    CArray[Pointer[GError]]  $error                = gerror,
                            :$all                  = False,
                            :$raw                  = False,
                            :glist(:$gslist)       = False
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_split_changes_sync(
      $!eds-ecmb,
      $objects,
      $out_created_objects,
      $out_modified_objects,
      $out_removed_objects,
      $cancellable,
      $error
    );

    my $oco = returnGSList(
      ppr($out_created_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    my $omo = returnGSList(
      ppr($out_modified_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    my $oro = returnGSList(
      ppr($out_removed_objects),
      $raw,
      $gslist,
      |Evolution::Calendar::Meta::Backend::Info.getTypePair
    );

    if $rv {
      return $all.not ?? $rv !! ($oco, $omo, $oro);
    }
    Nil;
  }

  proto method store_inline_attachments_sync (|)
  { * }

  multi method store_inline_attachments_sync (
    ICalComponent()          $component,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($component, $cancellable, $error);
  }
  multi method store_inline_attachments_sync (
    ICalComponent()         $component,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_cal_meta_backend_store_inline_attachments_sync(
      $!eds-ecmb,
      $component,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}

class Evolution::Calendar::Meta::Backend::Info {
  has ECalMetaBackendInfo $!eds-mbi is implementor;

  method new (Str() $uid, Str() $revision, Str() $object, Str() $extra) {
    my $e-meta-info = e_cal_meta_backend_info_new(
      $uid,
      $revision,
      $object,
      $extra
    );

    $e-meta-info ?? self.bless( :$e-meta-info ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_meta_backend_info_copy($!eds-mbi),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cal_meta_backend_info_free($!eds-mbi);
  }

}
