use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::PhoneNumber;

### /usr/include/evolution-data-server/libebook-contacts/e-phone-number.h

sub e_phone_number_compare (
  EPhoneNumber $first_number,
  EPhoneNumber $second_number
)
  returns EPhoneNumberMatch
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_compare_strings (
  Str                     $first_number,
  Str                     $second_number,
  CArray[Pointer[GError]] $error
)
  returns EPhoneNumberMatch
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_compare_strings_with_region (
  Str                     $first_number,
  Str                     $second_number,
  Str                     $region_code,
  CArray[Pointer[GError]] $error
)
  returns EPhoneNumberMatch
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_copy (EPhoneNumber $phone_number)
  returns EPhoneNumber
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_error_quark ()
  returns GQuark
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_free (EPhoneNumber $phone_number)
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_from_string (
  Str                     $phone_number,
  Str                     $region_code,
  CArray[Pointer[GError]] $error
)
  returns EPhoneNumber
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_get_country_code (
  EPhoneNumber              $phone_number,
  EPhoneNumberCountrySource $source        is rw
)
  returns gint
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_get_country_code_for_region (
  Str                     $region_code,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_get_default_region (CArray[Pointer[GError]] $error)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_get_national_number (EPhoneNumber $phone_number)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_is_supported ()
  returns uint32
  is native(ebook-contacts)
  is export
{ * }

sub e_phone_number_to_string (
  EPhoneNumber       $phone_number,
  EPhoneNumberFormat $format
)
  returns Str
  is native(ebook-contacts)
  is export
{ * }
