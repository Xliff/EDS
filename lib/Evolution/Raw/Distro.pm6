use v6.c;

use GLib::Raw::Definitions;

unit package Evolution::Raw::Distro;

# Change listing to alpha by-key!
BEGIN my %unix-library-adjustments = (

  ecal => {
    Ubuntu => {
      groovy => {
        lib-append => '-2.0',
        version => 1
      }
    },

    Debian => {
      buster => {
        lib-append => '-1.2',
        version => v19
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

multi sub version-by-distro ($lib is copy, :$unix is required) is export {
  my $lr = qqx{which lsb_release}.chomp;
  say "LIB: $lib\nLSB_RELEASE: $lr" if $DEBUG;
  my ($distro, $codename) =
    ( qqx{$lr -d -s}.split(/\s/)[0], qqx{$lr -c -s} )».chomp;

  say "DISTRO: $distro\nCODENAME: $codename" if $DEBUG;

  say 'GLOBAL SETTING: ' ~
      %unix-library-adjustments.gist if $DEBUG;;

  say 'LIBRARY SETTING: ' ~
          %unix-library-adjustments{$lib}.gist if $DEBUG;

  say 'DISTRO SETTING: ' ~
          %unix-library-adjustments{$lib}{$distro}.gist if $DEBUG;

  $lib ~ (.<lib-append> // ''), (.<version> // v0)
    given %unix-library-adjustments{$lib}{$distro}{$codename}
}
