use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::RegistryServer;

use GLib::GList;
use Evolution::CollectionBackend;
use Evolution::Backend::Factory;
use Evolution::DataFactory;
use Evolution::OAuth2::Services;
use Evolution::Source;
use Evolution::Source::CredentialsProvider;

our subset ESourceRegistryServerAncestry is export of Mu
  where ESourceRegistryServer | EDataFactoryAncestry;

class Evolution::Source::RegistryServer is Evolution::DataFactory {
  has ESourceRegistryServer $!esrs;

  submethod BUILD (:$backend) {
    self.setESourceRegistryServer($backend) if $backend;
  }

  method setESourceRegistryServer (ESourceRegistryServerAncestry $_) {
    my $to-parent;

    $!esrs = do {
      when ESourceRegistryServer {
        $to-parent = cast(EDataFactory, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceRegistryServer, $_);
      }
    }
    self.setEDataFactory($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceRegistryServer
  { $!esrs }

  multi method new (ESourceRegistryServerAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $registry-server = e_source_registry_server_new();

    $registry-server ?? self.bless( :$registry-server ) !! Nil;
  }

  method add_source (ESource() $source) {
    e_source_registry_server_add_source($!esrs, $source);
  }

  method find_extension (
    ESource() $source,
    Str       $extension_name,
              :$raw = False
  ) {
    my $s =  e_source_registry_server_find_extension(
      $!esrs,
      $source,
      $extension_name
    );

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method get_oauth2_services (:$raw = False) {
    my $oa2 = e_source_registry_server_get_oauth2_services($!esrs);

    # No web resource exists. Must code definition.
    $oa2 ??
      ( $oa2 ?? $oa2 !! Evolution::OAuth2Services.new($oa2) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_registry_server_get_type, $n, $t );
  }

  method list_sources (Str() $extension_name, :$glist = False, :$raw = False) {
    returnGList(
      e_source_registry_server_list_sources($!esrs, $extension_name),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method load_all (CArray[Pointer[GError]] $error = gerror)
    is DEPRECATED
  {
    clear_error;
    e_source_registry_server_load_all($!esrs, $error);
    set_error($error);
  }

  method load_directory (
    Str()                   $path,
    Int()                   $flags,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my ESourcePermissionFlags $f = $flags;

    clear_error;
    my $rv = so e_source_registry_server_load_directory(
      $!esrs,
      $path,
      $f,
      $error
    );
    set_error($error);
    $rv;
  }

  method emit_load_error (GFile() $file, GError() $error) {
    e_source_registry_server_load_error($!esrs, $file, $error);
  }

  method load_file (
    GFile()                 $file,
    Int()                   $flags,
    CArray[Pointer[GError]] $error,
                            :$raw   = False
  ) {
    my ESourcePermissionFlags $f = $flags;

    clear_error;
    my $s = e_source_registry_server_load_file($!esrs, $file, $flags, $error);
    set_error($error);

    # Transfer: full (return value is pre-reffed)
    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s, :!ref) )
      !!
      Nil;
  }

  method load_resource (
    GResource()             $resource,
    Str()                   $path,
    Int()                   $flags,
    CArray[Pointer[GError]] $error
  ) {
    my ESourcePermissionFlags $f = $flags;

    clear_error;
    my $rv = so e_source_registry_server_load_resource(
      $!esrs,
      $resource,
      $path,
      $f,
      $error
    );
    set_error($error);
    $rv;
  }

  method ref_backend (ESource() $source, :$raw = False) {
    my $b = e_source_registry_server_ref_backend($!esrs, $source);

    $b ??
      ( $raw ?? $b !! Evolution::CollectionBackend.new($b, :!ref) )
      !!
      Nil;
  }

  method ref_backend_factory (ESource() $source, :$raw = False) {
    my $f = e_source_registry_server_ref_backend_factory($!esrs, $source);

    $f ??
      ( $raw ?? $f !! Evolution::Backend::Factory.new($f, :!ref) )
      !!
      Nil
  }

  method ref_credentials_provider (:$raw = False) {
    my $cp = e_source_registry_server_ref_credentials_provider($!esrs);

    $cp ??
      ( $raw ?? $cp !! Evolution::Source::CredentialsProvider.new($cp, :!ref) )
      !!
      Nil;
  }

  method ref_source (Str() $uid, :$raw = False) {
    my $s = e_source_registry_server_ref_source($!esrs, $uid);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s, :!ref) )
      !!
      Nil;
  }

  method remove_source (ESource() $source) {
    e_source_registry_server_remove_source($!esrs, $source);
  }

}
