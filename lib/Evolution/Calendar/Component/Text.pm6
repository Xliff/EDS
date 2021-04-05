use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Calendar::Component::Text;

use Evolution::Calendar::Component;

our subset ECalComponentTextAncestry is export of Mu
  where ECalComponentText | ECalComponentAncestry;

class Evolution::Calendar::Component::Text is Evolution::Calendar::Component {
  has ECalComponentText $!ecct is implementor;

  method setECalComponentText (ECalComponentTextAncestry $_) {
    my $to-parent;

    $!c = do {
      when ECalComponentText {
        $to-parent = cast(ECalComponent, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalComponentText, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECalComponentText
  { $!ecct }

  multi method new (ECalComponentTextAncestry $client, :$ref = True) {
    return Nil unless $client;

    my $o = self.bless( :$client );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $value, Str() $altrep) {
    my $component-text = e_cal_component_text_new($value, $altrep);

    $component-text ?? self.bless( :$component-text ) !! Nil;
  }

  method value is rw {
    Proxy.new:
      FETCH => -> $           { self.get_value },
      STORE => -> $, Str() $t { self.set_value($t) }
  }

  method altrep is rw {
    Proxy.new:
      FETCH => -> $           { self.get_altrep },
      STORE => -> $, Str() $t { self.set_altrep($t) }
  }

  method copy (:$raw = False) {
    my $c = e_cal_component_text_copy($!ecct);

    $c ??
      ( $raw ?? $c !! Evolution::Calendar::Component::Text.new($c) )
      !!
      Nil;
  }

  method free {
    e_cal_component_text_free($!ecct);
  }

  method get_altrep {
    e_cal_component_text_get_altrep($!ecct);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, e_cal_component_text_get_type, $, $t );
  }

  method get_value {
    e_cal_component_text_get_value($!ecct);
  }

  method set_altrep (Str() $altrep) {
    e_cal_component_text_set_altrep($!ecct, $altrep);
  }

  method set_value (Str() $value) {
    e_cal_component_text_set_value($!ecct, $value);
  }

}
