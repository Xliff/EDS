use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Definitions;
use Evolution::Raw::Types;

use GTK::Widget;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ECertificateWidgetAncestry is export of Mu
  where ECertificateWidget | GtkWidgetAncestry;

class Evolution::UI::Certificate is GTK::Widget {
  has ECertificateWidget $!eds-cw is implementor;

  submethod BUILD ( :$e-certificate-widget ) {
    self.setECertificateWidget($e-certificate-widget)
      if $e-certificate-widget
  }

  method setECertificateWidget (ECertificateWidgetAncestry $_) {
    my $to-parent;

    $!eds-cw = do {
      when ECertificateWidget {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECertificateWidget, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method Evolution::Raw::Definitions::ECertificateWidget
    is also<ECertificateWidget>
  { $!eds-cw }

  multi method new (
    $e-certificate-widget where * ~~ ECertificateWidgetAncestry,

    :$ref = True
  ) {
    return unless $e-certificate-widget;

    my $o = self.bless( :$e-certificate-widget );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $e-certficate-widget = e_certificate_widget_new();

    $e-certficate-widget ?? self.bless( :$e-certficate-widget ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_certificate_widget_get_type, $n, $t );
  }

  method set_der (gpointer $der_data, Int() $der_data_len) is also<set-der> {
    my guint $d = $der_data_len;

    e_certificate_widget_set_der($!eds-cw, $der_data, $d);
  }

  method set_pem (Str() $pem_data) is also<set-pem> {
    e_certificate_widget_set_pem($!eds-cw, $pem_data);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserverui/e-certificate-widget.h

sub e_certificate_widget_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_certificate_widget_new
  returns GtkWidget
  is      native(eds)
  is      export
{ * }

sub e_certificate_widget_set_der (
  ECertificateWidget $self,
  gconstpointer      $der_data,
  guint              $der_data_len
)
  is      native(eds)
  is      export
{ * }

sub e_certificate_widget_set_pem (
  ECertificateWidget $self,
  Str                $pem_data
)
  is      native(eds)
  is      export
{ * }
