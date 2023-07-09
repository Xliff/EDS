use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;

use Evolution::Raw::Types;

role Evolution::Roles::Signals::Cache {
  has %!signals-eds-c;

  # ECache       *cache,
  # Str          *uid,
  # GCancellable *cancellable,
  # GError       **error
  # gpointer     user_data --> gboolean
  method connect-before-remove (
    $obj,
    $signal = 'before-remove',
    &handler?
  ) {
    my $hid;
    %!signals-eds-c{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-before-remove($obj, $signal,
        -> $, $s, $c, $e, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $s, $c, $e, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-eds-c{$signal}[0].tap(&handler) with &handler;
    %!signals-eds-c{$signal}[0];
  }

  #  Str                *uid,
  #  Str                *revision,
  #  Str                *object,
  #  ECacheColumnValues *other_columns,
  #  gboolean           is_replace,
  #  GCancellable       *cancellable,
  #  GError             **error
  #  gpointer           user_data --> gboolean
  method connect-before-put (
    $obj,
    $signal = 'before-put',
    &handler?
  ) {
    my $hid;
    %!signals-eds-c{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-before-put($obj, $signal,
        -> $, $s1, $s2, $s3, $ccv, $b, $c, $e, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [$s1, $s2, $s3, $ccv, $b, $c, $e, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-eds-c{$signal}[0].tap(&handler) with &handler;
    %!signals-eds-c{$signal}[0];
  }

}

# ECache       *cache,
# Str          *uid,
# GCancellable *cancellable,
# GError       **error --> gboolean
sub g-connect-before-remove (
  Pointer $app,
  Str     $name,
          &handler (
            Pointer,
            Str,
            GCancellable,
            GError,
            gpointer --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

#  Str                *uid,
#  Str                *revision,
#  Str                *object,
#  ECacheColumnValues *other_columns,
#  gboolean           is_replace,
#  GCancellable       *cancellable,
#  GError             **error --> gboolean
sub g-connect-before-put (
  Pointer $app,
  Str     $name,
          &handler (
            Pointer,
            Str,
            Str,
            Str,
            ECacheColumnValues,
            gboolean,
            GCancellable,
            GError,
            gpointer --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
