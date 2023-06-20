use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Alarms;

use GLib::GSList;

use GLib::Roles::Implementor;

# BOXED

class Evolution::Calendar::Component::Alarms {
  also does GLib::Roles::Implementor;

  has ECalComponentAlarms $!eds-ecca is implementor;

  submethod BUILD ( :$e-calcomp-alarms ) {
    $!eds-ecca = $e-calcomp-alarms if $e-calcomp-alarms;
  }

  method Evolution::Raw::Defiitions::ECalComponentAlarms
    is also<ECalComponentAlarms>
  { $!eds-ecca }

  multi method new (ECalComponentAlarms $e-calcomp-alarms) {
    $e-calcomp-alarms ?? self.bless( :$e-calcomp-alarms ) !! Nil;
  }
  multi method new (ECalComponent() $comp) {
    my $e-calcomp-alarms = e_cal_component_alarms_new($comp);

    $e-calcomp-alarms ?? self.bless( :$e-calcomp-alarms ) !! Nil;
  }

  method add_instance (ECalComponentAlarmInstance() $instance)
    is also<add-instance>
  {
    e_cal_component_alarms_add_instance($!eds-ecca, $instance);
  }

  method instances is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_instances    },
      STORE => -> $, \v { self.set_instances(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_alarms_copy($!eds-ecca),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_cal_component_alarms_free($!eds-ecca);
  }

  method get_component ( :$raw = False ) is also<get-component> {
    propReturnObject(
      e_cal_component_alarms_get_component($!eds-ecca),
      $raw,
      |Evolution::Calendar::Component.getTypePair
    );
  }

  method get_instances ( :$raw = False, :glist(:$gslist) = False )
    is also<get-instances>
  {
    returnGSList(
      e_cal_component_alarms_get_instances($!eds-ecca),
      $raw,
      $gslist,
      |Evolution::Calendar::Component::Alarm::Instance.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_component_alarms_get_type,
      $n,
      $t
    );
  }

  method remove_instance (ECalComponentAlarmInstance() $instance)
    is also<remove-instance>
  {
    e_cal_component_alarms_remove_instance($!eds-ecca, $instance);
  }

  proto method set_instances (|)
    is also<set-instances>
  { * }

  multi method set_instances (@instances) {
    samewith(
      GLib::GSList.new(@instances, typed => ECalComponentAlarmInstance)
    )
  }
  multi method set_instances (GSList() $instances) {
    e_cal_component_alarms_set_instances($!eds-ecca, $instances);
  }

  method take_instance (ECalComponentAlarmInstance() $instance)
    is also<take-instance>
  {
    e_cal_component_alarms_take_instance($!eds-ecca, $instance);
  }

  proto method take_instances (|)
    is also<take-instances>
  { * }

  multi method take_instances (@instances) {
    samewith(
      GLib::GSList.new(@instances, typed => ECalComponentAlarmInstance)
    )
  }
  multi method take_instances (GSList() $instances) {
    e_cal_component_alarms_take_instances($!eds-ecca, $instances);
  }

}
