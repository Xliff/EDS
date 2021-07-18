use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::SExp;

use GLib::Roles::Object;

our subset ESExpAncestry is export of Mu
  where ESExp | GObject;

class Evolution::SExp {
  also does GLib::Roles::Object;

  has ESExp $!ee;

  submethod BUILD (:$expr) {
    self.setESExp($expr) if $expr;
  }

  method setESExp (ESExpAncestry $_) {
    my $to-parent;

    $!ee = do {
      when ESExp {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESExp, $_);
      }
    }
    self!setObject($to-parent);
  }

  method EDS::Raw::Definitions::ESExp
  { $!ee }

  proto method new (|)
  { * }

  multi method new (ESExpAncestry $expr, :$ref = True) {
    return Nil unless $expr;

    my $o = self.bless( :$expr );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $expr = e_sexp_new();

    $expr ?? self.bless( :$expr ) !! Nil;
  }

  method add_function (
    Int()    $scope,
    Str()    $name,
             &func,
    gpointer $user_data = gpointer
  ) {
    my gint $s = $scope;

    e_sexp_add_function($!ee, $s, $name, &func, $user_data);
  }

  method add_ifunction (
    Int()    $scope,
    Str()    $name,
             &func,
    gpointer $user_data = gpointer
  ) {
    my gint $s = $scope;

    e_sexp_add_ifunction($!ee, $s, $name, &func, $user_data);
  }

  method add_variable (Int() $scope, Str() $name, ESExpTerm() $value) {
    my gint $s = $scope;

    e_sexp_add_variable($!ee, $s, $name, $value);
  }

  method encode_bool (Evolution::SExp:U: GString() $str, Int() $state) {
    my gboolean $s = $state.so.Int;

    e_sexp_encode_bool($str, $s);
  }

  # cw: is $s an out parameter?
  method encode_string (Evolution::SExp:U: GString() $s, Str() $string) {
    e_sexp_encode_string($s, $string);
  }

  method eval (:$raw = False) {
    e_sexp_eval($!ee);
  }

  method evaluate_occur_times (Int() $start, Int() $end) {
    my time_t ($s, $e) = ($start, $end);

    so e_sexp_evaluate_occur_times($!ee, $s, $e);
  }

  method fatal_error (Str() $why) {
    e_sexp_fatal_error($!ee, $why);
  }

  method get_error {
    e_sexp_get_error($!ee);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_sexp_get_type, $n, $t );
  }

  method input_file (Int() $fd) {
    my gint $_fd = $fd;

    e_sexp_input_file($!ee, $_fd);
  }

  method input_text (Str() $text, Int() $len = $text.chars) {
    e_sexp_input_text($!ee, $text, $len);
  }

  method parse {
    e_sexp_parse($!ee);
  }

  method parse_value {
    e_sexp_parse_value($!ee);
  }

  method remove_symbol (Int() $scope, Str() $name) {
    my gint $s = $scope;

    e_sexp_remove_symbol($!ee, $s, $name);
  }

  proto method result_free (|)
  { * }

  multi method result_free (ESExpResult $t) {
    e_sexp_result_free($!ee, $t);
  }
  multi method result_free (@results) {
    self.result_free($_) for @results.map({ checkForType(ESExpResult, $_) })
  }
  multi method result_free (Int() $argc, CArray[Pointer[ESExpResult]] $argv) {
    my gint $c = $argc;

    e_sexp_resultv_free($!ee, $c, $argv);
  }

  method result_new (Int() $type) {
    my gint $t = $type;

    e_sexp_result_new($!ee, $t);
  }

  method set_scope (Int() $scope) {
    my gint $s = $scope;

    e_sexp_set_scope($!ee, $s);
  }

  method term_eval (ESExpTerm() $t) {
    e_sexp_term_eval($!ee, $t);
  }

}
