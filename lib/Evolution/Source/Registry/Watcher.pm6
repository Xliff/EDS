use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ESourceRegistryWatcherAncestry is export of Mu
  where ESourceRegistryWatcher | GObject;

class Evolution::Source::Registry::Watcher {
  also does GLib::Roles::Object;

  has ESourceRegistryWatcher $!eds-rw is implementor;

  submethod BUILD ( :$e-registry-watcher ) {
    self.setESoourceRegistryWatcher($e-registry-watcher)
      if $e-registry-watcher
  }

  method setESoourceRegistryWatcher (ESourceRegistryWatcherAncestry $_) {
    my $to-parent;

    $!eds-rw = do {
      when ESourceRegistryWatcher {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceRegistryWatcher, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceRegistryWatcher
    is also<ESourceRegistryWatcher>
  { $!eds-rw }

  multi method new (
    $e-registry-watcher where * ~~ ESourceRegistryWatcherAncestry,

    :$ref = True
  ) {
    return unless $e-registry-watcher;

    my $o = self.bless( :$e-registry-watcher );
    $o.ref if $ref;
    $o;
  }

  multi method new (ESourceRegistry() $registry, Str() $extension_name) {
    my $e-registry-watcher =  e_source_registry_watcher_new(
      $registry,
      $extension_name
    );

    $e-registry-watcher ?? self.bless( :$e-registry-watcher ) !! Nil;
  }

  method get_extension_name is also<get-extension-name> {
    e_source_registry_watcher_get_extension_name($!eds-rw);
  }

  method get_registry ( :$raw = False ) is also<get-registry> {
    propReturnObject(
      e_source_registry_watcher_get_registry($!eds-rw),
      $raw,
      |Evolution::Source::Registry.getTypePair
    );
  }

  method reclaim {
    e_source_registry_watcher_reclaim($!eds-rw);
  }

}


### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-registry-watcher.h

sub e_source_registry_watcher_get_extension_name (
  ESourceRegistryWatcher $watcher
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_source_registry_watcher_get_registry (ESourceRegistryWatcher $watcher)
  returns ESourceRegistry
  is      native(eds)
  is      export
{ * }

sub e_source_registry_watcher_new (
  ESourceRegistry $registry,
  Str             $extension_name
)
  returns ESourceRegistryWatcher
  is      native(eds)
  is      export
{ * }

sub e_source_registry_watcher_reclaim (ESourceRegistryWatcher $watcher)
  is      native(eds)
  is      export
{ * }
