use v6.c;

use NativeCall;

use Evolution::Raw::Types;

role Evolution::Roles::Signals::User::Prompter::Server {
  has %!signals-ups;

  # EUserPrompterServer, gint, Str, Str, Str, Str, gboolean, StrV
  method connect-prompt (
    $obj,
    $signal = 'prompt',
    &handler?
  ) {
    my $hid;
    %!signals-ups{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-prompt($obj, $signal,
        -> $, $i, $s1, $s2, $s3, $s4, $b, $sv, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $i, $s1, $s2, $s3, $s4, $b, $sv, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ups{$signal}[0].tap(&handler) with &handler;
    %!signals-ups{$signal}[0];
  }

}


# EUserPrompterServer, gint, Str, Str, Str, Str, gboolean, StrV
sub g-connect-prompt(
  Pointer $app,
  Str     $name,
          &handler (
            EUserPrompterServer,
            gint,
            Str,
            Str,
            Str,
            Str,
            gboolean,
            CArray[Str],
            gpointer
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
