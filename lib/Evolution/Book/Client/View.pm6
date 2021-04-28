use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Client::View;

use GIO::DBus::Connection;
use Evolution::Book::Client;

use GLib::Roles::Object;
use GIO::Roles::Initable;
use GIO::Roles::AsyncInitable;

use Evolution::Roles::Signals::Book::Client::View;

our subset EBookClientViewAncestry is export of Mu
  where EBookClientView | GInitable | GObject;

class Evolution::Book::Client::View {
  also does GLib::Roles::Object;
  also does GIO::Roles::Initable;
  also does GIO::Roles::AsyncInitable;
  also does Evolution::Roles::Signals::Book::Client::View;

  has EBookClientView $!ebcv;

  submethod BUILD (:$client-view, :$init, :$cancellable) {
    self.setEBookClientView($client-view, :$init, :$cancellable)
      if $client-view;
  }

  method setEBookClientView (
    EBookClientViewAncestry $_,
                            :$init,
                            :$cancellable
  ) {
    my $to-parent;

    $!ebcv = do {
      when EBookClientView {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GInitable {
        $!i = $_;
        $to-parent = cast(GObject, $_);
        cast(EBookClientView, $_);
      }

      default {
        $to-parent = $_;
        cast(EBookClientView, $_);
      }
    }
    self.roleInit-Object;
    self.roleInit-Initable(:$init, :$cancellable);
  }

  method Evolution::Raw::Definitions::EBookClientView
  { $!ebcv }

  # Type: EBookClient
  method client (:$raw = False) is rw  {
    my $gv = GLib::Value.new( Evolution::Book::Client.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('client', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          EBookClient,
          Evolution::Book::Client
        )
      },
      STORE => -> $,  $val is copy {
        warn 'client is a construct-only attribute'
      }
    );
  }

  # Type: GDBusConnection
  method connection (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GIO::DBus::Connection.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('connection', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GDBusConnection,
          GIO::DBus::Connection
        )
      },
      STORE => -> $,  $val is copy {
        warn 'connection is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method object-path is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('object-path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'object-path is a construct-only attribute'
      }
    );
  }

  # Is originally:
  # EBookClientView, GError, gpointer --> void
  method complete {
    self.connect-complete($!ebcv);
  }

  # Is originally:
  # EBookClientView, gpointer, gpointer --> void
  method objects-added {
    self.connect-book-objects($!ebcv, 'objects-added');
  }

  # Is originally:
  # EBookClientView, gpointer, gpointer --> void
  method objects-modified {
    self.connect-book-objects($!ebcv, 'objects-modified');
  }

  # Is originally:
  # EBookClientView, gpointer, gpointer --> void
  method objects-removed {
    self.connect-book-objects($!ebcv, 'objects-removed');
  }

  # Is originally:
  # EBookClientView, guint, gchar, gpointer --> void
  method progress {
    self.connect-progress($!ebcv);
  }

  method get_client (:$raw = False) is DEPRECATED<ref_client> {
    my $c = e_book_client_view_get_client($!ebcv);

    # Transfer: none
    $c ??
      ( $raw ?? $c !! Evolution::Book::Client.new($c) )
      !!
      Nil;
  }

  method get_connection (:$raw = False) {
    my $dbc = e_book_client_view_get_connection($!ebcv);

    # Transfer: none
    $dbc ??
      ( $raw ?? $dbc !! GIO::DBus::Connection.new($dbc) )
      !!
      Nil;
  }

  method get_object_path {
    e_book_client_view_get_object_path($!ebcv);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_client_view_get_type, $n, $t );
  }

  method is_running {
    so e_book_client_view_is_running($!ebcv);
  }

  method ref_client (:$raw = False) {
    my $c = e_book_client_view_ref_client($!ebcv);

    $c ??
      ( $raw ?? $c !! Evolution::Book::Client.new($c, :!ref) )
      !!
      Nil;
  }

  proto method set_fields_of_interest (|)
  { * }

  multi method set_fields_of_interest (
                            @fields-of-interest,
    CArray[Pointer[GError]] $error               = gerror
  ) {
    samewith( GLib::GSList.new(@fields-of-interest, Str), $error );
  }
  multi method set_fields_of_interest (
    GSList()                $fields_of_interest,
    CArray[Pointer[GError]] $error               = gerror
  ) {
    clear_error;
    e_book_client_view_set_fields_of_interest(
      $!ebcv,
      $fields_of_interest,
      $error
    );
    set_error($error);
  }

  method set_flags (
    Int()                   $flags,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    my EBookClientViewFlags $f = $flags;

    clear_error;
    e_book_client_view_set_flags($!ebcv, $f, $error);
    set_error($error);
  }

  method start (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_book_client_view_start($!ebcv, $error);
    set_error($error);
  }

  method stop (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    e_book_client_view_stop($!ebcv, $error);
    set_error($error);
  }

}
