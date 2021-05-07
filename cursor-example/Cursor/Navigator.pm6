use GTK::Raw::Types;

use GTK::Scale;

class Cursor::Navigator {
  has @!alphabet;
  has $!index;

  # Should also handle coercion! ;D
  has GTK::Scale $!scale handles(*);

  has $!adj;
  has %!supplier;
  has $!block-value-change-event;

  submethod BUILD {
    $!scale = GTK::Scale.new(
      GTK_ORIENTATION_VERTICAL,
      ( $!adj = GTK::Adjustment.new(0, 0, 1, 1, 1, 0) )
    );

    my $self = self;
    $!adj.notify('value').tap(-> *@a {
      # cw: Doubt this will work... we don't make the assignment!
      # cw: Also... self will not wrap, but $self will
      $self.index = $!adj.value unless $!block-value-change-event;
    });

    $!scale.format-value.tap(-> *@a {
      @a.tail.r = @!alphabet[ @a[1].&clamp(0 ..^ +@!alphabet) ]
        if @!alphabet.elems;
    });
  }

  method alphabet is rw {
    Proxy.new:
      FETCH => -> $                { @!alphabet },

      STORE => -> $, @new-alphabet {
        @!alphabet = @new-alphabet;
        self.update-parameters;
        self.index = 0;
      };
  }

  method index ( :$action = True ) is rw {
    Proxy.new:
      FETCH => -> $           { $!index },

      STORE => -> $, Int() $i {
        $!index = $i.clamp( 0 ..^ +@!alphabet );

        %!supplier<index-changed>.emit($!index) if $action;
        $!block-value-change-event = True;
        $!adj.value = $!index;
        $!block-value-change-event = False;
      }
  }

  method update-parameters {
    $!scale.clear-marks;

    for @!alphabet.kv -> $k, $v {
      $!scale.add-mark(
        $k,
        GTK_POS_LEFT,
        '<span size="x-small">%s</span>'.fmt($v)
      )
    }

    $!adj.upper = +@!alphabet - 1;
  }

}
