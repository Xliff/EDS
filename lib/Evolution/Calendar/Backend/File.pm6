use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Calendar::Backend::Sync;

use GLib::Roles::Implementor;

our subset ECalBackendFileAncestry is export of Mu
  where ECalBackendFile | ECalBackendSyncAncestry;

class Evolution::Calendar::Backend::File
  is Evolution::Calendar::Backend::Sync
{
  has ECalBackendFile $!eds-bf is implementor;

  submethod BUILD ( :$e-cal-backend-file ) {
    self.setECalBackendFile($e-cal-backend-file) if $e-cal-backend-file
  }

  method setECalBackendFile (ECalBackendFileAncestry $_) {
    my $to-parent;

    $!eds-bf = do {
      when ECalBackendFile {
        $to-parent = cast(ECalBackendSync, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECalBackendFile, $_);
      }
    }
    self.setECalBackendSync($to-parent);
  }

  method Evolution::Raw::Definitions::ECalBackendFile
    is also<ECalBackendFile>
  { $!eds-bf }

  multi method new (
     $e-cal-backend-file where * ~~ ECalBackendFileAncestry,

    :$ref = True
  ) {
    return unless $e-cal-backend-file;

    my $o = self.bless( :$e-cal-backend-file );
    $o.ref if $ref;
    $o;
  }

  method file_name is rw is g-accessor is also<file-name> {
    Proxy.new:
      FETCH => -> $     { self.get_file_name    },
      STORE => -> $, \v { self.set_file_name(v) }
  }

  method get_file_name is also<get-file-name> {
    e_cal_backend_file_get_file_name($!eds-bf);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_cal_backend_file_get_type,
      $n.
      $t
    );
  }

  method reload (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_cal_backend_file_reload($!eds-bf, $error);
    set_error($error);
  }

  method set_file_name (Str() $file_name) is also<set-file-name> {
    e_cal_backend_file_set_file_name($!eds-bf, $file_name);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/calendar/backends/file/e-cal-backend-file.h

sub e_cal_backend_file_get_file_name (ECalBackendFile $cbfile)
  returns constgchar
  is      native(eds)
  is      export
{ * }

sub e_cal_backend_file_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_backend_file_reload (
  ECalBackendFile         $cbfile,
  CArray[Pointer[GError]] $error
)
  is      native(eds)
  is      export
{ * }

sub e_cal_backend_file_set_file_name (
  ECalBackendFile $cbfile,
  Str             $file_name
)
  is      native(eds)
  is      export
{ * }
