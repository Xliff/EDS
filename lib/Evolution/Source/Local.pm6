use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Local;

use Evolution::Source::Extension;

use GIO::Roles::GFile;

our subset ESourceLocalAncestry is export of Mu
  where ESourceLocal | ESourceExtensionAncestry;

class Evolution::Source::Local is Evolution::Source::Extension {
  has ESourceLocal $!esl;

  submethod BUILD (:$local) {
    self.setESourceLocal($local) if $local;
  }

  method setESourceLocal (ESourceLocalAncestry $_) {
    my $to-parent;

    $!esl = do {
      when ESourceLocal {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceLocal, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceLocal
  { $!esl }

  multi method new (ESourceLocalAncestry $local, :$ref = True) {
    return Nil unless $local;

    my $o = self.bless( :$local );
    $o.ref if $ref;
    $o;
  }

  method custom_file is rw {
    Proxy.new:
      FETCH => -> $     { self.get_custom_file    },
      STORE => -> $, \v { self.set_custom_file(v) }
  }

  method writable is rw {
    Proxy.new:
      FETCH => -> $     { self.get_writable    },
      STORE => -> $, \v { self.set_writable(v) }
  }

  method dup_custom_file {
    e_source_local_dup_custom_file($!esl);
  }

  method get_custom_file (:$raw = False) {
    my $f = e_source_local_get_custom_file($!esl);

    $f ??
      ( $raw ?? $f !! GIO::GFile.new($f) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_local_get_type, $n, $t );
  }

  method get_writable {
    so e_source_local_get_writable($!esl);
  }

  method set_custom_file (GFile() $custom_file) {
    e_source_local_set_custom_file($!esl, $custom_file);
  }

  method set_writable (Int() $writable) {
    my gboolean $w = $writable.so.Int;

    e_source_local_set_writable($!esl, $writable);
  }

}
