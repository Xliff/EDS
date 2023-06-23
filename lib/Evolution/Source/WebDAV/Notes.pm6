use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Raw::Traits;
use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ESourceWebDAVNotesAncestry is export of Mu
  where ESourceWebDAVNotes | GObject;

class Evolution::Source::WebDAV::Notes {
  also does GLib::Roles::Object;
  
  has ESourceWebDAVNotes $!eds-wn is implementor;

  submethod BUILD ( :$e-webdav-notes ) {
    self.setESourceWebDAVNotes($e-webdav-notes)
      if $e-webdav-notes
  }

  method setESourceWebDAVNotes (ESourceWebDAVNotesAncestry $_) {
    my $to-parent;

    $!eds-wn = do {
      when ESourceWebDAVNotes {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceWebDAVNotes, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceWebDAVNotes
    is also<ESourceWebDAVNotes>
  { $!eds-wn }

  multi method new ($e-webdav-notes where * ~~ ESourceWebDAVNotesAncestry , :$ref = True) {
    return unless $e-webdav-notes;

    my $o = self.bless( :$e-webdav-notes );
    $o.ref if $ref;
    $o;
  }

  method default_ext is also<default-ext> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_default_ext    },
      STORE => -> $, \v { self.set_default_ext(v) }
  }

  method dup_default_ext is also<dup-default-ext> {
    e_source_webdav_notes_dup_default_ext($!eds-wn);
  }

  method get_default_ext is also<get-default-ext> {
    e_source_webdav_notes_get_default_ext($!eds-wn);
  }

  method set_default_ext (Str() $default_ext) is also<set-default-ext> {
    e_source_webdav_notes_set_default_ext($!eds-wn, $default_ext);
  }
}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-webdav-notes.h

sub e_source_webdav_notes_dup_default_ext (ESourceWebDAVNotes $extension)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_source_webdav_notes_get_default_ext (ESourceWebDAVNotes $extension)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_source_webdav_notes_set_default_ext (
  ESourceWebDAVNotes $extension,
  Str                $default_ext
)
  is      native(eds)
  is      export
{ * }
