use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Selectable;

use GLib::Roles::Implementor;

our subset ESourceTaskListAncestry is export of Mu
  where ESourceTaskList | ESourceSelectableAncestry;

class Evolution::Source::TaskList is Evolution::Source::Selectable {
  has ESourceTaskList $!eds-ml is implementor;

  submethod BUILD ( :$e-Task-list ) {
    self.setESourceTaskList($e-Task-list) if $e-Task-list
  }

  method setESourceTaskList (ESourceTaskListAncestry $_) {
    my $to-parent;

    $!eds-ml = do {
      when ESourceTaskList {
        $to-parent = cast(ESourceSelectable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceTaskList, $_);
      }
    }
    self.setESource($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceTaskList
    is also<ESourceTaskList>
  { $!eds-ml }

  multi method new (
    $e-Task-list where * ~~ ESourceTaskListAncestry,

    :$ref = True
  ) {
    return unless $e-Task-list;

    my $o = self.bless( :$e-Task-list );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_Task_list_get_type, $n, $t );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-task-list.h

sub e_source_Task_list_get_type
  returns GType
  is      native(eds)
  is      export
{ * }
