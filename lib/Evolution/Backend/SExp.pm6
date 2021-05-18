use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Backend::SExp;

class Evolution::Backend::SExp {
  has ECalBackendSexp $!sexp;

  method new {
    my $sexp = e_cal_backend_sexp_new();

    $sexp ?? self.bless( :$sexp ) !! Nil;
  }

  method evaluate_occur_times (Int() $start, Int() $end) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_backend_sexp_evaluate_occur_times($!sexp, $s, $e);
  }

  proto method func_make_time (|)

  multi method func_make_time (@items, gpointer $data = gpointer) {
    samewith(@item.elems, ArrayToCArray(ESExpResult, @items) );
  }
  multi method func_make_time (
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_make_time($!sexp, $ac, $argv, $data);
  }

  proto method func_time_add_day (|)
  { * }

  method func_time_add_day (@items, gpointer $data = gpointer) {
    samewith(@item.elems, ArrayToCArray(ESExpResult, @items) );
  }
  method func_time_add_day (
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_add_day($!sexp, $ac, $argv, $data);
  }

  proto method func_time_day_begin (|)
  { * }

  multi method func_time_day_begin (@items, gpointer $data = gpointer) {
    samewith(@item.elems, ArrayToCArray(ESExpResult, @items) );
  }
  multi method func_time_day_begin (
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_day_begin($!sexp, $ac, $argv, $data);
  }

  proto method func_time_day_end (|)
  { * }

  multi method func_time_day_end (@items, gpointer $data = gpointer) {
    samewith(@item.elems, ArrayToCArray(ESExpResult, @items) );
  }
  multi method func_time_day_end (
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_day_end($!sexp, $ac, $argv, $data);
  }

  proto method func_time_now (|)
  { * }

  multi method func_time_now (@items, gpointer $data = gpointer) {
    samewith(@item.elems, ArrayToCArray(ESExpResult, @items) );
  }
  multi method func_time_now (
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_now($!sexp, $ac, $argv, $data);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_backend_sexp_get_type, $n, $t );
  }

  method lock {
    e_cal_backend_sexp_lock($!sexp);
  }

  method match_comp (ECalComponent() $comp, ETimezoneCache() $cache) {
    so e_cal_backend_sexp_match_comp($!sexp, $comp, $cache);
  }

  method match_object (Str() $object, ETimezoneCache() $cache) {
    so e_cal_backend_sexp_match_object($!sexp, $object, $cache);
  }

  method text {
    e_cal_backend_sexp_text($!sexp);
  }

  method unlock {
    e_cal_backend_sexp_unlock($!sexp);
  }

}
