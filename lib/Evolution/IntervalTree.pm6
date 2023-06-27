use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::IntervalTree;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset EIntervalTreeAncestry is export of Mu
  where EIntervalTree | GObject;

class Evolution::IntervalTree {
  also does GLib::Roles::Object;
  
  has EIntervalTree $!eds-it is implementor;

  submethod BUILD ( :$e-intervaltree ) {
    self.setEIntervalTree($e-intervaltree) if $e-intervaltree
  }

  method setEIntervalTree (EIntervalTreeAncestry $_) {
    my $to-parent;

    $!eds-it = do {
      when EIntervalTree {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EIntervalTree, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EIntervalTree
    is also<EIntervalTree>
  { $!eds-it }

  multi method new (
    $e-intervaltree where * ~~ EIntervalTreeAncestry,

    :$ref = True
  ) {
    return unless $e-intervaltree;

    my $o = self.bless( :$e-intervaltree );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $e-intervaltree = e_intervaltree_new();

    $e-intervaltree ?? self.bless( :$e-intervaltree ) !! Nil;
  }

  method destroy {
    e_intervaltree_destroy($!eds-it);
  }

  method dump {
    e_intervaltree_dump($!eds-it);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_intervaltree_get_type, $n, $t );
  }

  method insert (
    Int()           $start,
    Int()           $end,
    ECalComponent() $comp
  ) {
    my time_t ($s, $e) = ($start, $end);

    so e_intervaltree_insert($!eds-it, $s, $e, $comp);
  }

  method remove (Str() $uid, Str() $rid) {
    so e_intervaltree_remove($!eds-it, $uid, $rid);
  }

  method search (Int() $start, Int() $end, :$raw = False, :$glist = False) {
    my time_t ($s, $e) = ($start, $end);

    returnGList(
      e_intervaltree_search($!eds-it, $start, $end),
      $raw,
      $glist,
      |Evolution::Calendar::Component.getTypePair
    );
  }

}
