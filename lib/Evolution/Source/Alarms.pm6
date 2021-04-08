use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Alarms;

use Evolution::Source::Extension;

our subset ESourceAlarmsAncestry is export of Mu
  where ESourceAlarms | ESourceExtensionAncestry;

class Evolution::Source::Alarms is Evolution::Source::Extension {
  has ESourceAlarms $!esa is implementor;

  submethod BUILD (:$alarms) {
    self.setESourceAlarms($alarms) if $alarms;
  }

  method setESourceAlarms (ESourceAlarmsAncestry $_) {
    my $to-parent;

    $!esa = do {
      when ESourceAlarms {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceAlarms, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceAlarms
  { $!esa }

  multi method new (ESourceAlarmsAncestry $alarms, :$ref = True) {
    return Nil unless $alarms;

    my $o = self.bless( :$alarms );
    $o.ref if $ref;
    $o;
  }

  method dup_last_notified {
    e_source_alarms_dup_last_notified($!esa);
  }

  method get_include_me {
    so e_source_alarms_get_include_me($!esa);
  }

  method get_last_notified {
    e_source_alarms_get_last_notified($!esa);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_alarms_get_type, $n, $t );
  }

  method set_include_me (Int() $include_me) {
    my gboolean $i = $include_me.so.Int;

    e_source_alarms_set_include_me($!esa, $i);
  }

  method set_last_notified (Str $last_notified) {
    e_source_alarms_set_last_notified($!esa, $last_notified);
  }

}
