use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Data::Book::View;

use Evolution::Book::Backend::SExp;

use GLib::Roles::Object;

our subset EDataBookViewAncestry is export of Mu
  where EDataBookView | GObject;

class Evolution::Data::Book::View {
  also does GLib::Roles::Object;

  has EDataBookView $!edbv is implementor;

  method new (
    EBookBackend()          $backend,
    EBookBackendSExp()      $sexp,
    GDBusConnection()       $connection,
    Str()                   $object_path,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error
    my $data-book-view = e_data_book_view_new(
      $backend,
      $sexp,
      $connection,
      $object_path,
      $error
    );

    $data-book-view ?? self.bless( :$data-book-view ) !! Nil;
  }

  method get_backend ( :$raw = False ) is also<get-backend> {
    propReturnObject(
      e_data_book_view_get_backend($!edbv),
      $raw,
      |Evolution::Book::Backend.getTypePair
    )
  }

  method get_connection ( :$raw = False ) is also<get-connection> {
    propReturnObject(
      e_data_book_view_get_connection($!edbv),
      $raw,
      |GIO::DBus::Connection.getTypePair
    );
  }

  method get_fields_of_interest (:$raw = False)
    is also<get-fields-of-interest>
  {
    propReturnObject(
      e_data_book_view_get_fields_of_interest($!edbv),
      $raw,
      |GLib::HashTable.getTypePair
    );
  }

  method get_flags is also<get-flags> {
    e_data_book_view_get_flags($!edbv);
  }

  method get_object_path is also<get-object-path> {
    e_data_book_view_get_object_path($!edbv);
  }

  method get_sexp ( :$raw = False ) is also<get-sexp> {
    propReturnObject(
      e_data_book_view_get_sexp($!edbv),
      $raw,
      |Evolution::Book::Backend::SExp.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_book_view_get_type, $n, $t );
  }

  method is_completed is also<is-completed> {
    so e_data_book_view_is_completed($!edbv);
  }

  method notify_complete (GError() $error)
    is also<notify-complete>
  {
    e_data_book_view_notify_complete($!edbv, $error);
  }

  method notify_progress (Int() $percent, Str() $message)
    is also<notify-progress>
  {
    my guint $p = $percent;

    e_data_book_view_notify_progress($!edbv, $p, $message);
  }

  method notify_remove (Str() $id) is also<notify-remove> {
    e_data_book_view_notify_remove($!edbv, $id);
  }

  method notify_update (EContact() $contact) is also<notify-update> {
    e_data_book_view_notify_update($!edbv, $contact);
  }

  method notify_update_prefiltered_vcard (Str() $id, Str() $vcard)
    is also<notify-update-prefiltered-vcard>
  {
    e_data_book_view_notify_update_prefiltered_vcard($!edbv, $id, $vcard);
  }

  method notify_update_vcard (Str() $id, Str() $vcard)
    is also<notify-update-vcard>
  {
    e_data_book_view_notify_update_vcard($!edbv, $id, $vcard);
  }

  method ref_backend ( :$raw = False ) is also<ref-backend> {
    propReturnObject(
      e_data_book_view_ref_backend($!edbv),
      $raw,
      |::('Evolution::Book::Backend').getTypePair
    );
  }

}
