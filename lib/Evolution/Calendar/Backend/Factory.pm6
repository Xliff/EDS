use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;

use Evolution::Backend::Factory;

use GLib::Roles::Implementor;

our subset ECalBackendFactoryAncestry is export of Mu
  where ECalBackendFactory | EBackendFactoryAncestry;

class Evolution::Calendar::Backend::Factory {
  has ECalBackendFactory $!e-cbf is implementor;

  submethod BUILD ( :$eds-cal-backfact ) {
    self.setECalBackendFactory($eds-cal-backfact) if $eds-cal-backfact
  }

  method setECalBackendFactory (ECalBackendFactoryAncestry $_) {
    my $to-parent;

    $!e-cbf = do {
      when ECalBackendFactory {
        $to-parent = cast(EBackendFactory, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalBackendFactory, $_);
      }
    }
    self.setEBackendFactory($to-parent);
  }

  method Evolution::Raw::Structs::ECalBackendFactory
    is also<ECalBackendFactory>
  { $!e-cbf }

  multi method new (
     $eds-cal-backfact where * ~~ ECalBackendFactoryAncestry,

    :$ref = True
  ) {
    return unless $eds-cal-backfact;

    my $o = self.bless( :$eds-cal-backfact );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cal_backend_factory_get_type, $n, $t );
  }

}


### /usr/src/evolution-data-server-3.48.0/src/calendar/libedata-cal/e-cal-backend-factory.h

sub e_cal_backend_factory_get_type
  returns GType
  is native(edata-cal)
  is export
{ * }
