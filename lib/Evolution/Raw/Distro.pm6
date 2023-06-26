use v6.c;

use GLib::Raw::Definitions;

unit package Evolution::Raw::Distro;

# Change listing to alpha by-key!
my %ecal-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-2.0'
      ),

      groovy => (
        version    => v1
      ).Hash,

      mantic => my $ulatest = (
        version    => v2
      ).Hash,

      latest => $ulatest
    ).Hash,

    Debian => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      buster => my $dlatest = (
        version    => v19
      ).Hash,

      latest => $dlatest
    ).Hash
  ).Hash;
}

my %ebook-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      groovy => (
        version    => v19
      ).Hash,

      hirsute => (
        version    => v20
      ).Hash,

      mantic => my $ulatest = (
        version    => v21
      ).Hash,

      latest => $ulatest
    ).Hash,

    Debian => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      buster => my $dlatest = (
        version    => v19
      ).Hash,

      latest => $dlatest
    ).Hash
  ).Hash;
}

my %edata-book-adjustments = do {
  Ubuntu => (
    DEFAULTS => (
      lib-append => '-1.2'
    ),

    groovy => (
      version    => v25
    ).Hash,

    hirsute => (
      version    => v25
    ).Hash,

    ionic => (
      version    => v26
    ).Hash,

    lunatic => my $ulatest = (
      version    => v27
    ).Hash,

    latest => $ulatest
  )

}

my %ebook-contacts-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      groovy => (
        version    => v3
      ).Hash,

      hirsute => (
        version    => v3
      ).Hash,

      mantic => my $ulatest = (
        version    => v4
      ).Hash,

      latest => $ulatest,
    ).Hash,

    Debian => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      buster => my $dlatest = (
        version    => v2
      ).Hash,

      latest => $dlatest
    ).Hash
  ).Hash;
}

my %edataserver-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      focal => (
        version => v24
      ).Hash,

      groovy => (
        version => v25
      ).Hash,

      hirsute => (
        version => v26
      ).Hash,

      mantic => my $ulatest = (
        version => v27
      ).Hash,

      latest => $ulatest
    ).Hash,

    Debian => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      buster => my $dlatest = (
        version    => v23
      ).Hash,

      latest => $dlatest
    ).Hash
  ).Hash;
}

my %edataserverui-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      mantic => my $ulatest = (
        version => v4
      ).Hash,

      latest => $ulatest
    )
  ).Hash;
}

my %ebackend-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      groovy => (
        version    => v10
      ).Hash,

      hirsute => (
        version    => v10
      ).Hash,

      mantic => my $ulatest = (
        version    => v11
      ).Hash,

      latest => $ulatest
    ).Hash,

    Debian => (
      DEFAULTS => (
        lib-append => '-1.2'
      ),

      buster => my $dlatest = (
        version    => v10
      ).Hash,

      latest => $dlatest
    ).Hash
  ).Hash;
}

my %edata-cal-adjustments = do {
  (
    Ubuntu => (
      DEFAULTS => (
        lib-append => '-2.0'
      ),

      groovy => (
        version    => v1
      ).Hash,

      hirsute => (
        version    => v1
      ).Hash,

      mantic => my $ulatest = (
        version    => v2
      ).Hash,

      latest => $ulatest
    ).Hash
  ).Hash;
}

my %unix-library-adjustments = (
  ecal           => %ecal-adjustments,
  ebook          => %ebook-adjustments,
  edata-book     => %edata-book-adjustments,
  ebook-contacts => %ebook-contacts-adjustments,
  edataserver    => %edataserver-adjustments,
  eds            => %edataserver-adjustments,
  edataserverui  => %edataserverui-adjustments,
  ebackend       => %ebackend-adjustments,
  edata-cal      => %edata-cal-adjustments
).Hash;

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

      # cw: Only assign if no assignment
      $value = .{$prefix}{$distro}<latest>{$part}
        unless $value;
    }

    $value
  }

  $lib        = getDistroValue('lib');
  $lib-append = getDistroValue('lib-append');
  $version    = getDistroValue('version');

  ($lib // $prefix) ~ ($lib-append // ''), ($version // v0);
}
