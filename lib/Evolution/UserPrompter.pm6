use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::UserPrompter;

use GLib::GList;

use GLib::Roles::Object;

our subset EUserPrompterAncestry is export of Mu
  where EUserPrompter | GObject;

class Evolution::UserPrompter {
  also does GLib::Roles::Object;

  has EUserPrompter $!eup;

  submethod BUILD (:$prompt) {
    self.setEUserPrompter($prompt) if $prompt;
  }

  method setEUserPrompter (EUserPrompterAncestry $_) {
    my $to-parent;

    $!eup = do {
      when EUserPrompter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EUserPrompter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EUserPrompter
  { $!eup }

  multi method new (EUserPrompterAncestry $prompt, :$ref = True) {
    return Nil unless $prompt;

    my $o = self.bless( :$prompt );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $prompt = e_user_prompter_new();

    $prompt ?? self.bless( :$prompt ) !! Nil;
  }

  proto method extension_prompt (|)
  { * }

  multi method extension_prompt (
    Str()              $dialog_name,
                       &callback,
    gpointer           $user_data     = gpointer,
    ENamedParameters() $in_parameters = ENamedParameters,
    GCancellable()     $cancellable   = GCancellable,
  ) {
    samewith(
      $dialog_name,
      $in_parameters,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method extension_prompt (
    Str()              $dialog_name,
    ENamedParameters() $in_parameters,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data
  ) {
    e_user_prompter_extension_prompt(
      $!eup,
      $dialog_name,
      $in_parameters,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method extension_prompt_finish (|)
  { * }

  multi method extension_prompt_finish (
    GAsyncResult            $result,
    CArray[Pointer[GError]] $error       = gerror,
    ENamedParameters        :$out_values = ENamedParameters
  ) {
    samewith($result, $out_values, $error);
  }
  multi method extension_prompt_finish (
    GAsyncResult            $result,
    ENamedParameters        $out_values = ENamedParameters,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    e_user_prompter_extension_prompt_finish($!eup, $result, $out_values, $error);
  }

  proto method extension_prompt_sync (|)
  { * }

  multi method extension_prompt_sync (
    Str()                   $dialog_name,
    ENamedParameters()      $in_parameters,
    CArray[Pointer[GError]] $error          = gerror,
    ENamedParameters()      :$out_values    = ENamedParameters,
    GCancellable()          :$cancellable   = GCancellable
  ) {
    samewith(
      $dialog_name,
      $in_parameters,
      $out_values,
      $cancellable,
      $error
    );
  }
  multi method extension_prompt_sync (
    Str()                   $dialog_name,
    ENamedParameters()      $in_parameters,
    ENamedParameters()      $out_values     = ENamedParameters,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = so e_user_prompter_extension_prompt_sync(
      $!eup,
      $dialog_name,
      $in_parameters,
      $out_values,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_user_prompter_get_type, $n, $t );
  }

  multi method prompt (
                   &callback,
    gpointer       $user_data                    = gpointer,
    Str()          :$type                        = Str,
    Str()          :$title                       = Str,
    Str()          :$primary_text                = Str,
    Str()          :$secondary_text              = Str,
    Int()          :$use_markup                  = False,
                   :captions(:@button_captions)  = (),
    GCancellable() :$cancellable                 = GCancellable,
  ) {
    samewith(
      $type,
      $title,
      $primary_text,
      $secondary_text,
      $use_markup,
      +@button_captions ?? GLib::GList.new(@button_captions, Str) !! GList,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method prompt (
    Str()          $type,
    Str()          $title,
    Str()          $primary_text,
    Str()          $secondary_text,
    Int()          $use_markup,
    GList()        $button_captions,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my gboolean $u = $use_markup.so.Int;

    e_user_prompter_prompt(
      $!eup,
      $type,
      $title,
      $primary_text,
      $secondary_text,
      $u,
      $button_captions,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method prompt_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_user_prompter_prompt_finish($!eup, $result, $error);
    set_error($error);
    $rv;
  }

  proto method prompt_sync (|)
  { * }

  multi method prompt_sync (
    CArray[Pointer[GError]] $error                       = gerror,
    Str                     :$type                       = Str,
    Str                     :$title                      = Str,
    Str                     :$primary_text               = Str,
    Str                     :$secondary_text             = Str,
    gboolean                :$use_markup                 = False,
                            :captions(:@button_captions) = (),
    GCancellable            :$cancellable                = GCancellable
  ) {
    samewith(
      $type,
      $title,
      $primary_text,
      $secondary_text,
      $use_markup,
      +@button_captions ?? GLib::GList.new(@button_captions, Str) !! GList,
      $cancellable,
      $error
    );
  }
  multi method prompt_sync (
    Str                     $type,
    Str                     $title            = Str,
    Str                     $primary_text     = Str,
    Str                     $secondary_text   = Str,
    gboolean                $use_markup       = False,
    GList                   $button_captions  = GList,
    GCancellable            $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my gboolean $u = $use_markup.so.Int;

    e_user_prompter_prompt_sync(
      $!eup,
      $type,
      $title,
      $primary_text,
      $secondary_text,
      $u,
      $button_captions,
      $cancellable,
      $error
    );
  }

}
