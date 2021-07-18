use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Collator;

class Evolution::Collator {
  has ECollator $!c;

  submethod BUILD (:$collator) {
    $!c = $collator;
  }

  method new (Str() $locale, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $collator = e_collator_new($locale, $error);
    set_error($error);

    $collator ?? self.bless( :$collator ) !! Nil;
  }

  method new_interpret_country (
    Str()                   $locale,
    Str()                   $country_code,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $collator = e_collator_new_interpret_country(
      $locale,
      $country_code,
      $error
    );
    set_error($error);

    $collator ?? self.bless( :$collator ) !! Nil;
  }

  proto method collate (|)
  { * }

  multi method collate (
    Str()                   $str_a,
    Str()                   $str_b,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    my $rv = samewith($str_a, $str_b, $, $error, :all);
    $rv ?? $rv[1] !! Nil;
  }
  multi method collate (
    Str()                   $str_a,
    Str()                   $str_b,
    Int()                   $result is rw,
    CArray[Pointer[GError]] $error  =  gerror,
                            :$all   =  False
  ) {
    my gint $r = 0;
    clear_error;
    my $rv = so e_collator_collate($!c, $str_a, $str_b, $r, $error);
    set_error($error);
    $result = $r;

    $all.not ?? $rv !! ($rv, $result)
  }

  method error_quark (Evolution::Collator:U: ){
    e_collator_error_quark();
  }

  method generate_key (Str $str, CArray[Pointer[GError]] $error = gerror) {
    e_collator_generate_key($!c, $str, $error);
  }

  method generate_key_for_index (Int() $index) {
    my gint $i = $index;

    e_collator_generate_key_for_index($!c, $i);
  }

  method get_index (Str() $str) {
    e_collator_get_index($!c, $str);
  }

  proto method get_index_labels (|)
  { * }

  multi method get_index_labels {
    samewith($, $, $, $, :all)
  }
  multi method get_index_labels (
    $n_labels  is rw,
    $underflow is rw,
    $inflow    is rw,
    $overflow  is rw,
  ) {
    my gint ($n, $u, $i, $o) = 0 xx 4;
    my @labels = CStringArrayToArray(
      e_collator_get_index_labels($!c, $n, $u, $i, $o)
    );
    ($n_labels, $underflow, $inflow, $overflow) = ($n, $u, $i, $o);
    (@labels, $n_labels, $underflow, $inflow, $overflow);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_collator_get_type, $n, $t );
  }

  method ref {
    e_collator_ref($!c);
    self;
  }

  method unref {
    e_collator_unref($!c);
  }

}
