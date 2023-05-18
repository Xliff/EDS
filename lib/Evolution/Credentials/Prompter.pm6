use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Credentials::Prompter;

use GTK::Widget;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset ECredentialsPrompterAncestry is export of Mu
  where ECredentialsPrompter | GObject;

class Evolution::Credentials::Prompter {
  also does GLib::Roles::Object;

  has ECredentialsPrompter $!eds-cp is implementor;

  submethod BUILD ( :$e-credentials-prompter ) {
    self.setECredentialsPrompter($e-credentials-prompter)
      if $e-credentials-prompter
  }

  method setECredentialsPrompter (ECredentialsPrompterAncestry $_) {
    my $to-parent;

    $!eds-cp = do {
      when ECredentialsPrompter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECredentialsPrompter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECredentialsPrompter
    is also<ECredentialsPrompter>
  { $!eds-cp }

  multi method new (
    $e-credentials-prompter where * ~~ ECredentialsPrompterAncestry,

    :$ref = True
  ) {
    return unless $e-credentials-prompter;

    my $o = self.bless( :$e-credentials-prompter );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESourceRegistry() $reg) {
    my $e-credentials-prompter = e_credentials_prompter_new($reg);

    $e-credentials-prompter ?? self.bless( :$e-credentials-prompter ) !! Nil;
  }

  method complete_prompt_call (
    GSimpleAsyncResult()   $async_result,
    ESource()              $source,
    ENamedParameters()     $credentials,
    Pointer[GError]        $error
  )
    is also<complete-prompt-call>
  {
    e_credentials_prompter_complete_prompt_call(
      $!eds-cp,
      $async_result,
      $source,
      $credentials,
      $error
    );
  }

  method get_auto_prompt is also<get-auto-prompt> {
    so e_credentials_prompter_get_auto_prompt($!eds-cp);
  }

  method get_auto_prompt_disabled_for (ESource() $source)
    is also<get-auto-prompt-disabled-for>
  {
    so e_credentials_prompter_get_auto_prompt_disabled_for($!eds-cp, $source);
  }

  method get_dialog_parent (
    :$raw,
    :quick(:$fast),
    :slow(:$proper)
  )
    is also<get-dialog-parent>
  {
    GTK::Widget.CreateObject(
      e_credentials_prompter_get_dialog_parent($!eds-cp)
    );
  }

  method get_dialog_parent_full (
    ESource()  $auth_source
              :$raw,
              :quick(:$fast),
              :slow(:$proper)
  )
    is also<get-dialog-parent-full>
  {
    GTK::Widget.CreateObject(
      e_credentials_prompter_get_dialog_parent_full($!eds-cp, $auth_source)
    );
  }

  method get_provider ( :$raw = False ) is also<get-provider> {
    propReturnObject(
      e_credentials_prompter_get_provider($!eds-cp),
      $raw,
      |Evolution::Source::Credentials::Provider.getTypePair
    );
  }

  method get_registry ( :$raw = False ) is also<get-registry> {
    propReturnObject(
      e_credentials_prompter_get_registry($!eds-cp),
      $raw,
      |Evolution::Source::Registry.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_credentials_prompter_get_type, $n, $t );
  }

  proto method loop_prompt_sync (|)
    is also<loop-prompt-sync>
  { * }

  multi method loop_prompt_sync (
    ESource()                $source,
                             &func,
    gpointer                 $user_data   = gpointer,
    CArray[Pointer[GError]]  $error       = gerror,
    Int()                   :$flags       = 0,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith(
      $source,
      $flags,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }
  multi method loop_prompt_sync (
    ESource()               $source,
    Int()                   $flags,
                            &func,
    gpointer                $user_data   = gpointer,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my ECredentialsPrompterPromptFlags $f = $flags;

    clear_error;
    my $rv = e_credentials_prompter_loop_prompt_sync(
      $!eds-cp,
      $source,
      $f,
      &func,
      $user_data,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method process_awaiting_credentials is also<process-awaiting-credentials> {
    e_credentials_prompter_process_awaiting_credentials($!eds-cp);
  }

  method process_source (ESource() $source) is also<process-source> {
    e_credentials_prompter_process_source($!eds-cp, $source);
  }

  multi method prompt (
    ESource()  $source,
               &callback,
    gpointer   $user_data  = gpointer,
    Int()     :$flags      = 0,
    Str()     :$error_text = Str
  ) {
    samewith(
      $source,
      $error_text,
      $flags,
      &callback,
      $user_data
    );
  }
  multi method prompt (
    ESource() $source,
    Str()     $error_text,
    Int()     $flags,
              &callback,
    gpointer  $user_data
  ) {
    my ECredentialsPrompterPromptFlags $f = $flags;

    e_credentials_prompter_prompt(
      $!eds-cp,
      $source,
      $error_text,
      $f,
      &callback,
      $user_data
    );
  }

  proto method prompt_finish (|)
    is also<prompt-finish>
  { * }

  multi method prompt_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  ) {
    samewith(
      $result,
      newCArray(ESource),
      newCArray(ENamedParameters),
      $error,
      :all,
      :$raw
    );
  }
  multi method prompt_finish (
    GAsyncResult()            $result,
    CArray[Pointer[ESource]]  $out_source,
    CArray[ENamedParameters]  $out_credentials,
    CArray[Pointer[GError]]   $error,
                             :$all              = False,
                             :$raw              = False
  ) {
    clear_error
    my $rv = so e_credentials_prompter_prompt_finish(
      $!eds-cp,
      $result,
      $out_source,
      $out_credentials,
      $error
    );
    set_error($error);

    my $os = propReturnObject(
      ppr($out_source),
      $raw,
      |Evolution::Source.getTypePair
    );

    my $oc = propReturnObject(
      ppr($out_credentials),
      $raw,
      |Evolution::ENamedParameters.getTypePair
    );

    $all.not ?? $rv !! ($os, $oc);
  }

  method register_impl (
    Str()                      $authentication_method,
    ECredentialsPrompterImpl() $prompter_impl
  )
    is also<register-impl>
  {
    e_credentials_prompter_register_impl(
      $!eds-cp,
      $authentication_method,
      $prompter_impl
    );
  }

  method set_auto_prompt (Int() $auto_prompt) is also<set-auto-prompt> {
    my gboolean $a = $auto_prompt.so.Int;

    e_credentials_prompter_set_auto_prompt($!eds-cp, $a);
  }

  method set_auto_prompt_disabled_for (ESource $source, Int() $is_disabled) {
    my gboolean $i = $is_disabled.so.Int;

    e_credentials_prompter_set_auto_prompt_disabled_for(
      $!eds-cp,
      $source,
      $i
    );
  }

  method unregister_impl (
    Str()                      $authentication_method,
    ECredentialsPrompterImpl() $prompter_impl
  )
    is also<set-auto-prompt-disabled-for>
  {
    e_credentials_prompter_unregister_impl(
      $!eds-cp,
      $authentication_method,
      $prompter_impl
    );
  }

}
