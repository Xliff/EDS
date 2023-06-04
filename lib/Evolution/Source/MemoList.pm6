use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Selectable;

use GLib::Roles::Implementor;

our subset ESourceMemoListAncestry is export of Mu
  where ESourceMemoList | ESourceSelectableAncestry;

class Evolution::Source::MemoList is Evolution::Source::Selectable {
  has ESourceMemoList $!eds-ml is implementor;

  submethod BUILD ( :$e-memo-list ) {
    self.setESourceMemoList($e-memo-list) if $e-memo-list
  }

  method setESourceMemoList (ESourceMemoListAncestry $_) {
    my $to-parent;

    $!eds-ml = do {
      when ESourceMemoList {
        $to-parent = cast(ESourceSelectable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMemoList, $_);
      }
    }
    self.setESource($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMemoList
    is also<ESourceMemoList>
  { $!eds-ml }

  multi method new (
    $e-memo-list where * ~~ ESourceMemoListAncestry,

    :$ref = True
  ) {
    return unless $e-memo-list;

    my $o = self.bless( :$e-memo-list );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_memo_list_get_type, $n, $t );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-memo-list.h

sub e_source_memo_list_get_type
  returns GType
  is      native(eds)
  is      export
{ * }
