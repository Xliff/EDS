use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Destination;

### /usr/src/evolution-data-server-3.48.0/src/libebook/e-destination.h

sub e_destination_copy (EDestination $dest)
  returns EDestination
  is native(ebook)
  is export
{ * }

sub e_destination_empty (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_equal (EDestination $a, EDestination $b)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_export (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_export_to_vcard_attribute (
  EDestination    $dest,
  EVCardAttribute $attr
)
  is native(ebook)
  is export
{ * }

sub e_destination_exportv (CArray[Pointer[EDestination]] $destv)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_freev (CArray[Pointer[EDestination]] $destv)
  is native(ebook)
  is export
{ * }

sub e_destination_get_address (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_contact (EDestination $dest)
  returns EContact
  is native(ebook)
  is export
{ * }

sub e_destination_get_contact_uid (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_email (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_email_num (EDestination $dest)
  returns gint
  is native(ebook)
  is export
{ * }

sub e_destination_get_html_mail_pref (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_get_name (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_source_uid (EDestination $dest)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_textrep (EDestination $dest, gboolean $include_email)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_textrepv (CArray[Pointer[EDestination]] $destv)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_destination_get_type ()
  returns GType
  is native(ebook)
  is export
{ * }

sub e_destination_import (Str $str)
  returns EDestination
  is native(ebook)
  is export
{ * }

sub e_destination_importv (Str $str)
  returns CArray[Pointer[EDestination]]
  is native(ebook)
  is export
{ * }

sub e_destination_is_auto_recipient (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_is_evolution_list (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_is_ignored (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_list_get_dests (EDestination $dest)
  returns GList
  is native(ebook)
  is export
{ * }

sub e_destination_list_get_root_dests (EDestination $dest)
  returns GList
  is native(ebook)
  is export
{ * }

sub e_destination_list_show_addresses (EDestination $dest)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_destination_new ()
  returns EDestination
  is native(ebook)
  is export
{ * }

sub e_destination_set_auto_recipient (EDestination $dest, gboolean $value)
  is native(ebook)
  is export
{ * }

sub e_destination_set_book (EDestination $dest, EBook $book)
  is native(ebook)
  is export
{ * }

sub e_destination_set_client (EDestination $dest, EBookClient $client)
  is native(ebook)
  is export
{ * }

sub e_destination_set_contact (
  EDestination $dest,
  EContact     $contact,
  gint         $email_num
)
  is native(ebook)
  is export
{ * }

sub e_destination_set_contact_uid (
  EDestination $dest,
  Str          $uid,
  gint         $email_num
)
  is native(ebook)
  is export
{ * }

sub e_destination_set_email (EDestination $dest, Str $email)
  is native(ebook)
  is export
{ * }

sub e_destination_set_html_mail_pref (EDestination $dest, gboolean $flag)
  is native(ebook)
  is export
{ * }

sub e_destination_set_ignored (EDestination $dest, gboolean $ignored)
  is native(ebook)
  is export
{ * }

sub e_destination_set_name (EDestination $dest, Str $name)
  is native(ebook)
  is export
{ * }

sub e_destination_set_raw (EDestination $dest, Str $raw)
  is native(ebook)
  is export
{ * }
