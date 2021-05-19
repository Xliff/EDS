use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Backend::SExp;

class Evolution::Calendar::Backend::SExp {
  has ECalBackendSExp $!sexp;

  method new (Str() $value) {
    my $sexp = e_cal_backend_sexp_new($value);

    $sexp ?? self.bless( :$sexp ) !! Nil;
  }

  method evaluate_occur_times (Int() $start, Int() $end) {
    my time_t ($s, $e) = ($start, $end);

    e_cal_backend_sexp_evaluate_occur_times($!sexp, $s, $e);
  }

  proto method func_make_time (|)
  { * }

  multi method func_make_time (
    Evolution::Calendar::Backend::SExp:U:

    $sexp,
    @items,
    gpointer $data = gpointer
  ) {
    samewith( $sexp, @items.elems, ArrayToCArray(ESExpResult, @items), $data );
  }
  multi method func_make_time (
    Evolution::Calendar::Backend::SExp:U:

    ESExp()                      $sexp,
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint32 $ac = $argc;

    e_cal_backend_sexp_func_make_time($sexp, $ac, $argv, $data);
  }

  proto method func_time_add_day (|)
  { * }

  multi method func_time_add_day (
    Evolution::Calendar::Backend::SExp:U:

    $sexp,
    @items,
    gpointer $data = gpointer
  ) {
    samewith( $sexp, @items.elems, ArrayToCArray(ESExpResult, @items), $data );
  }
  multi method func_time_add_day (
    Evolution::Calendar::Backend::SExp:U:

    ESExp()                      $sexp,
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_add_day($sexp, $ac, $argv, $data);
  }

  proto method func_time_day_begin (|)
  { * }

  multi method func_time_day_begin (
    Evolution::Calendar::Backend::SExp:U:

    $sexp,
    @items,
    gpointer $data = gpointer
  ) {
    samewith( $sexp, @items.elems, ArrayToCArray(ESExpResult, @items), $data );
  }
  multi method func_time_day_begin (
    Evolution::Calendar::Backend::SExp:U:

    ESExp()                      $sexp,
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_day_begin($sexp, $ac, $argv, $data);
  }

  proto method func_time_day_end (|)
  { * }

  multi method func_time_day_end (
    Evolution::Calendar::Backend::SExp:U:

    $sexp,
    @items,
    gpointer $data = gpointer
  ) {
    samewith( @items.elems, ArrayToCArray(ESExpResult, @items), $data );
  }
  multi method func_time_day_end (
    Evolution::Calendar::Backend::SExp:U:

    ESExp()                      $sexp,
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_day_end($sexp, $ac, $argv, $data);
  }

  proto method func_time_now (|)
  { * }

  multi method func_time_now (
    Evolution::Calendar::Backend::SExp:U:

    $sexp,
    @items,
    gpointer $data = gpointer
  ) {
    samewith( $sexp, @items.elems, ArrayToCArray(ESExpResult, @items), $data );
  }
  multi method func_time_now (
    Evolution::Calendar::Backend::SExp:U:

    ESExp()                      $sexp,
    Int()                        $argc,
    CArray[Pointer[ESExpResult]] $argv,
    gpointer                     $data
  ) {
    my gint $ac = $argc;

    e_cal_backend_sexp_func_time_now($sexp, $ac, $argv, $data);
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
