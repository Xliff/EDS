use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Selectable;

use GLib::Roles::Implementor;

our subset ESourceCalendarAncestry is export of Mu
  where ESourceCalendar | ESourceSelectableAncestry;

class Evolution::Source::Calendar is Evolution::Source::Selectable {
  has ESourceCalendar $!eds-s-c is implementor;

  submethod BUILD ( :$e-source-calendar ) {
    self.setESourceCalendar($e-source-calendar) if $e-source-calendar
  }

  method setESourceCalendar (ESourceCalendarAncestry $_) {
    my $to-parent;

    $!eds-s-c = do {
      when ESourceCalendar {
        $to-parent = cast(ESourceSelectable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceCalendar, $_);
      }
    }
    self.setESourceSelectable($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceCalendar
    is also<ESourceCalendar>
  { $!eds-s-c }

  multi method new (
     $e-source-calendar where * ~~ ESourceCalendarAncestry,

    :$ref = True
  ) {
    return unless $e-source-calendar;

    my $o = self.bless( :$e-source-calendar );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_calendar_get_type, $n, $t );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-calendar.h

sub e_source_calendar_get_type
  returns GType
  is      native(eds)
  is      export
{ * }
