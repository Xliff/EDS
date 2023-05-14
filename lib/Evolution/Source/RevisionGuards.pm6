use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceRevisionGuardsAncestry is export of Mu
  where ESourceRevisionGuards | ESourceExtensionAncestry;

class Evolution::Source::RevisionGuards is Evolution::Source::Extension {
  has ESourceRevisionGuards $!esrg;

  submethod BUILD (:$RevisionGuards) {
    self.setESourceRevisionGuards($RevisionGuards) if $RevisionGuards;
  }

  method setESourceRevisionGuards (ESourceRevisionGuardsAncestry $_) {
    my $to-parent;

    $!esrg = do {
      when ESourceRevisionGuards {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceRevisionGuards, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceRevisionGuards
  { $!esrg }

  method new (
    ESourceRevisionGuardsAncestry $RevisionGuards,
                                  :$ref   = True
  ) {
    return Nil unless $RevisionGuards;

    my $o = self.bless( :$RevisionGuards );
    $o.ref if $ref;
    $o;
  }

  method enabled is rw {
    Proxy.new:
      FETCH => -> $     { self.get_enabled    },
      STORE => -> $, \v { self.set_enabled(v) }
  }

  method get_enabled {
    so e_source_revision_guards_get_enabled($!esrg);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_revision_guards_get_type,
      $n,
      $t
    );
  }

  method set_enabled (gboolean $enabled) {
    my gboolean $e = $enabled.so.Int;

    e_source_revision_guards_set_enabled($!esrg, $e);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-revision-guards.h

sub e_source_revision_guards_get_enabled (ESourceRevisionGuards $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_revision_guards_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_revision_guards_set_enabled (ESourceRevisionGuards $extension, gboolean $enabled)
  is native(eds)
  is export
{ * }
