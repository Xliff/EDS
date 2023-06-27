use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Extension;

use GLib::Roles::Implementor;

our subset EUserPrompterServerExtensionAncestry is export of Mu
  where EUserPrompterServerExtension | EExtensionAncestry;

class Evolution::User::Prompter::Server::Extension is Evolution::Extension {
  has EUserPrompterServerExtension $!eds-upse is implementor;

  submethod BUILD ( :$e-prompter-service ) {
    self.setEUserPrompterServerExtension($e-prompter-service)
      if $e-prompter-service
  }

  method setEUserPrompterServerExtension (
    EUserPrompterServerExtensionAncestry $_
  ) {
    my $to-parent;

    $!eds-upse = do {
      when EUserPrompterServerExtension {
        $to-parent = cast(EExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EUserPrompterServerExtension, $_);
      }
    }
    self.setEExtension($to-parent);
  }

  method Evolution::Raw::Definitions::EUserPrompterServerExtension
    is also<EUserPrompterServerExtension>
  { $!eds-upse }

  multi method new (
    $e-prompter-service where * ~~ EUserPrompterServerExtensionAncestry,

    :$ref = True
  ) {
    return unless $e-prompter-service;

    my $o = self.bless( :$e-prompter-service );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_user_prompter_server_extension_get_type,
      $n,
      $t
    );
  }

  method prompt (
    Int()              $prompt_id,
    Str()              $dialog_name,
    ENamedParameters() $parameters   = ENamedParameters
  ) {
    my gint $p = $prompt_id;

    so e_user_prompter_server_extension_prompt(
      $!eds-upse,
      $p,
      $dialog_name,
      $parameters
    );
  }

  method response (
    Int()              $prompt_id,
    Int()              $response,
    ENamedParameters() $values      = ENamedParameters
  ) {
    my gint ($p, $r) = ($prompt_id, $response);

    e_user_prompter_server_extension_response($!eds-upse, $p, $r, $values);
  }

}


### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-user-prompter-server-extension.h

sub e_user_prompter_server_extension_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }

sub e_user_prompter_server_extension_prompt (
  EUserPrompterServerExtension $extension,
  gint                         $prompt_id,
  Str                          $dialog_name,
  ENamedParameters             $parameters
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_user_prompter_server_extension_response (
  EUserPrompterServerExtension $extension,
  gint                         $prompt_id,
  gint                         $response,
  ENamedParameters             $values
)
  is      native(ebackend)
  is      export
{ * }
