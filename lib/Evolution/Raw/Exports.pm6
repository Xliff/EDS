use v6.c;

unit package Evolution::Raw::Exports;

our @evolution-exports is export;

BEGIN {
  @evolution-exports = <
    GLib::Compat::Definitions
    Evolution::Raw::Constants
    Evolution::Raw::Definitions
    Evolution::Raw::Enums
    Evolution::Raw::Structs
  >;
}
