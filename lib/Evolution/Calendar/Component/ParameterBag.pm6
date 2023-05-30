use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Alarm::ParameterBag;

use GLib::Roles::Implementor;

# BOXED

class Evolution::Calendar::Component::ParameterBag {
  also does GLib::Roles::Implementor;

  has ECalComponentParameterBag $!eds-eccpb is implementor;

  submethod BUILD ( :$e-parameter-bag ) {
    $!eds-eccpb = $e-parameter-bag if $e-parameter-bag;
  }

  method Evolution::Raw::Definitions::ECalComponentParameterBag
  { $!eds-eccpb }

  multi method new (ECalComponentParameterBag $e-parameter-bag) {
    $e-parameter-bag ?? self.bless( :$e-parameter-bag ) !! Nil;
  }
  multi method new {
    my $e-parameter-bag = e_cal_component_parameter_bag_new();

    $e-parameter-bag ?? self.bless( :$e-parameter-bag ) !! Nil;
  }

  method new_from_property (
    ICalProperty() $property,
                   &func,
    gpointer       $user_data
  )
    is also<new-from-property>
  {
    my $e-parameter-bag = e_cal_component_parameter_bag_new_from_property(
      $property,
      &func,
      $user_data
    );

    $e-parameter-bag ?? self.bless( :$e-parameter-bag ) !! Nil;
  }

  method add (ICalParameter() $param) {
    e_cal_component_parameter_bag_add($!eds-eccpb, $param);
  }

  method assign (ECalComponentParameterBag() $src_bag) {
    e_cal_component_parameter_bag_assign($!eds-eccpb, $src_bag);
  }

  method clear {
    e_cal_component_parameter_bag_clear($!eds-eccpb);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_parameter_bag_copy($!eds-eccpb),
      $raw,
      |self.getTypePair
    );
  }

  method fill_property (ICalProperty() $property) is also<fill-property> {
    e_cal_component_parameter_bag_fill_property($!eds-eccpb, $property);
  }

  method free {
    e_cal_component_parameter_bag_free($!eds-eccpb);
  }

  method get (Int() $index, :$raw = False) {
    my guint $i = $index;

    propReturnObject(
      e_cal_component_parameter_bag_get($!eds-eccpb, $i),
      $raw,
      |ICal::GLib::Parameter.getTypePair
    );
  }

  method get_count is also<get-count> {
    e_cal_component_parameter_bag_get_count($!eds-eccpb);
  }

  method get_first_by_kind (ICalParameterKind() $kind)
    is also<get-first-by-kind>
  {
    e_cal_component_parameter_bag_get_first_by_kind($!eds-eccpb, $kind);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_parameter_bag_get_type,
      $n,
      $t
    );
  }

  method remove (Int() $index) {
    my guint $i = $index;

    e_cal_component_parameter_bag_remove($!eds-eccpb, $i);
  }

  method remove_by_kind (ICalParameterKind() $kind, Int() $all)
    is also<remove-by-kind>
  {
    my gboolean $a = $all.so.Int;

    e_cal_component_parameter_bag_remove_by_kind($!eds-eccpb, $kind, $a);
  }

  method set_from_property (
    ICalProperty() $property,
                   &func,
    gpointer       $user_data  = gpointer
  )
    is also<set-from-property>
  {
    e_cal_component_parameter_bag_set_from_property(
      $!eds-eccpb,
      $property,
      &func,
      $user_data
    );
  }

  method take (ICalParameter() $param) {
    e_cal_component_parameter_bag_take($!eds-eccpb, $param);
  }

}
