use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Id;

use GLib::Roles::Implementor;

# BOXED

class Evolution::Calendar::Component::Id {
  has ECalComponentId $!eds-ecci is implementor;

  submethod BUILD ( :$e-calcomp-id ) {
    $!eds-ecci = $e-calcomp-id if $e-calcomp-id;
  }

  method Evolution::Raw::Structs::ECalComponentId
    is also<ECalComponentId>
  { $!eds-ecci }

  multi method new (ECalComponentId $e-calcomp-id) {
    $e-calcomp-id ?? self.bless( :$e-calcomp-id ) !! Nil;
  }
  multi method new (Str() $uid, Str() $rid) {
    my $e-calcomp-id = e_cal_component_id_new($uid, $rid);

    $e-calcomp-id ?? self.bless( :$e-calcomp-id ) !! Nil;
  }

  method new_take (Str() $uid, Str() $rid) is also<new-take> {
    my $e-calcomp-id = e_cal_component_id_new_take($uid, $rid);

    $e-calcomp-id ?? self.bless( :$e-calcomp-id ) !! Nil;
  }

  method rid is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_rid    },
      STORE => -> $, \v { self.set_rid(v) }
  }

  method uid is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_uid    },
      STORE => -> $, \v { self.set_uid(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_cal_component_id_copy($!eds-ecci),
      $raw,
      |self.getTypePair
    );
  }

  method equal (ECalComponentId() $id2) {
    e_cal_component_id_equal($!eds-ecci, $id2);
  }

  method free {
    e_cal_component_id_free($!eds-ecci);
  }

  method get_rid is also<get-rid> {
    e_cal_component_id_get_rid($!eds-ecci);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_component_id_get_type, $n, $t );
  }

  method get_uid is also<get-uid> {
    e_cal_component_id_get_uid($!eds-ecci);
  }

  method hash {
    e_cal_component_id_hash($!eds-ecci);
  }

  method set_rid (Str() $rid) is also<set-rid> {
    e_cal_component_id_set_rid($!eds-ecci, $rid);
  }

  method set_uid (Str() $uid) is also<set-uid> {
    e_cal_component_id_set_uid($!eds-ecci, $uid);
  }

}
