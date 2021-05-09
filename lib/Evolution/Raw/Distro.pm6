use v6.c;

use GLib::Raw::Definitions;

unit package Evolution::Raw::Distro;

# Change listing to alpha by-key!
BEGIN my %unix-library-adjustments = (
  ecal => {
    Ubuntu => {
      groovy => {
        lib-append => '-2.0',
        version    => 1
      }
    },

    Debian => {
      buster => {
        lib-append => '-1.2',
        version    => v19
      }
    }
  },

  ebook => {
    Ubuntu => {
      groovy => {
        lib-append => '-1.2',
        version    => v25
      }
    },

    Debian => {
      buster => {
        lib-append => '-1.2',
        version    => v19
      }
    }
  },

  ebook-contacts => {
    Ubuntu => {
      groovy => {
        lib-append => '-1.2',
        version    => v3
      }
    },

    Debian => {
      buster => {
        lib-append => '-1.2',
        version    => v2
      }
    }
  },

  edataserver => {
    Ubuntu => {
      groovy => {
        lib-append => '-1.2',
        version    => v25
      }
    },

    Debian =>{
      buster => {
        lib-append => '-1.2',
        version    => v23
      }
    }
  },

  ebackend => {
    Ubuntu => {
      groovy => {
        lib-append => '-1.2',
        version    => v10
      }
    },

    Debian =>{
      buster => {
        lib-append => '-1.2',
        version    => v10
      }
    }
  },

  edata-cal => {
    Ubuntu => {
      groovy => {
        lib-append => '-2.0',
        version    => v1
      }
    }
  }
);

multi sub version-by-distro ($lib) is export {
  $*DISTRO.is-win ?? samewith($lib, :windows)
                  !! samewith($lib, :unix   );
}

multi sub version-by-distro ($lib, :$windows is required) is export {
  say 'NYI: Windows .DLL support for Evolution';
  #exit 1;
  # NYI! This is probably going to need a Cygwin and an MSVC check!
}

sub adjustments is export {
  %unix-library-adjustments
}

multi sub version-by-distro ($prefix is copy, :$unix is required) is export {
  my $lr = qqx{which lsb_release}.chomp;
  say "PREFIX: $prefix\nLSB_RELEASE: $lr" if $DEBUG;
  my ($distro, $codename) =
    ( qqx{$lr -d -s}.split(/\s/)[0], qqx{$lr -c -s} )».chomp;

  say "DISTRO: $distro\nCODENAME: $codename" if $DEBUG;

  say 'GLOBAL SETTING: ' ~
      %unix-library-adjustments.gist if $DEBUG;;

  say 'LIBRARY SETTING: ' ~
      %unix-library-adjustments{$prefix}.gist if $DEBUG;

  say 'DISTRO SETTING: ' ~
      %unix-library-adjustments{$prefix}{$distro}.gist if $DEBUG;

  my ($lib, $lib-append, $version);

  sub getDistroValue ($part) {
    my $value;

    given %unix-library-adjustments {
      $value = .{$prefix}<DEFAULTS>{$part}
        if .{$prefix}<DEFAULTS>{$part};
      $value = .{$prefix}{$distro}<DEFAULTS>{$part}
        if .{$prefix}{$distro}<DEFAULTS>{$part};
      $value = .{$prefix}{$distro}{$codename}{$part}
        if .{$prefix}{$distro}{$codename}{$part};
    }

    $value
  }

  $lib        = getDistroValue('lib');
  $lib-append = getDistroValue('lib-append');
  $version    = getDistroValue('version');

  ($lib // $prefix) ~ ($lib-append // ''), ($version // v0);
}
