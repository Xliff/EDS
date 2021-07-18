use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::Collator;

### /usr/include/evolution-data-server/libedataserver/e-collator.h

sub e_collator_collate (
  ECollator               $collator,
  Str                     $str_a,
  Str                     $str_b,
  gint                    $result    is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_collator_error_quark ()
  returns GQuark
  is native(eds)
  is export
{ * }

sub e_collator_generate_key (
  ECollator               $collator,
  Str                     $str,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_collator_generate_key_for_index (ECollator $collator, gint $index)
  returns Str
  is native(eds)
  is export
{ * }

sub e_collator_get_index (ECollator $collator, Str $str)
  returns gint
  is native(eds)
  is export
{ * }

sub e_collator_get_index_labels (
  ECollator $collator,
  gint      $n_labels  is rw,
  gint      $underflow is rw,
  gint      $inflow    is rw,
  gint      $overflow  is rw
)
  returns CArray[Str]
  is native(eds)
  is export
{ * }

sub e_collator_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_collator_new (Str $locale, CArray[Pointer[GError]] $error)
  returns ECollator
  is native(eds)
  is export
{ * }

sub e_collator_new_interpret_country (
  Str                     $locale,
  Str                     $country_code,
  CArray[Pointer[GError]] $error
)
  returns ECollator
  is native(eds)
  is export
{ * }

sub e_collator_ref (ECollator $collator)
  returns ECollator
  is native(eds)
  is export
{ * }

sub e_collator_unref (ECollator $collator)
  is native(eds)
  is export
{ * }
