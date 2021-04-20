use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::View;

### /usr/include/evolution-data-server/libecal/e-cal-client-view.h

sub e_cal_client_view_get_connection (ECalClientView $client_view)
  returns GDBusConnection
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_get_object_path (ECalClientView $client_view)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_is_running (ECalClientView $client_view)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_ref_client (ECalClientView $client_view)
  returns ECalClient
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_set_fields_of_interest (
	ECalClientView          $client_view,
	GSList                  $fields_of_interest,
	CArray[Pointer[GError]] $error
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_set_flags (
	ECalClientView          $client_view,
	ECalClientViewFlags     $flags,
	CArray[Pointer[GError]] $error
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_start (
	ECalClientView          $client_view,
	CArray[Pointer[GError]] $error
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_view_stop (
	ECalClientView          $client_view,
	CArray[Pointer[GError]] $error
)
  is native(ecal)
  is export
{ * }
