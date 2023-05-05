use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::NamedParameters;

use GLib::Roles::Implementor;

# BOXED

class Evolution::NamedParameters {
  also does Positional;
  also does Associative;

  has ENamedParameters $!eds-np is implementor;

  submethod BUILD ( :$e-named-parameters ) {
    $!eds-np = $e-named-parameters;
  }

  method Evolution::Raw::Structs::ENamedParameters
    is also<ENamedParameters>
  { $!eds-np }

  method Array {
    CArrayToArray( self.to_strv );
  }

  multi method new (ENamedParameters() $e-named-parameters) {
    $e-named-parameters ?? self.bless( :$e-named-parameters ) !! Nil;
  }
  multi method new {
    my $e-named-parameters = e_named_parameters_new();

    $e-named-parameters ?? self.bless( :$e-named-parameters ) !! Nil;
  }

  method new_clone (ENamedParameters() $parameters) is also<new-clone> {
    my $e-named-parameters =  e_named_parameters_new_clone($parameters);

    $e-named-parameters ?? self.bless( :$e-named-parameters ) !! Nil;
  }

  method new_string (Str() $string) is also<new-string> {
    my $e-named-parameters = e_named_parameters_new_string($string);

    $e-named-parameters ?? self.bless( :$e-named-parameters ) !! Nil;
  }

  multi method new (@strings) {
    self.new_strv( ArrayToCArray(Str, @strings, :null) );
  }
  method new_strv (CArray[Str] $strv) is also<new-strv> {
    my $e-named-parameters = e_named_parameters_new_strv($strv);

    $e-named-parameters ?? self.bless( :$e-named-parameters ) !! Nil;
  }

  method assign (ENamedParameters() $from) {
    e_named_parameters_assign($!eds-np, $from);
  }

  method clear {
    e_named_parameters_clear($!eds-np);
  }

  method count is also<elems> {
    e_named_parameters_count($!eds-np);
  }

  method equal (ENamedParameters() $parameters2) {
    so e_named_parameters_equal($!eds-np, $parameters2);
  }

  method exists (Str() $name) {
    so e_named_parameters_exists($!eds-np, $name);
  }

  method !free {
    e_named_parameters_free($!eds-np);
  }

  method get (Str() $name) {
    e_named_parameters_get($!eds-np, $name);
  }

  method get_name (Int() $index) is also<get-name> {
    my gint $i = $index;

    e_named_parameters_get_name($!eds-np, $i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_named_parameters_get_type, $n, $t );
  }

  method set (Str() $name, Str() $value) {
    e_named_parameters_set($!eds-np, $name, $value);
  }

  method test (Str() $name, Str() $value, Int() $case_sensitively) {
    my gboolean $c = $case_sensitively.so.Int;

    e_named_parameters_test($!eds-np, $name, $value, $c);
  }

  method to_string is also<to-string> {
    e_named_parameters_to_string($!eds-np);
  }

  method to_strv is also<to-strv> {
    ArrayToCArray(Str, e_named_parameters_to_strv($!eds-np), :null);
  }


  # ==== Positional ==== #
  method AT-POS (\k) is also<AT_POS> {
    self.get( self.get_name(k) );
  }
  method SET-POS (\k, \v) is also<SET_POS> {
    self.set( self.get_name(k), v );
  }

  method of { Str }

  # ==== Associative ==== #
  method AT-KEY (\k) is rw is also<AT_KEY> {
    Proxy.new:
      FETCH => -> $     { self.get_name(k)    },
      STORE => -> $, \v { self.set_name(k, v) };
  }
  method EXISTS-KEY (\k) is also<EXISTS_KEY> {
    self.exists(k);
  }

  method keys {
    do for ^self.count {
      self.get_name($_);
    }
  }

}
