use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::DBus::Server;

### /usr/include/evolution-data-server/libebackend/e-dbus-server.h

sub e_dbus_server_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_dbus_server_hold (EDBusServer $server)
  is native(ebackend)
  is export
{ * }

sub e_dbus_server_load_modules (EDBusServer $server)
  is native(ebackend)
  is export
{ * }

sub e_dbus_server_quit (EDBusServer $server, EDBusServerExitCode $code)
  is native(ebackend)
  is export
{ * }

sub e_dbus_server_release (EDBusServer $server)
  is native(ebackend)
  is export
{ * }

sub e_dbus_server_run (EDBusServer $server, gboolean $wait_for_client)
  returns EDBusServerExitCode
  is native(ebackend)
  is export
{ * }
