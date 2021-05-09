use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::DataCal;

use GLib::Roles::Object;

our $GERROR-ZERO = Proxy.new(
  FETCH => -> $ {
    my \ge := malloc(GError.&nativesizeof);
    memset(ge, 0, ge.&nativesizeof);
    cast(GError, ge);
  },

  STORE => -> $, $ { }
);

class Evolution::DataCal {
  also does GLib::Roles::Object;

  has EDataCal $!edc;

  method new (
    EBackend()        $backend,
    GDBusConnection() $connection,
    Str()             $object_path,
    GError()          $error        = gerror
  ) {
    clear_error
    my $data-cal = e_data_cal_new($backend, $connection, $object_path, $error);
    set_error($error);

    $data-cal ?? self.bless( :$data-cal ) !! Nil;
  }

  method get_connection (:$raw = False) {
    my $dc = e_data_cal_get_connection($!edc);

    # Transfer: none (assume belongs to the object)
    $dc ??
      ( $raw ?? $dc !! GIO::DBus::Connection.new($dc) )
      !!
      Nil;
  }

  method get_object_path {
    e_data_cal_get_object_path($!edc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &e_data_cal_get_type, $n, $t );
  }

  method ref_backend (:$raw = False) {
    my $b = e_data_cal_ref_backend($!edc);

    # Transfer: none (assume belongs to the object
    $b ??
      ( $raw ?? $b !! Evolution::Backend.new($b) )
      !!
      Nil;
  }

  method report_backend_property_changed (Str() $prop_name, Str() $prop_value) {
    e_data_cal_report_backend_property_changed($!edc, $prop_name, $prop_value);
  }

  method report_error (Str() $message) {
    e_data_cal_report_error($!edc, $message);
  }

  proto method report_free_busy_data (|)
  { * }

  multi method report_free_busy_data (@freebusy) {
    samewith( GLib::GSList.new(@freebusy, typed => Str) );
  }
  multi method report_free_busy_data (GSList() $freebusy) {
    e_data_cal_report_free_busy_data($!edc, $freebusy);
  }

  method respond_add_timezone (Int() $opid, GError() $error = $GERROR-ZERO) {
    my guint32 $o = $opid;

    e_data_cal_respond_add_timezone($!edc, $o, $error);
  }


  proto method respond_create_objects (|)
  { * }

  multi method respond_create_objects (
    Int()    $opid,
             @uids,
             @new-components,
    GError() :$error          = $GERROR-ZERO
  ) {
    samewith(
      $opid,
      GLib::GSList.new(@uids,           typed => Str),
      GLib::GSList.new(@new-components, typed => ECalComponent),
      $error
    );
  }
  multi method respond_create_objects (
    Int()    $opid,
    GError() $error,
    GSList() $uids,
    GSList() $new_components
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_create_objects(
      $!edc,
      $o,
      $error,
      $uids,
      $new_components
    );
  }

  method respond_discard_alarm (Int() $opid, GError() $error) {
    my guint32 $o = $opid;

    e_data_cal_respond_discard_alarm($!edc, $o, $error);
  }

  proto method respond_get_attachment_uris (|)
  { * }

  multi method respond_get_attachment_uris (
    Int()    $opid,
             @attachment_urls,
    GError() :$error           = $GERROR-ZERO
  ) {
    samewith(
      $opid,
      $error,
      GLib::GSList.new(@attachment_urls, typed => Str)
    );
  }
  multi method respond_get_attachment_uris (
    Int()    $opid,
    GError() $error,
    GSList() $attachment_uris
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_get_attachment_uris($!edc, $o, $error, $attachment_uris);
  }

  proto method respond_get_free_busy (|)
  { * }

  multi method respond_get_free_busy (
    Int()    $opid,
             @freebusy,
    GError() :$error    = $GERROR-ZERO,
  ) {
    samewith( $opid, $error, GLib::GSList(@freebusy, typed => Str) );
  }
  multi method respond_get_free_busy (
    Int()    $opid,
    GError() $error,
    GSList() $freebusy
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_get_free_busy($!edc, $o, $error, $freebusy);
  }

