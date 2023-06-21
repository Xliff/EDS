use v6.c;

use Method::Also;

use Evolution::Raw::Types;

use Evolution::Source::Backend;

use GLib::Roles::Implementor;

our subset ESourceMailTransportAncestry is export of Mu
  where ESourceMailTransport | ESourceBackendAncestry;

class Evolution::Source::MailTransport is Evolution::Source::Backend {
  has ESourceMailTransport $!eds-mt is implementor;

  submethod BUILD ( :$e-source-mailtrans ) {
    self.setESourceMailTransport($e-source-mailtrans) if $e-source-mailtrans
  }

  method setESourceMailTransport (ESourceMailTransportAncestry $_) {
    my $to-parent;

    $!eds-mt = do {
      when ESourceMailTransport {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailTransport, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailTransport
    is also<ESourceMailTransport>
  { $!eds-mt }

  multi method new (
     $e-source-mailtrans where * ~~ ESourceMailTransportAncestry,

    :$ref = True
  ) {
    return unless $e-source-mailtrans;

    my $o = self.bless( :$e-source-mailtrans );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_transport_get_type,
      $n,
      $t
    );
  }
}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-mail-transport.h

sub e_source_mail_transport_get_type
  returns GType
  is      export
  is      native(eds)
{ * }
