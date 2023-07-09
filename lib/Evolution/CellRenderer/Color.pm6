use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use GTK::Raw::Types;

use GDK::RGBA;
use GTK::CellRenderer:ver<3>;

our subset ECellRendererColorAncestry is export of Mu
  where ECellRendererColor | GtkCellRendererAncestry;

class Evolution::CellRenderer::Color is GTK::CellRenderer:ver<3> {
  has ECellRendererColor $!eds-crc is implementor;

  submethod BUILD ( :$e-cell-color ) {
    self.setECellRendererColor($e-cell-color)
      if $e-cell-color
  }

  method setECellRendererColor (ECellRendererColorAncestry $_) {
    my $to-parent;

    $!eds-crc = do {
      when ECellRendererColor {
        $to-parent = cast(GtkCellRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECellRendererColor, $_);
      }
    }
    self.setGtkCellRenderer($to-parent);
  }

  method Evolution::Raw::Definitions::ECellRendererColor
    is also<ECellRendererColor>
  { $!eds-crc }

  multi method new (
    $e-cell-color where * ~~ ECellRendererColorAncestry,

    :$ref = True
  ) {
    return unless $e-cell-color;

    my $o = self.bless( :$e-cell-color );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $e-cell-color = e_cell_renderer_color_new();

    $e-cell-color ?? self.bless( :$e-cell-color ) !! Nil;
  }

  # Type: GdkRgba
  method rgba is rw  is g-property {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rgba', $gv);
        cast(Gdk::RGBA, $gv.boxed);
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rgba', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_cell_renderer_color_get_type, $n, $t );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserverui/e-cell-renderer-color.h

sub e_cell_renderer_color_new
  returns ECellRendererColor
  is      native(edsui)
  is      export
{ * }

sub e_cell_renderer_color_get_type
  returns GType
  is      native(edsui)
  is      export
{ * }
