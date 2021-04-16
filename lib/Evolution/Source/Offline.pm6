use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceOfflineAncestry is export of Mu
  where ESourceOffline | ESourceExtensionAncestry;

class Evolution::Source::Offline is Evolution::Source::Extension {
  has ESourceOffline $!eso;

  submethod BUILD (:$Offline) {
    self.setESourceOffline($Offline) if $Offline;
  }

  method setESourceOffline (ESourceOfflineAncestry $_) {
    my $to-parent;

    $!eso = do {
      when ESourceOffline {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceOffline, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceOffline
  { $!eso }

  method new (
    ESourceOfflineAncestry $Offline,
                           :$ref   = True
  ) {
    return Nil unless $Offline;

    my $o = self.bless( :$Offline );
    $o.ref if $ref;
    $o;
  }

  method stay_synchronized is rw {
    Proxy.new:
      FETCH => -> $     { self.get_stay_synchronized    },
      STORE => -> $, \v { self.set_stay_synchronized(v) }
  }

  method get_stay_synchronized {
    so e_source_offline_get_stay_synchronized($!eso);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_offline_get_type, $n, $t );
  }

  method set_stay_synchronized (Int() $stay_synchronized) {
    my gboolean $s = $stay_synchronized.so.Int;

    e_source_offline_set_stay_synchronized($!eso, $s);
  }

}

### /usr/include/evolution-data-server/libedataserver/e-source-offline.h

sub e_source_offline_get_stay_synchronized (ESourceOffline $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_offline_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_offline_set_stay_synchronized (ESourceOffline $extension, gboolean $stay_synchronized)
  is native(eds)
  is export
{ * }
