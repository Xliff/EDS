use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Goa;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-goa.h

sub e_source_goa_dup_account_id (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_dup_address (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_dup_calendar_url (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_dup_contacts_url (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_dup_name (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_account_id (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_address (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_calendar_url (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_contacts_url (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_name (ESourceGoa $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_goa_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_goa_set_account_id (ESourceGoa $extension, Str $account_id)
  is native(eds)
  is export
{ * }

sub e_source_goa_set_address (ESourceGoa $extension, Str $address)
  is native(eds)
  is export
{ * }

sub e_source_goa_set_calendar_url (ESourceGoa $extension, Str $calendar_url)
  is native(eds)
  is export
{ * }

sub e_source_goa_set_contacts_url (ESourceGoa $extension, Str $contacts_url)
  is native(eds)
  is export
{ * }

sub e_source_goa_set_name (ESourceGoa $extension, Str $name)
  is native(eds)
  is export
{ * }
