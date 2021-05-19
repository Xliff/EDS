use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Backend::SExp;

### /usr/include/evolution-data-server/libedata-cal/e-cal-backend-sexp.h

sub e_cal_backend_sexp_evaluate_occur_times (
  ECalBackendSExp $sexp,
  time_t          $start,
  time_t          $end
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_func_make_time (
  ESExp                        $esexp,
  gint                         $argc,
  CArray[Pointer[ESExpResult]] $argv,
  gpointer                     $data
)
  returns ESExpResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_func_time_add_day (
  ESExp                        $esexp,
  gint                         $argc,
  CArray[Pointer[ESExpResult]] $argv,
  gpointer                     $data
)
  returns ESExpResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_func_time_day_begin (
  ESExp                        $esexp,
  gint                         $argc,
  CArray[Pointer[ESExpResult]] $argv,
  gpointer                     $data
)
  returns ESExpResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_func_time_day_end (
  ESExp                        $esexp,
  gint                         $argc,
  CArray[Pointer[ESExpResult]] $argv,
  gpointer                     $data
)
  returns ESExpResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_func_time_now (
  ESExp                        $esexp,
  gint                         $argc,
  CArray[Pointer[ESExpResult]] $argv,
  gpointer                     $data
)
  returns ESExpResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_lock (ECalBackendSExp $sexp)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_match_comp (
  ECalBackendSExp $sexp,
  ECalComponent   $comp,
  ETimezoneCache  $cache
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_match_object (
  ECalBackendSExp $sexp,
  Str             $object,
  ETimezoneCache  $cache
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_new (Str $text)
  returns ECalBackendSExp
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_text (ECalBackendSExp $sexp)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sexp_unlock (ECalBackendSExp $sexp)
  is native(edata-cal)
  is export
{ * }
