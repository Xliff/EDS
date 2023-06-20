use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::TestServerUtils;

use GLib::Roles::StaticClass;

class Evolution::TestServerUtils {
  also does GLib::Roles::StaticClass;

  method finish_run {
    e_test_server_utils_finish_run();
  }

  method prepare_run (Int() $flags) {
    my ETestServerFlags $f = $flags;

    e_test_server_utils_prepare_run($f);
  }

  method run {
    e_test_server_utils_run( 0, CArray[Str] );
  }

  method run_full (Int() $flags) {
    my ETestServerFlags $f = $flags;

    e_test_server_utils_run_full($f);
  }

  # cw: $user_data CANNOT be NULL. If it is, guaranteed SEGV
  method setup (
    ETestServerFixture   $fixture,
    gpointer:D           $user_data
  ) {
    e_test_server_utils_setup($fixture, $user_data);
  }

  method teardown (
    ETestServerFixture $fixture,
    gpointer:D         $user_data
  ) {
    say 'in-teardown';
    e_test_server_utils_teardown($fixture, $user_data);
    say 'exit-teardown';
  }

}

our %CLOSURES is export;
our $FIXTURE  is export;

sub initClosures (--> Nil) is export {
  %CLOSURES = (
    registry       => ETestServerClosure.new(
      type                 => E_TEST_SERVER_NONE,
      calendar-source-type => 0,
    ),
    registry-async => ETestServerClosure.new-async(E_TEST_SERVER_NONE),

    book           => ETestServerClosure.new(
      type                 => E_TEST_SERVER_ADDRESS_BOOK,
      calendar-source-type => 0,
    ),
    book-async     => ETestServerClosure.new-async(E_TEST_SERVER_ADDRESS_BOOK),

    calendar       => ETestServerClosure.new,
    calendar-async => ETestServerClosure.new-async,
  );

  say "{ .key } => { .value.gist }" for %CLOSURES.pairs;
}
