use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Contact;

### /usr/include/evolution-data-server/libebook-contacts/e-contact.h

sub e_contact_address_free (EContactAddress $address)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_address_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_address_new ()
  returns EContactAddress
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_attr_list_copy (GList $list)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_attr_list_free (GList $list)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_attr_list_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_cert_free (EContactCert $cert)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_cert_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_cert_new ()
  returns EContactCert
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_equal (EContactDate $dt1, EContactDate $dt2)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_free (EContactDate $date)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_from_string (Str $str)
  returns EContactDate
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_new ()
  returns EContactDate
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_date_to_string (EContactDate $dt)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_duplicate (EContact $contact)
  returns EContact
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_field_id (Str $field_name)
  returns EContactField
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_field_id_from_vcard (Str $vcard_field)
  returns EContactField
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_field_is_string (EContactField $field_id)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_field_name (EContactField $field_id)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_field_type (EContactField $field_id)
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_geo_free (EContactGeo $geo)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_geo_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_geo_new ()
  returns EContactGeo
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_get (EContact $contact, EContactField $field_id)
  returns Pointer
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_get_attributes (EContact $contact, EContactField $field_id)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_get_attributes_set (
  EContact      $contact,
  EContactField $field_ids,
  gint          $size
)
  returns GList
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_get_const (EContact $contact, EContactField $field_id)
  returns gconstpointer
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_inline_local_photos (
  EContact                $contact,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_copy (EContactName $n)
  returns EContactName
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_free (EContactName $name)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_from_string (Str $name_str)
  returns EContactName
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_new ()
  returns EContactName
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_name_to_string (EContactName $name)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_new ()
  returns EContact
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_new_from_vcard (Str $vcard)
  returns EContact
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_new_from_vcard_with_uid (Str $vcard, Str $uid)
  returns EContact
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_copy (EContactPhoto $photo)
  returns EContactPhoto
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_free (EContactPhoto $photo)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_get_inlined (EContactPhoto $photo, gsize $len)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_get_mime_type (EContactPhoto $photo)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_get_uri (EContactPhoto $photo)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_new ()
  returns EContactPhoto
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_set_inlined (EContactPhoto $photo, Str $data, gsize $len)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_set_mime_type (EContactPhoto $photo, Str $mime_type)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_photo_set_uri (EContactPhoto $photo, Str $uri)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_pretty_name (EContactField $field_id)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_set (
  EContact      $contact,
  EContactField $field_id,
  gconstpointer $value
)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_set_attributes (
  EContact      $contact,
  EContactField $field_id,
  GList         $attributes
)
  is native(ebook-contacts)
  is export
{ * }

sub e_contact_vcard_attribute (EContactField $field_id)
  returns Str
  is native(ebook-contacts)
  is export
{ * }
