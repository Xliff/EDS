use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Camel;

use Evolution::Source::Extension;

our subset ESourceCamelAncestry is export of Mu
  where ESourceCamel | ESourceExtensionAncestry;

class Evolution::Source::Camel is Evolution::Source::Extension {
  has ESourceCamel $!esc;

  submethod BUILD (:$camel) {
    self.setESourceCamel($camel) if $camel;
  }

  method setESourceCamel (ESourceCamelAncestry $_) {
    my $to-parent;

    $!esc = do {
      when ESourceCamel {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceCamel, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceCamel
  { $!esc }

  multi method new (ESourceCamelAncestry $camel, :$ref = True) {
    return Nil unless $camel;

    my $o = self.bless( :$camel );
    $o.ref if $ref;
    $o;
  }

  method configure_service (Int() $service) {
    my CamelService $s = $service;

    e_source_camel_configure_service($!esc, $service);
  }

  method generate_subtype (Str() $protocol, Int() $settings_type) {
    my GType $s = $settings_type;

    e_source_camel_generate_subtype($protocol, $s);
  }

  method get_extension_name (Evolution::Source::Camel:U: Str() $protocol) {
    e_source_camel_get_extension_name($protocol);
  }

  method get_settings {
    e_source_camel_get_settings($!esc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_camel_get_type, $n, $t );
  }

  method get_type_name (Evolution::Source::Camel:U: Str() $protocol) {
    e_source_camel_get_type_name($protocol);
  }

  method register_types (Evolution::Source::Camel:U: ) {
    e_source_camel_register_types();
  }

}
