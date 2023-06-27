use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::DBus::Server;

use GLib::Roles::Implementor;
use Evolution::Roles::Signals::User::Prompter::Server;

class Evolution::User::Prompter::Server
  is Evolution::DBus::Server
{
  also does Evolution::Roles::Signals::User::Prompter::Server;

  has EUserPrompterServer $!eds-ups is implementor;

  method new {
    my $e-user-prompt = e_user_prompter_server_new();

    $e-user-prompt ?? self.bless( :$e-user-prompt ) !! Nil;
  }

  method prompt {
    self.connect-prompt($!eds-ups);
  }

  method register (EExtension() $extension, Str() $dialog_name) {
    e_user_prompter_server_register($!eds-ups, $extension, $dialog_name);
  }

  method response (
    Int()              $prompt_id,
    Int()              $response,
    ENamedParameters() $extension_values = ENamedParameters
  ) {
    my gint ($p, $r) = ($prompt_id, $response);

    e_user_prompter_server_response($!eds-ups, $p, $r, $extension_values);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-user-prompter-server.h
sub e_user_prompter_server_new
  returns EUserPrompterServer
  is      native(ebackend)
  is      export
{ * }

sub e_user_prompter_server_register (
  EUserPrompterServer $server,
  EExtension          $extension,
  Str                 $dialog_name
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_user_prompter_server_response (
  EUserPrompterServer $server,
  gint                $prompt_id,
  gint                $response,
  ENamedParameters    $extension_values
)
  is      native(ebackend)
  is      export
{ * }

sub e_user_prompter_server_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }
