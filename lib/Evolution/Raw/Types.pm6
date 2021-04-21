use v6;

use GLib::Raw::Exports;
use ATK::Raw::Exports;
use GIO::Raw::Exports;
use SOUP::Raw::Exports;
use Evolution::Raw::Exports;

unit package Evolution::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need ATK::Raw::Definitions;
need ATK::Raw::Enums;
need ATK::Raw::Structs;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Quarks;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::DBus::Raw::Types;
need GIO::Raw::Exports;
need SOUP::Raw::Definitions;
need SOUP::Raw::Enums;
need SOUP::Raw::Subs;
need Evolution::Raw::Constants;
need Evolution::Raw::Definitions;
need Evolution::Raw::Enums;
need Evolution::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@atk-exports,
                         |@gio-exports,
                         |@soup-exports,
                         |@evolution-exports;
}
