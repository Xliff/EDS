use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Data::Book;

use GLib::Roles::Object;

our subset EDataBookAncestry is export of Mu
  where EDataBook | GObject;

class Evolution::Data::Book {
  also does GLib::Roles::Object;

  has EDataBook $!edb is implementor;

  method new (
    EBookBackend()          $backend,
    GDBusConnection()       $connection,
    Str()                   $object_path,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $e-data-book = e_data_book_new(
      $backend,
      $connection,
      $object_path,
      $error
    );
    set_error($error);

    $e-data-book ?? self.bless( :$e-data-book ) !! Nil;
  }

  method get_connection ( :$raw = False ) {
    propReturnObject(
      e_data_book_get_connection($!edb),
      $raw,
      |GIO::DBus::Connection.getTypePair
    );
  }

  method get_object_path {
    e_data_book_get_object_path($!edb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_book_get_type, $n, $t );
  }

  # Late bound to prevent circular module loading.
  method ref_backend ( :$raw = False ) {
    propReturnObject(
      e_data_book_ref_backend($!edb),
      $raw,
      |::('Evolution::Book::Backend').getTypePair
    );
  }

  method report_backend_property_changed (
    Str() $prop_name,
    Str() $prop_value
  ) {
    e_data_book_report_backend_property_changed(
      $!edb,
      $prop_name,
      $prop_value
    );
  }

  method report_error (Str() $message) {
    e_data_book_report_error($!edb, $message);
  }

  proto method respond_create_contacts (|)
  { * }

  multi method respond_create_contacts (
    Int()    $opid,
    GError() $error,
             @contacts
  ) {
    samewith(
      $opid,
      $error,
      GLib::GSList.new(@contacts, typed => EContact)
    );
  }
  multi method respond_create_contacts (
    Int()    $opid,
    GError() $error,
    GSList() $contacts
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_create_contacts($!edb, $opid, $error, $contacts);
  }

  method respond_get_contact (
    Int()      $opid,
    GError()   $error,
    EContact() $contact
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_get_contact($!edb, $o, $error, $contact);
  }

  proto method respond_get_contact_list (|)
  { * }

  multi method respond_get_contact_list (
    $opid,
    $error,
    @contacts
  ) {
    samewith( $opid, $error, GLib::GSList.new(@contacts, typed => Str) )
  }
  multi method respond_get_contact_list (
    Int()    $opid,
    GError() $error,
    GSList() $contacts
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_get_contact_list($!edb, $opid, $error, $contacts);
  }

  proto method respond_get_contact_list_uids (|)
  { * }

  multi method respond_get_contact_list_uids (
    $opid,
    $error,
    @uids
  ) {
    samewith( $opid, $error, GLib::GSList.new(@uids, typed => Str) );
  }
  multi method respond_get_contact_list_uids (
    Int()  $opid,
    GError $error,
    GSList $uids
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_get_contact_list_uids($!edb, $o, $error, $uids);
  }

  proto method respond_modify_contacts (|)
  { * }

  multi method respond_modify_contacts (
    $opid,
    $error,
    @contacts
  ) {
    samewith( $opid, $error, GLib::GSList.new(@contacts, typed => EContact) )
  }
  multi method respond_modify_contacts (
    Int()    $opid,
    GError() $error,
    GSList() $contacts
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_modify_contacts($!edb, $opid, $error, $contacts);
  }

  method respond_open (Int() $opid, GError() $error) {
    my guint32 $o = $opid;

    e_data_book_respond_open($!edb, $o, $error);
  }

  method respond_refresh (Int() $opid, GError() $error) {
    my guint32 $o = $opid;

    e_data_book_respond_refresh($!edb, $o, $error);
  }

  proto method respond_remove_contacts (|)
  { * }

  multi method respond_remove_contacts (
    $opid,
    $error,
    @ids
  ) {
    samewith( $opid, $error, GLib::GSList.new(@ids, typed => Str) )
  }
  multi method respond_remove_contacts (
    Int()   $opid,
    GError() $error,
    GSList() $ids
  ) {
    my guint32 $o = $opid;

    e_data_book_respond_remove_contacts($!edb, $o, $error, $ids);
  }

  method set_locale (
    Str()                   $locale,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = e_data_book_set_locale($!edb, $locale, $cancellable, $error);
    set_error($error);
    $rv.so;
  }

  method string_slist_to_comma_string (
    Evolution::Data::Book:U:

    GSList() $list
  ) {
    e_data_book_string_slist_to_comma_string($list);
  }

}
