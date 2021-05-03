use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::SubprocessFactory;

use GLib::GList;
use Evolution::Backend;
use Evolution::Source::Registry;

use GLib::Roles::Object;

our subset ESubprocessFactoryAncestry is export of Mu
  where ESubprocessFactory | GObject;

class Evolution::SubprocessFactory {
  also does GLib::Roles::Object;

  has ESubprocessFactory $!esf;

  submethod BUILD (:$factory) {
    self.setESubprocessFactory($factory) if $factory;
  }

  method setESubprocessFactory (ESubprocessFactoryAncestry $_) {
    my $to-parent;

    $!esf = do {
      when ESubprocessFactory {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESubprocessFactory, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ESubprocessFactory
  { $!esf }

  method new (ESubprocessFactoryAncestry $factory, :$ref = True) {
    return Nil unless $factory;

    my $o = self.bless( :$factory );
    $o.ref if $ref;
    $o;
  }

  method call_backends_prepare_shutdown {
    e_subprocess_factory_call_backends_prepare_shutdown($!esf);
  }

  method construct_path (Evolution::SubprocessFactory:U: ) {
    e_subprocess_factory_construct_path();
  }

  method get_backends_list (:$glist = False, :$raw = False) {
    returnGList(
      e_subprocess_factory_get_backends_list($!esf),
      $glist,
      $raw,
      # A guess!
      EBackend,
      Evolution::Backend
    );
  }

  method get_registry (:$raw = False) {
    my $reg = e_subprocess_factory_get_registry($!esf);

    # Transfer: none (owned by ESubprocessFactory)
    $reg ??
      ( $raw ?? $reg !! Evolution::Source::Registry($reg) )
      !!
      Nil
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_subprocess_factory_get_type, $n, $t );
  }

  method open_backend (
    GDBusConnection()        $connection,
    Str()                    $uid,
    Str()                    $backend_factory_type_name,
    Str()                    $module_filename,
    GDBusInterfaceSkeleton() $proxy,
    GCancellable()           $cancellable                = GCancellable,
    CArray[Pointer[GError]]  $error                      = gerror
  ) {
    clear_error;
    my $path = e_subprocess_factory_open_backend(
      $!esf,
      $connection,
      $uid,
      $backend_factory_type_name,
      $module_filename,
      $proxy,
      $cancellable,
      $error
    );
    set_error($error);
    $path;
  }

  method ref_initable_backend (
    Str()                   $uid,
    Str()                   $backend_factory_type_name,
    Str()                   $module_filename,
    GCancellable()          $cancellable                = GCancellable,
    CArray[Pointer[GError]] $error                      = gerror,
                            :$raw                       = False
  ) {
    clear_error;
    my $b = e_subprocess_factory_ref_initable_backend(
      $!esf,
      $uid,
      $backend_factory_type_name,
      $module_filename,
      $cancellable,
      $error
    );
    set_error($error);

    # Transfer: full (Documentation uses the wording "newly-created")
    $b ??
      ( $raw ?? $b !! Evolution::Backend.new($b, :!ref) )
      !!
      Nil
  }

  method set_backend_callbacks (
    EBackend()               $backend,
    GDBusInterfaceSkeleton() $proxy
  ) {
    e_subprocess_factory_set_backend_callbacks($!esf, $backend, $proxy);
  }

}
