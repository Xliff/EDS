use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::DBus::Server;

use GLib::Roles::Object;

our subset EDBusServerAncestry is export of Mu
  where EDBusServer | GObject;

class Evolution::DBus::Server {
  also does GLib::Roles::Object;

  has EDBusServer $!eds;

  submethod BUILD (:$dbus-server) {
    self.setEDBusServer($dbus-server) if $dbus-server;
  }

  method setEDBusServer (EDBusServerAncestry $_) {
    my $to-parent;

    $!eds = do {
      when EDBusServer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDBusServer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EDBusServer
    is also<EDBusServer>
  { $!eds }

  method new (EDBusServerAncestry $dbus-server, :$ref = True) {
    return Nil unless $dbus-server;

    my $o = self.bless( :$dbus-server );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_dbus_server_get_type, $n, $t );
  }

  method hold {
    e_dbus_server_hold($!eds);
  }

  method load_modules is also<load-modules> {
    e_dbus_server_load_modules($!eds);
  }

  method quit (Int() $code) {
    my EDBusServerExitCode $c = $code;

    e_dbus_server_quit($!eds, $c);
  }

  method release {
    e_dbus_server_release($!eds);
  }

  method run (Int() $wait_for_client = True) {
    my gboolean $w = $wait_for_client.so.Int;

    EDBusServerExitCodeEnum( e_dbus_server_run($!eds, $w) );
  }

}
