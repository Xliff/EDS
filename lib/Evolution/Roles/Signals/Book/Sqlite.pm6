use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use Evolution::Raw::Types;

role Evolution::Roles::Signals::Book::Sqlite {
  has %!signals-ebs;

  # EBookSqlite, gpointer, GObject, gchar, gboolean, GObject, gpointer, gpointer --> gboolean
  method connect-before-insert-contact (
    $obj,
    $signal = 'before-insert-contact',
    &handler?
  ) {
    my $hid;
    %!signals-ebs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-before-insert-contact($obj, $signal,
        -> $, $p, $o, $c, $b, $o2, $p2, $ud --> gboolean {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $p, $o, $c, $b, $o2, $p2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ebs{$signal}[0].tap(&handler) with &handler;
    %!signals-ebs{$signal}[0];
  }

  # EBookSqlite, gpointer, gchar, GObject, gpointer, gpointer --> gboolean
  method connect-before-remove-contact (
    $obj,
    $signal = 'before-remove-contact',
    &handler?
  ) {
    my $hid;
    %!signals-ebs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-before-remove-contact($obj, $signal,
        -> $, $p, $c, $o, $p2, $ud --> gboolean {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $p, $c, $o, $p2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ebs{$signal}[0].tap(&handler) with &handler;
    %!signals-ebs{$signal}[0];
  }

}

# EBookSqlite, gpointer, GObject, gchar, gboolean, GObject, gpointer, gpointer --> gboolean
sub g-connect-before-insert-contact(
  Pointer $app,
  Str $name,
  &handler (
    Pointer,
    gpointer,
    GObject,
    Str,
    gboolean,
    GObject,
    gpointer,
    Pointer
    --> gboolean
  ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# EBookSqlite, gpointer, gchar, GObject, gpointer, gpointer --> gboolean
sub g-connect-before-remove-contact(
  Pointer $app,
  Str $name,
  &handler (
    Pointer,
    gpointer,
    Str,
    GObject,
    gpointer,
    Pointer
    --> gboolean
  ),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