  proto method respond_get_object (|)
  { * }

  multi method respond_get_object (
    Int()    $opid,
    Str()    $object,
    GError() :$error = $GERROR-ZERO
  ) {
    samewith($opid, $error, $object);
  }
  multi method respond_get_object (
    Int()    $opid,
    GError() $error,
    Str()    $object
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_get_object($!edc, $o, $error, $object);
  }

  proto method respond_get_object_list (|)
  { * }

  multi method respond_get_object_list (
    Int()    $opid,
             @objects,
    GError() :$error   = $GERROR-ZERO,
  ) {
    samewith( $opid, $error, GLib::GSList(@objects, typed => Str) );
  }
  multi method respond_get_object_list (
    Int()    $opid,
    GError() $error,
    GSList() $objects
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_get_object_list($!edc, $o, $error, $objects);
  }

  proto method respond_get_timezone (|)
  { * }

  multi method respond_get_timezone (
    Int()    $opid,
    Str()    $tzobject,
    GError() :$error    = $GERROR-ZERO
  ) {
    samewith($opid, $error, $tzobject);
  }
  multi method respond_get_timezone (
    Int()    $opid,
    GError() $error,
    Str()    $tzobject
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_get_timezone($!edc, $o, $error, $tzobject);
  }

  proto method respond_modify_objects (|)
  { * }

  multi method respond_modify_objects (
    Int()    $opid,
             @old_components,
             @new_components,
    GError() :$error          = $GERROR-ZERO
  ) {
    samewith(
      $opid,
      $error,
      GLib::GSList.new(@old_components, typed => ECalComponent),
      GLib::GSList.new(@new_components, typed => ECalComponent),
    );
  }
  multi method respond_modify_objects (
    Int() $opid,
    GError() $error,
    GSList() $old_components,
    GSList() $new_components
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_modify_objects(
      $!edc,
      $o,
      $error,
      $old_components,
      $new_components
    );
  }

  method respond_open (
    Int()    $opid,
    GError() $error = $GERROR-ZERO
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_open($!edc, $o, $error);
  }

  method respond_receive_objects (
    Int()    $opid,
    GError() $error = $GERROR-ZERO
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_receive_objects($!edc, $o, $error);
  }

  method respond_refresh (Int() $opid, GError() $error = $GERROR-ZERO) {
    my guint32 $o = $opid;

    e_data_cal_respond_refresh($!edc, $o, $error);
  }

  proto method respond_remove_objects (|)
  { * }

  multi method respond_remove_objects (
    Int()    $opid,
    GSList() $ids,
             @old_components,
             @new_components,
    GError() :$error          = $GERROR-ZERO
  ) {
    samewith(
      $opid,
      $error,
      $ids,
      GLib::GList.nw(@old_components, typed => ECalComponent),
      GLib::GList.nw(@new_components, typed => ECalComponent)
    );
  }
  multi method respond_remove_objects (
    Int()    $opid,
    GError() $error,
    GSList() $ids,
    GSList() $old_components,
    GSList() $new_components
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_remove_objects(
      $!edc,
      $o,
      $error,
      $ids,
      $old_components,
      $new_components
    );
  }

  proto method respond_send_objects (|)
  { * }

  multi method respond_send_objects (
    Int()    $opid,
             @users,
    Str()    $calobj,
    GError() :$error  = $GERROR-ZERO
  ) {
    samewith(
      $opid,
      $error,
      GLib::GList.new(@users, typed => Str),
      $calobj
    );
  }
  multi method respond_send_objects (
    Int()    $opid,
    GError() $error,
    GSList() $users,
    Str()    $calobj
  ) {
    my guint32 $o = $opid;

    e_data_cal_respond_send_objects($!edc, $o, $error, $users, $calobj);
  }

}
