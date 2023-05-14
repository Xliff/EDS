use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evoution::Raw::Book::Client;

### /usr/src/evolution-data-server-3.48.0/src/libebook/e-book-client.h

sub e_book_client_add_contact (
	EBookClient  $client,
	EContact     $contact,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_add_contact_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Str]             $out_added_uid,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_add_contact_sync (
	EBookClient             $client,
	EContact                $contact,
	guint32                 $opflags,
	CArray[Str]             $out_added_uid,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_add_contacts (
	EBookClient  $client,
	GSList       $contacts,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_add_contacts_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GSList]] $out_added_uids,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_add_contacts_sync (
	EBookClient             $client,
	GSList                  $contacts,
	guint32                 $opflags,
	GSList                  $out_added_uids,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_connect (
	ESource      $source,
	guint32      $wait_for_connected_seconds,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_connect_direct (
	ESource      $source,
	guint32      $wait_for_connected_seconds,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_connect_direct_finish (
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ebook)
  is export
{ * }

sub e_book_client_connect_direct_sync (
	ESourceRegistry         $registry,
	ESource                 $source,
	guint32                 $wait_for_connected_seconds,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ebook)
  is export
{ * }

sub e_book_client_connect_finish (
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ebook)
  is export
{ * }

sub e_book_client_connect_sync (
	ESource                 $source,
	guint32                 $wait_for_connected_seconds,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contact (
	EBookClient  $client,
	Str          $uid,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contact_finish (
	EBookClient               $client,
	GAsyncResult              $result,
	CArray[Pointer[EContact]] $out_contact,
	CArray[Pointer[GError]]   $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contact_sync (
	EBookClient               $client,
	Str                       $uid,
	CArray[Pointer[EContact]] $out_contact,
	GCancellable              $cancellable,
	CArray[Pointer[GError]]   $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts (
	EBookClient  $client,
	Str          $sexp,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GSList]] $out_contacts,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts_sync (
	EBookClient             $client,
	Str                     $sexp,
	CArray[Pointer[GSList]] $out_contacts,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts_uids (
	EBookClient  $client,
	Str          $sexp,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts_uids_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	GSList                  $out_contact_uids,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_contacts_uids_sync (
	EBookClient             $client,
	Str                     $sexp,
	GSList                  $out_contact_uids,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_cursor (
	EBookClient         $client,
	Str                 $sexp,
	EContactField       $sort_fields,
	EBookCursorSortType $sort_types,
	guint               $n_fields,
	GCancellable        $cancellable,
	                    &callback (ECalClient, GAsyncResult, gpointer),
	gpointer            $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_get_cursor_finish (
	EBookClient                        $client,
	GAsyncResult                       $result,
	CArray[Pointer[EBookClientCursor]] $out_cursor,
	CArray[Pointer[GError]]            $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_cursor_sync (
	EBookClient                 $client,
	Str                         $sexp,
	CArray[EContactField]       $sort_fields,
	CArray[EBookCursorSortType] $sort_types,
	guint                       $n_fields,
	EBookClientCursor           $out_cursor,
	GCancellable                $cancellable,
	CArray[Pointer[GError]]     $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_locale (EBookClient $client)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_book_client_get_self (
	ESourceRegistry              $registry,
	CArray[Pointer[EContact]]    $out_contact,
	CArray[Pointer[EBookClient]] $out_client,
	CArray[Pointer[GError]]      $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_type ()
  returns GType
  is native(ebook)
  is export
{ * }

sub e_book_client_get_view (
	EBookClient  $client,
	Str          $sexp,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_get_view_finish (
	EBookClient                       $client,
	GAsyncResult                      $result,
	CArray[Pointer[EBookClientView]]  $out_view,
	CArray[Pointer[GError]]           $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_get_view_sync (
	EBookClient                      $client,
	Str                              $sexp,
	CArray[Pointer[EBookClientView]] $out_view,
	GCancellable                     $cancellable,
	CArray[Pointer[GError]]          $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_is_self (EContact $contact)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contact (
	EBookClient  $client,
	EContact     $contact,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contact_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contact_sync (
	EBookClient             $client,
	EContact                $contact,
	guint32                 $opflags,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contacts (
	EBookClient  $client,
	GSList       $contacts,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contacts_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_modify_contacts_sync (
	EBookClient             $client,
	GSList                  $contacts,
	guint32                 $opflags,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_new (
	ESource                 $source,
	CArray[Pointer[GError]] $error
)
  returns EBookClient
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact (
	EBookClient  $client,
	EContact     $contact,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact_by_uid (
	EBookClient  $client,
	Str          $uid,
	guint32      $opflags,
	GCancellable $cancellable,
	             &callback (ECalClient, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact_by_uid_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact_by_uid_sync (
	EBookClient             $client,
	Str                     $uid,
	guint32                 $opflags,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contact_sync (
	EBookClient             $client,
	EContact                $contact,
	guint32                 $opflags,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contacts (
	EBookClient   $client,
	GSList        $uids,
	guint32       $opflags,
	GCancellable  $cancellable,
	              &callback (ECalClient, GAsyncResult, gpointer),
	gpointer      $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contacts_finish (
	EBookClient             $client,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_remove_contacts_sync (
	EBookClient             $client,
	GSList                  $uids,
	guint32                 $opflags,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_set_self (
	EBookClient             $client,
	EContact                $contact,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

### /usr/src/evolution-data-server-3.48.0/src/libebook-contact/e-book-contacts-utils.h

sub e_book_client_error_quark ()
	returns GQuark
	is native(ebook-contacts)
	is export
{ * }
