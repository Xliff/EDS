use v6.c;

use NativeCall;

use Evolution::Raw::Types;

role Evolution::Roles::Signals::Calendar::View {
  has %!signals-ecv;

  # ECalClientView, GError, gpointer
  method connect-complete (
    $obj,
    $signal = 'complete',
    &handler?
  ) {
    my $hid;
    %!signals-ecv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-complete($obj, $signal,
        -> $, $e, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $e, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ecv{$signal}[0].tap(&handler) with &handler;
    %!signals-ecv{$signal}[0];
  }

  # ECalClientView, gpointer, gpointer
  method connect-objects (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ecv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-objects($obj, $signal,
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
    %!signals-ecv{$signal}[0].tap(&handler) with &handler;
    %!signals-ecv{$signal}[0];
  }

  # ECalClientView, guint, gchar, gpointer
  method connect-progress (
    $obj,
    $signal = 'progress',
    &handler?
  ) {
    my $hid;
    %!signals-ecv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-progress($obj, $signal,
        -> $, $i, $s, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $i, $s, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ecv{$signal}[0].tap(&handler) with &handler;
    %!signals-ecv{$signal}[0];
  }

}

# ECalClientView, GError, gpointer
sub g-connect-complete(
  Pointer $app,
  Str     $name,
          &handler (Pointer, GError, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# ECalClientView, gpointer, gpointer
sub g-connect-objects(
  Pointer $app,
  Str     $name,
          &handler (Pointer, gpointer, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }


# ECalClientView, guint, gchar, gpointer
sub g-connect-progress(
  Pointer $app,
  Str     $name,
          &handler (Pointer, guint, gchar, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
