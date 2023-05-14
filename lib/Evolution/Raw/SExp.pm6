use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::SExp;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-sexp.h

sub e_sexp_add_function (
  ESExp    $sexp,
  gint     $scope,
  Str      $name,
           &func (
            ESExp,
            gint,
            CArray[Pointer[ESExpResult]],
            gpointer
            --> ESExpResult
          ),
  gpointer $user_data
)
  is native(eds)
  is export
{ * }

sub e_sexp_add_ifunction (
  ESExp $sexp,
  gint $scope,
  Str $name,
  &func (ESExp, gint, CArray[Pointer[ESExpTerm]] --> ESExpResult),
  gpointer $user_data
)
  is native(eds)
  is export
{ * }

sub e_sexp_add_variable (ESExp $sexp, gint $scope, Str $name, ESExpTerm $value)
  is native(eds)
  is export
{ * }

sub e_sexp_encode_bool (GString $s, gboolean $state)
  is native(eds)
  is export
{ * }

sub e_sexp_encode_string (GString $s, Str $string)
  is native(eds)
  is export
{ * }

sub e_sexp_eval (ESExp $sexp)
  returns ESExpResult
  is native(eds)
  is export
{ * }

sub e_sexp_evaluate_occur_times (ESExp $sexp, time_t $start, time_t $end)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_sexp_fatal_error (ESExp $sexp, Str $why)
  is native(eds)
  is export
{ * }

sub e_sexp_get_error (ESExp $sexp)
  returns Str
  is native(eds)
  is export
{ * }

sub e_sexp_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_sexp_input_file (ESExp $sexp, gint $fd)
  is native(eds)
  is export
{ * }

sub e_sexp_input_text (ESExp $sexp, Str $text, gint $len)
  is native(eds)
  is export
{ * }

sub e_sexp_new ()
  returns ESExp
  is native(eds)
  is export
{ * }

sub e_sexp_parse (ESExp $sexp)
  returns gint
  is native(eds)
  is export
{ * }

sub e_sexp_parse_value (ESExp $sexp)
  returns ESExpTerm
  is native(eds)
  is export
{ * }

sub e_sexp_remove_symbol (ESExp $sexp, gint $scope, Str $name)
  is native(eds)
  is export
{ * }

sub e_sexp_result_free (ESExp $sexp, ESExpResult $t)
  is native(eds)
  is export
{ * }

sub e_sexp_result_new (ESExp $sexp, gint $type)
  returns ESExpResult
  is native(eds)
  is export
{ * }

sub e_sexp_resultv_free (ESExp $sexp, gint $argc,  CArray[Pointer[ESExpResult]] $argv)
  is native(eds)
  is export
{ * }

sub e_sexp_set_scope (ESExp $sexp, gint $scope)
  returns gint
  is native(eds)
  is export
{ * }

sub e_sexp_term_eval (ESExp $sexp, ESExpTerm $t)
  returns ESExpResult
  is native(eds)
  is export
{ * }
