use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::NamedParameters;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-named-parameters.h

sub e_named_parameters_assign (
  ENamedParameters $parameters,
  ENamedParameters $from
)
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_clear (ENamedParameters $parameters)
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_count (ENamedParameters $parameters)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_equal (
  ENamedParameters $parameters1,
  ENamedParameters $parameters2
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_exists (
  ENamedParameters $parameters,
  Str              $name
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_free (ENamedParameters $parameters)
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_get (
  ENamedParameters $parameters,
  Str              $name
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_get_name (
  ENamedParameters $parameters,
  gint             $index
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_new
  returns ENamedParameters
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_new_clone (ENamedParameters $parameters)
  returns ENamedParameters
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_new_string (Str $str)
  returns ENamedParameters
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_new_strv (CArray[Str] $strv)
  returns ENamedParameters
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_set (
  ENamedParameters $parameters,
  Str              $name,
  Str              $value
)
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_test (
  ENamedParameters $parameters,
  Str              $name,
  Str              $value,
  gboolean         $case_sensitively
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_to_string (ENamedParameters $parameters)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_named_parameters_to_strv (ENamedParameters $parameters)
  returns Str
  is      native(eds)
  is      export
{ * }
