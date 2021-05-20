use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::DataFactory;

use GLib::GList;
use Evolution::Backend;
use Evolution::Backend::Factory;
use Evolution::DBus::Server;
use Evolution::Source::Registry;

our subset EDataFactoryAncestry is export of Mu
  where EDataFactory | EDBusServerAncestry;

class Evolution::DataFactory is Evolution::DBus::Server {
  has EDataFactory $!edf;

  submethod BUILD (:$data-factory) {
    self.setEDataFactory($data-factory) if $data-factory;
  }

  method setEDataFactory (EDataFactoryAncestry $_) {
    my $to-parent;

    $!edf = do {
      when EDataFactory {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataFactory, $_);
      }
    }
    self.setEDBusServer($to-parent);
  }

  method Evolution::Raw::Definitions::EDataFactory
  { $!edf }

  method new (EDataFactoryAncestry $data-factory, :$ref = True) {
    return Nil unless $data-factory;

    my $o = self.bless( :$data-factory );
    $o.ref if $ref;
    $o;
  }

  method backend_closed (EBackend() $backend) {
    e_data_factory_backend_closed($!edf, $backend);
  }

  method backend_closed_by_sender (EBackend() $backend, Str() $sender) {
    e_data_factory_backend_closed_by_sender($!edf, $backend, $sender);
  }

  method construct_path {
    e_data_factory_construct_path($!edf);
  }

  method create_backend (
    EBackendFactory() $backend_factory,
    ESource()         $source,
                      :$raw             = False
  ) {
    my $b = e_data_factory_create_backend($!edf, $backend_factory, $source);

    # Transfer: full (assummed: creation)
    $b ??
      ( $raw ?? $b !! Evolution::Backend.new($b, :!ref) )
      !!
      Nil
  }

  method get_backend_per_process {
    e_data_factory_get_backend_per_process($!edf);
  }

  method get_registry (:$raw = False) {
    my $r = e_data_factory_get_registry($!edf);

    # Transfer: none* -- (not specified so choosing safest assumption)
    $r ??
      ( $raw ?? $r !! Evolution::Source::Registry.new($r) )
      !!
      Nil
  }

  method get_reload_supported {
    so e_data_factory_get_reload_supported($!edf);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_factory_get_type, $n, $t );
  }

  method list_opened_backends ( :$glist = False, :$raw = False ) {
    returnGList(
      e_data_factory_list_opened_backends($!edf),
      $glist,
      $raw
    )
  }

  method open_backend (
    EBackend()              $backend,
    GDBusConnection()       $connection,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $returned = e_data_factory_open_backend(
      $!edf,
      $backend,
      $connection,
      $cancellable,
      $error
    );
    set_error($error);
    $returned;
  }

  method ref_backend_factory (
    Str() $backend_name,
    Str() $extension_name,
          :$raw             = False
  ) {
    my $bf = e_data_factory_ref_backend_factory(
      $!edf,
      $backend_name,
      $extension_name
    );

    # Transfer: full (because of the nature of the routine)
    $bf ??
      ( $raw ?? $bf !! Evolution::BackendFactory.new($bf, :!ref) )
      !!
      Nil;
  }

  method spawn_subprocess_backend (
    GDBusMethodInvocation() $invocation,
    Str()                   $uid,
    Str()                   $extension_name,
    Str()                   $subprocess_path
  ) {
    e_data_factory_spawn_subprocess_backend(
      $!edf,
      $invocation,
      $uid,
      $extension_name,
      $subprocess_path
    );
  }

  method use_backend_per_process {
    so e_data_factory_use_backend_per_process($!edf);
  }

}
