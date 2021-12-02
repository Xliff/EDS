use v6.c;

use NativeCall;

use Evolution::Raw::Types;

role Evolution::Roles::Signals::Calendar::Client::View {
  has %!signals-ecv;

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
