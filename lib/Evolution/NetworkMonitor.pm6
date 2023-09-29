use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Evolution::Raw::Types;

use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::Initable;
use GIO::Roles::NetworkMonitor;

our subset ENetworkMonitorAncestry is export of Mu
  where ENetworkMonitor | GNetworkMonitor | GInitable | GObject;

class Evolution::NetworkMonitor {
  also does GLib::Roles::Object;
  also does GIO::Roles::Initable;
  also does GIO::Roles::NetworkMonitor;

  has ENetworkMonitor $!eds-nm is implementor;

  submethod BUILD (
    :$e-network-monitor,
    :initable-object(:$monitor),
    :$init,
    :$cancellable
  ) {
    return unless $e-network-monitor;
    self.setENetworkMonitor(
       $e-network-monitor,
      :initable-object(:$monitor),
      :$init,
      :$cancellable
    );
  }

  method setENetworkMonitor (
    ENetworkMonitorAncestry $_,

    :initable-object(:$monitor),
    :$init,
    :$cancellable
  ) {
    my $to-parent;

    $!eds-nm = do {
      when ENetworkMonitor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GInitable {
        $to-parent = cast(GObject, $_);
        $!i        = $_;
        cast(ENetworkMonitor, $_);
      }

      when GNetworkMonitor {
        $to-parent = cast(GObject, $_);
        $!nm       = $_;
        cast(ENetworkMonitor, $_);
      }

      default {
        $to-parent = $_;
        cast(ENetworkMonitor, $_);
      }
    }
    self!setObject($to-parent);
    self.setGNetworkMonitorBase($to-parent, :$init, :$cancellable);
    self.roleInit-GInitable;
    self.roleInit-GNetworkMonitor;
  }

  method Evolution::Raw::Definitions::ENetworkMonitor
  { $!eds-nm }

  multi method new (
     $e-network-monitor where * ~~ ENetworkMonitorAncestry,

    :$ref = True
  ) {
    return unless $e-network-monitor;

    my $o = self.bless( :$e-network-monitor );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    :initable_object(:$initable-object),
    :$init,
    :$cancellable
  ) {
    my $e-network-monitor =
      $initable-object // self.new-obj-ptr(self.get_type);

    return unless $e-network-monitor;

    self.bless(
      :$e-network-monitor,
      :$initable-object,
      :$init,
      :$cancellable
    );
  }

  # Type: string
  method gio-name is rw  is g-property is also<gio_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gio-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gio-name', $gv);
      }
    );
  }

  method dup_gio_name is also<dup-gio-name> {
    e_network_monitor_dup_gio_name($!eds-nm);
  }

  method get_default ( :$raw = False )
    is also<
      get-default
      default
    >
    is static
  {
    propReturnObject(
      e_network_monitor_get_default(),
      $raw,
      |GIO::NetworkMonitor.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_network_monitor_get_type, $n, $t );
  }

  method list_gio_names ( :$raw = False, :glist(:$gslist) = False )
    is also<list-gio-names>
  {
    returnGSList(
      e_network_monitor_list_gio_names($!eds-nm),
      $raw,
      $gslist,
      Str
    );
  }

  method set_gio_name (Str() $gio_name) is also<set-gio-name> {
    e_network_monitor_set_gio_name($!eds-nm, $gio_name);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-network-monitor.h

sub e_network_monitor_dup_gio_name (ENetworkMonitor $network_monitor)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_network_monitor_get_default
  returns GNetworkMonitor
  is      native(eds)
  is      export
{ * }

sub e_network_monitor_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_network_monitor_list_gio_names (ENetworkMonitor $network_monitor)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_network_monitor_set_gio_name (
  ENetworkMonitor $network_monitor,
  Str             $gio_name
)
  is      native(eds)
  is      export
{ * }
