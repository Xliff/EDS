use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Organizer;

use ICal::GLib::Property;
use Evolution::Calendar::Component::ParameterBag;

use GLib::Roles::Implementor;

# BOXED

class Evolution::Calendar::Component::Organizer {
  has ECalComponentOrganizer $!eds-cco is implementor;

  submethod BUILD ( :$e-calendar-organizer ) {
    $!eds-cco = $e-calendar-organizer if $e-calendar-organizer;
  }

  multi method Evolution::Raw::Definitions::ECalComponentOrganizer
    is also<ECalComponentOrganizer>
  { $!eds-cco }

  multi method new (
    ECalComponentOrganizer $e-calendar-organizer,

    :$ref = True
  ) {
    return unless $e-calendar-organizer;

    my $o = self.bless( :$e-calendar-organizer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $e-calendar-organizer = e_cal_component_organizer_new();

    $e-calendar-organizer ?? self.bless( :$e-calendar-organizer ) !! Nil;
  }

  method new_from_property (ICalProperty $property) is also<new-from-property> {
    my $e-calendar-organizer = e_cal_component_organizer_new_from_property(
      $property
    );

    $e-calendar-organizer ?? self.bless( :$e-calendar-organizer ) !! Nil;
  }

  method new_full (
    Str() $value,
    Str() $sentby,
    Str() $cn,
    Str() $language
  )
    is also<new-full>
  {
    my $e-calendar-organizer = e_cal_component_organizer_new_full(
      $value,
      $sentby,
      $cn,
      $language
    );

    $e-calendar-organizer ?? self.bless( :$e-calendar-organizer ) !! Nil;
  }

  method cn is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_cn    },
      STORE => -> $, \v { self.set_cn(v) }
  }

  method language is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_language    },
      STORE => -> $, \v { self.set_language(v) }
  }

  method sentby is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_sentby    },
      STORE => -> $, \v { self.set_sentby(v) }
  }

  method value is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_value    },
      STORE => -> $, \v { self.set_value(v) }
  }


  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_organizer_copy($!eds-cco),
      $raw,
      |self.getTypePair
    );
  }

  method fill_property (ICalProperty() $property) is also<fill-property> {
    e_cal_component_organizer_fill_property($!eds-cco, $property);
  }

  method free {
    e_cal_component_organizer_free($!eds-cco);
  }

  method get_as_property ( :$raw = False ) is also<get-as-property> {
    propReturnObject(
      e_cal_component_organizer_get_as_property($!eds-cco),
      $raw,
      |ICal::GLib::Property.getTypePair
    );
  }

  method get_cn is also<get-cn> {
    e_cal_component_organizer_get_cn($!eds-cco);
  }

  method get_language is also<get-language> {
    e_cal_component_organizer_get_language($!eds-cco);
  }

  method get_parameter_bag ( :$raw = False ) is also<get-parameter-bag> {
    propReturnObject(
      e_cal_component_organizer_get_parameter_bag($!eds-cco),
      $raw,
      |Evolution::Calendar::Component::ParameterBag.getTypePair
    );
  }

  method get_sentby is also<get-sentby> {
    e_cal_component_organizer_get_sentby($!eds-cco);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_organizer_get_type,
      $n,
      $t
    );
  }

  method get_value is also<get-value> {
    e_cal_component_organizer_get_value($!eds-cco);
  }

  method set_cn (Str() $cn) is also<set-cn> {
    e_cal_component_organizer_set_cn($!eds-cco, $cn);
  }

  method set_from_property (ICalProperty() $property) is also<set-from-property> {
    e_cal_component_organizer_set_from_property($!eds-cco, $property);
  }

  method set_language (Str() $language) is also<set-language> {
    e_cal_component_organizer_set_language($!eds-cco, $language);
  }

  method set_sentby (Str() $sentby) is also<set-sentby> {
    e_cal_component_organizer_set_sentby($!eds-cco, $sentby);
  }

  method set_value (Str() $value) is also<set-value> {
    e_cal_component_organizer_set_value($!eds-cco, $value);
  }

}
