use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

use GLib::Roles::Pointers;

unit package Evolution::Raw::TestServerUtils;

class ETestService is repr<CUnion> is export {
  has gpointer    $.generic;
  has EBookClient $.book-client;
  has ECalClient  $.calendar-client;
  has EBook       $.book;

  method getGenericService (\T, $C?) {
    my $i = cast(T, $!generic);
    return $i unless $C !=== Nil;
    $C.new($i);
  }
}

class ETestServerFixture is repr<CStruct> is export does GLib::Roles::Pointers {
  has GMainLoop       $.loop;
  has gpointer        $.dbus;
  has ESourceRegistry $.registry;
  HAS ETestService    $.service;
  has Str             $.source-name;

  has guint           $!timeout-source-id; # is accessor-less;
  HAS GWeakRef        $!registry-ref     ; # is accessor-less;
  HAS GWeakRef        $!client-ref       ; # is accessor-less;

  multi method ServerUtilsService ($a where *.lc eq 'generic', \T) {
    $.service.getGenericService(T);
  }
}

class ETestServerClosure
  is   repr<CStruct>
  is   export
  does GLib::Roles::Pointers
{
  has ETestServiceType      $.type                  is rw;
  has Pointer               $!customize;
  has ECalClientSourceType  $.calendar-source-type  is rw;
  has gboolean              $.keep-work-directory   is rw;
  has GDestroyNotify        $!destroy-closure-func;
  has gboolean              $.use-async-connect     is rw;

  submethod BUILD (
    :$!type                 = E_TEST_SERVER_CALENDAR,
    :$!calendar-source-type = E_CAL_CLIENT_SOURCE_TYPE_EVENTS,
    :$!keep-work-directory  = False,
    :$!use-async-connect    = False
  ) {
    $!customize             := Pointer;
    $!destroy-closure-func  := Pointer;
  }

  method gist {
    qq:to/GIST/.chomp;
      ETestServerClosure.new(
        type                 => { ETestServiceTypeEnum( $!type ) },
        calendar-source-type => { ECalClientSourceTypeEnum(
                                    $!calendar-source-type
                                  ) },
        keep-work-directory  => { $!keep-work-directory },
        use-async-connect    => { $!use-async-connect }
      );
      GIST
  }

  method new-async ($type = E_TEST_SERVER_CALENDAR) {
    self.bless( :$type, :use-async-connect );
  }

}

### /home/cbwood/Projects/p6-EvolutionDataServer/src/e-test-server-utils.h

sub e_test_server_utils_finish_run
  is native(&e-test-utils)
  is export
{ * }

sub e_test_server_utils_prepare_run (ETestServerFlags $flags)
  is native(&e-test-utils)
  is export
{ * }

sub e_test_server_utils_run ( gint, CArray[Str] )
  returns gint
  is      native(&e-test-utils)
  is      export
{ * }

sub e_test_server_utils_run_full (ETestServerFlags $flags)
  returns gint
  is      native(&e-test-utils)
  is      export
{ * }

sub e_test_server_utils_setup (
  ETestServerFixture $fixture,
  Pointer            $user_data
)
  is native(&e-test-utils)
  is export
{ * }

sub e_test_server_utils_teardown (
  ETestServerFixture $fixture,
  Pointer            $user_data
)
  is native(&e-test-utils)
  is export
{ * }

sub e_test_server_gshort_size ()
  returns uint64 # unsigned long
  is      native(&e-test-utils)
  is      export
{ * }
