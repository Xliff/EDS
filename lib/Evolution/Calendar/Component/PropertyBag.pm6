use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::PropertyBag;

use GLib::Roles::Implementor;

# BOXED

class Evolution::Calendar::Component::PropertyBag {
  also does GLib::Roles::Implementor;

  has ECalComponentPropertyBag $!eds-eccpb is implementor;

  submethod BUILD ( :$e-property-bag ) {
    $!eds-eccpb = $e-property-bag if $e-property-bag;
  }

  method Evolution::Raw::Definitions::ECalComponentPropertyBag
  { $!eds-eccpb }

  multi method new (ECalComponentPropertyBag $e-property-bag) {
    $e-property-bag ?? self.bless( :$e-property-bag ) !! Nil;
  }
  multi method new {
    my $e-property-bag = e_cal_component_property_bag_new();

    $e-property-bag ?? self.bless( :$e-property-bag ) !! Nil;
  }

  method new_from_component (
    ICalComponent() $component,
                    &func,
    gpointer        $user_data  = gpointer
  ) {
    my $e-property-bag = e_cal_component_property_bag_new_from_component(
      $component,
      &func,
      $user_data
    );

    $e-property-bag ?? self.bless( :$e-property-bag ) !! Nil;
  }

  method add (ICalProperty() $prop) {
    e_cal_component_property_bag_add($!eds-eccpb, $prop);
  }

  method assign (ECalComponentPropertyBag() $src_bag) {
    e_cal_component_property_bag_assign($!eds-eccpb, $src_bag);
  }

  method clear {
    e_cal_component_property_bag_clear($!eds-eccpb);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_property_bag_copy($!eds-eccpb),
      $raw,
      |self.getTypePair
    );
  }

  method fill_component (ICalComponent() $component) {
    e_cal_component_property_bag_fill_component($!eds-eccpb, $component);
  }

  method free {
    e_cal_component_property_bag_free($!eds-eccpb);
  }

  method get (Int() $index, :$raw = False) {
    my guint $i = $index;

    propReturnObject(
      e_cal_component_property_bag_get($!eds-eccpb, $i),
      $raw,
      |ICal::GLib::Property.getTypePair
    );
  }

  method get_count {
    e_cal_component_property_bag_get_count($!eds-eccpb);
  }

  method get_first_by_kind (ICalPropertyKind() $kind) {
    e_cal_component_property_bag_get_first_by_kind($!eds-eccpb, $kind);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_property_bag_get_type,
      $n,
      $t
    );
  }

  method remove (Int() $index) {
    my guint $i = $index;

    e_cal_component_property_bag_remove($!eds-eccpb, $i);
  }

  method remove_by_kind (Int() $kind, Int() $all) {
    my ICalPropertyKind $k = $kind;
    my gboolean         $a = $all.so.Int;

    e_cal_component_property_bag_remove_by_kind($!eds-eccpb, $k, $a);
  }

  method set_from_component (
    ICalComponent() $component,
                    &func,
    gpointer        $user_data  = gpointer
  ) {
    e_cal_component_property_bag_set_from_component(
      $!eds-eccpb,
      $component,
      &func,
      $user_data
    );
  }

  method take (ICalProperty() $prop) {
    e_cal_component_property_bag_take($!eds-eccpb, $prop);
  }

}
