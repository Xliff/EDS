use v6.c;

use NativeCall;

use Evolution::Raw::Types;

role Evolution::Roles::Signals::Book::Client::View {
  has %!signals-ebcv;

  # EBookClientView, GError, gpointer
  method connect-complete (
    $obj,
    $signal = 'complete',
    &handler?
  ) {
    my $hid;
    %!signals-ebcv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-complete($obj, $signal,
        -> $, $, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ebcv{$signal}[0].tap(&handler) with &handler;
    %!signals-ebcv{$signal}[0];
  }

  # EBookClientView, gpointer, gpointer
  method connect-book-objects (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ebcv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-book-objects($obj, $signal,
        -> $, $g, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ebcv{$signal}[0].tap(&handler) with &handler;
    %!signals-ebcv{$signal}[0];
  }

  # EBookClientView, guint, gchar, gpointer
  method connect-progress (
    $obj,
    $signal = 'progress',
    &handler?
  ) {
    my $hid;
    %!signals-ebcv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-progress($obj, $signal,
        -> $, $i, $c, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $i, $c, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ebcv{$signal}[0].tap(&handler) with &handler;
    %!signals-ebcv{$signal}[0];
  }


}

# EBookClientView, GError, gpointer
sub g-connect-complete(
  Pointer $app,
  Str $name,
  &handler (EBookClientView, GError, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# EBookClientView, gpointer, gpointer
sub g-connect-book-objects(
  Pointer $app,
  Str $name,
  &handler (EBookClientView, gpointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# EBookClientView, guint, gchar, gpointer
sub g-connect-progress(
  Pointer $app,
  Str $name,
  &handler (EBookClientView, guint, gchar, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
