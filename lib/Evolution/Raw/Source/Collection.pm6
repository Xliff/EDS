use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Source::Collection;

### /usr/include/evolution-data-server/libedataserver/e-source-collection.h

sub e_source_collection_dup_calendar_url (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_dup_contacts_url (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_dup_identity (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_get_allow_sources_rename (ESourceCollection $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_collection_get_calendar_enabled (ESourceCollection $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_collection_get_calendar_url (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_get_contacts_enabled (ESourceCollection $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_collection_get_contacts_url (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_get_identity (ESourceCollection $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_collection_get_mail_enabled (ESourceCollection $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_collection_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_collection_set_allow_sources_rename (
  ESourceCollection $extension,
  gboolean          $allow_sources_rename
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_calendar_enabled (
  ESourceCollection $extension,
  gboolean          $calendar_enabled
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_calendar_url (
  ESourceCollection $extension,
  Str               $calendar_url
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_contacts_enabled (
  ESourceCollection $extension,
  gboolean          $contacts_enabled
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_contacts_url (
  ESourceCollection $extension,
  Str               $contacts_url
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_identity (
  ESourceCollection $extension,
  Str               $identity
)
  is native(eds)
  is export
{ * }

sub e_source_collection_set_mail_enabled (
  ESourceCollection $extension,
  gboolean          $mail_enabled
)
  is native(eds)
  is export
{ * }
