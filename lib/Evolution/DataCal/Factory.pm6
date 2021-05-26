use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::DataFactory;

our subset EDataCalFactoryAncestry is export of Mu
  where EDataCalFactory | EDataFactoryAncestry;

class Evolution::DataCal::Factory is Evolution::DataFactory {
  has EDataCalFactory $!edcf;

  submethod BUILD (:$data-cal-factory) {
    self.setEDataCalFactory($data-cal-factory) if $data-cal-factory;
  }

  method setEDataCalFactory (EDataCalFactoryAncestry $_) {
    my $to-parent;

    $!edcf = do {
      when EDataCalFactory {
        $to-parent = cast(EDataFactory, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataCalFactory, $_);
      }
    }
    self.setEDataFactory($to-parent);
  }

  method Evolution::Raw::Structs::EDataCalFactory
  { $!edcf }

  multi method new (EDataCalFactoryAncestry, $data-cal-factory, :$ref = True) {
    return Nil unless $data-cal-factory;

    my $o = self.bless( :$data-cal-factory );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my $data-cal-factory = e_data_cal_factory_new($cancellable, $error);

    $data-cal-factory ?? self.bless( :$data-cal-factory ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_cal_factory_get_type, $n, $t );
  }

}

sub e_data_cal_factory_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_factory_new (
  gint                    $backend_per_process,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EDBusServer
  is native(edata-cal)
  is export
{ * }
