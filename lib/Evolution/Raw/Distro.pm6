use v6.c;

use GLib::Raw::Debug;
use GLib::Raw::Distro;
use GLib::Raw::Definitions;

unit package Evolution::Raw::Distro;

# Change listing to alpha by-key!
my %ecal-adjustments = do {
  (
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
    ).Hash
  ).Hash;
}

my %ebook-adjustments = do {
  (
    linux => (
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
    ).Hash
  );
}

my %edata-book-adjustments = do {
  linux => (
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
    ).Hash
  ).Hash
}

my %ebook-contacts-adjustments = do {
  (
    linux => (
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
    ).Hash
  );
}

my %edataserver-adjustments = do {
  (
    linux => (
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
    ).Hash
  ).Hash;
}

my %edataserverui-adjustments = do {
  (
    linux => (
      Ubuntu => (
        DEFAULTS => (
          lib-append => '-1.2'
        ),

        mantic => my $ulatest = (
          version => v4
        ).Hash,

        latest => $ulatest
      ).Hash
    ).Hash
  ).Hash;
}

my %ebackend-adjustments = do {
  (
    linux => (
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
  ).Hash
}

my %edata-cal-adjustments = do {
  (
    linux => (
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
    ).Hash
  ).Hash
}

my %eds-library-adjustments = (
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

INIT {
  add-distro-adjustments( %eds-library-adjustments );
}
