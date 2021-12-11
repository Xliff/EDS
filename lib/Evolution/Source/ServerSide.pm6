use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Source::ServerSide;

use GLib::Node;
use Evolution::Source;
use Evolution::Source::RegistryServer;

use GIO::Roles::GFile;
use Evolution::Roles::OAuth2::Support;

our subset EServerSideSourceAncestry is export of Mu
  where EServerSideSource | ESourceAncestry;

class Evolution::Source::ServerSide is Evolution::Source {
  has EServerSideSource $!esss;

  submethod BUILD ( :$e-server-side-source ) {
    self.setEServerSideSource($e-server-side-source) if $e-server-side-source;
  }

  method setEServerSideSource (EServerSideSourceAncestry $_) {
    my $to-parent;

    $!esss = do {
      when EServerSideSource {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EServerSideSource, $_);
      }
    }
    self.setESource($to-parent);
  }

  method Evolution::Raw::Definitions::EServerSideSource
  { $!esss }

  multi method new (
    EServerSideSourceAncestry  $e-server-side-source,
                              :$ref           = True
  ) {
    return Nil unless $e-server-side-source;

    my $o = self.bless( :$e-server-side-source );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    ESourceRegistryServer() $server,
    GFile()                 $file    = GFile,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $e-server-side-source = e_server_side_source_new($!esss, $file, $error);
    set_error($error);

    $e-server-side-source ?? self.bless( :$e-server-side-source ) !! Nil
  }

  method new_memory_only (
    ESourceRegistryServer() $server,
    Str()                   $uid     = Str,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<new-memory-only>
  {
    clear_error;
    my $e-server-side-source = e_server_side_source_new_memory_only(
      $server,
      $uid,
      $error
    );
    set_error($error);

    $e-server-side-source ?? self.bless( :$e-server-side-source ) !! Nil
  }

  method new_user_file (
    Evolution::Source::ServerSide:U:

    Str()  $uid = Str,
          :$raw = False
  )
    is also<new-user-file>
  {
    propReturnObject(
      e_server_side_source_new_user_file($uid),
      $raw,
      |GIO::GFile.getTypePair
    );
  }

  method get_exported is also<get-exported> {
    so e_server_side_source_get_exported($!esss);
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      e_server_side_source_get_file($!esss),
      $raw,
      |GIO::GFile.getTypePair
    );
  }

  method get_node ( :$raw = False ) is also<get-node> {
    propReturnObject(
      e_server_side_source_get_node($!esss),
      $raw,
      |GLib::Node.getTypePair
    );
  }

  method get_server ( :$raw = False ) is also<get-server> {
    propReturnObject(
      e_server_side_source_get_server($!esss),
      $raw,
      |Evolution::Source::RegistryServer.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_server_side_source_get_type, $n, $t );
  }

  method get_user_dir (Evolution::Source::ServerSide:U: )
    is also<get-user-dir>
  {
    e_server_side_source_get_user_dir();
  }

  method get_write_directory is also<get-write-directory> {
    e_server_side_source_get_write_directory($!esss);
  }

  method load (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_server_side_source_load($!esss, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method ref_oauth2_support ( :$raw = False ) is also<ref-oauth2-support> {
    propReturnObject(
      e_server_side_source_ref_oauth2_support($!esss),
      $raw,
      |Evolution::OAuth2::Support.getTypePair
    );
  }

  method set_oauth2_support (EOAuth2Support() $oauth2_support)
    is also<set-oauth2-support>
  {
    e_server_side_source_set_oauth2_support($!esss, $oauth2_support);
  }

  method set_remote_creatable (Int() $remote_creatable)
    is also<set-remote-creatable>
  {
    my gboolean $r = $remote_creatable.so.Int;

    e_server_side_source_set_remote_creatable($!esss, $r);
  }

  method set_remote_deletable (Int() $remote_deletable)
    is also<set-remote-deletable>
  {
    my gboolean $r = $remote_deletable.so.Int;

    e_server_side_source_set_remote_deletable($!esss, $r);
  }

  method set_removable (Int() $removable) is also<set-removable> {
    my gboolean $r = $removable.so.Int;

    e_server_side_source_set_removable($!esss, $r);
  }

  method set_writable (Int() $writable) is also<set-writable> {
    my gboolean $w = $writable.so.Int;

    e_server_side_source_set_writable($!esss, $w);
  }

  method set_write_directory (Str() $write_directory)
    is also<set-write-directory>
  {
    e_server_side_source_set_write_directory($!esss, $write_directory);
  }

  method uid_from_file (
    Evolution::Source::ServerSide:U:

    GFile()                 $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<uid-from-file>
  {
    clear_error;
    my $uid = e_server_side_source_uid_from_file($file, $error);
    set_error($error);
    $uid;
  }

}
