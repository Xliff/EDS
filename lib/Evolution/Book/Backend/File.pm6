use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Book::Backend::Sync;

use GLib::Roles::Implementor;

our subset EBookBackendFileAncestry is export of Mu
  where EBookBackendFile | EBookBackendSyncAncestry;

class Evolution::Book::Backend::File is Evolution::Book::Backend::Sync {
  has EBookBackendFile $!eds-ml is implementor;

  submethod BUILD ( :$e-file ) {
    self.setEBookBackendFile($e-file) if $e-file
  }

  method setEBookBackendFile (EBookBackendFileAncestry $_) {
    my $to-parent;

    $!eds-ml = do {
      when EBookBackendFile {
        $to-parent = cast(EBookBackendSync, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackendFile, $_);
      }
    }
    self.setESource($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceFile
    is also<ESourceFile>
  { $!eds-ml }

  multi method new (
    $e-file where * ~~ EBookBackendFileAncestry,

    :$ref = True
  ) {
    return unless $e-file;

    my $o = self.bless( :$e-file );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_backend_file_get_type, $n, $t );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-book-backend-file.h

sub e_book_backend_file_get_type
  returns GType
  is      native(eds)
  is      export
{ * }
