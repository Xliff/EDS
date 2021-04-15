use v6.c;

use NativeCall;
use NativeHelpers::Blob;

use Evolution::Raw::Types;
use Evolution::Raw::Source::MailSignature;

use Evolution::Source::Extension;

our subset ESourceMailSignatureAncestry is export of Mu
  where ESourceMailSignature | ESourceExtensionAncestry;

class Evolution::Source::MailSignature is Evolution::Source::Extension {
  has ESourceMailSignature $!ess;

  submethod BUILD (:$mail-signature) {
    self.setESourceMailSignature($mail-signature) if $mail-signature;
  }

  method setESourceMailSignature (ESourceMailSignatureAncestry $_) {
    my $to-parent;

    $!ess = do {
      when ESourceMailSignature {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailSignature, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailSignature
  { $!ess }

  method new (
    ESourceMailSignatureAncestry $mail-signature,
                                :$ref           = True
  ) {
    return Nil unless $mail-signature;

    my $o = self.bless( :$mail-signature );
    $o.ref if $ref;
    $o;
  }

  method dup_mime_type {
    e_source_mail_signature_dup_mime_type($!ess);
  }

  method get_file {
    e_source_mail_signature_get_file($!ess);
  }

  method get_mime_type {
    e_source_mail_signature_get_mime_type($!ess);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_signature_get_type,
      $n,
      $t
     )
  }

  multi method load (
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$io_priority = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method load (
    Int()          $io_priority,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    my gint $i = $io_priority;

    e_source_mail_signature_load(
      $!ess,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method load_finish (|)
  { * }

  multi method load_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    =  gerror
  ) {
    my $rv = samewith($result, $, $, $error, :all);

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method load_finish (
    GAsyncResult()          $result,
                            $contents is rw,
                            $length   is rw,
    CArray[Pointer[GError]] $error    =  gerror,
                            :$all     =  False
  ) {
    my gsize $l = $length;

    ($contents = CArray[Str].new)[0] = Str unless $contents;

    clear_error;
    my $rv = e_source_mail_signature_load_finish(
      $!ess,
      $result,
      $contents,
      $l,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($contents) , $length = $l )
  }

  method load_sync (
    Str()                   $contents,
    Int()                   $length,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gsize $l = $length;

    clear_error;
    my $rv = e_source_mail_signature_load_sync(
      $!ess,
      $contents,
      $l,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  multi method replace (
    Str()          $contents,
                   &callback,
    gpointer       $user_data     =  gpointer,
                   :string(:$str) is required,
                   :$encoding     =  'utf8',
                   :$length,
    gint           :$io_priority  =  G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable  =  GCancellable
  ) {
    samewith(
      $contents.encode($encoding),
      &callback,
      $user_data,
      :$length,
      :$io_priority,
      :$cancellable
    );
  }
  multi method replace (
    Buf()          $contents,
                   &callback,
    gpointer       $user_data    =  gpointer,
                   :$buf         is required,
    gint           :$io_priority =  G_PRIORITY_DEFAULT,
    Int()          :$length      =  $contents.bytes,
    GCancellable() :$cancellable =  GCancellable
  ) {
    samewith(
      pointer-to($contents),
      $contents.bytes,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method replace (
    CArray[uint8]  $contents,
                   &callback,
    gpointer       $user_data    =  gpointer,
    gint           :$io_priority =  G_PRIORITY_DEFAULT,
    Int()          :$length,
    GCancellable() :$cancellable =  GCancellable
  ) {
    my $l = $length;
       $l = $contents.elems unless $l;

    samewith(
      pointer-to($contents),
      $l,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method replace (
    Pointer        $contents,
    Int()          $length,
    gint           $io_priority,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    my gsize $l = $length;

    e_source_mail_signature_replace(
      $!ess,
      $contents,
      $length,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method replace_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = e_source_mail_signature_replace_finish($!ess, $result, $error);
    set_error($error);
    $rv;
  }

  method replace_sync (
    Str()                   $contents,
    Int()                   $length,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gsize $l = $length;

    e_source_mail_signature_replace_sync(
      $!ess,
      $contents,
      $l,
      $cancellable,
      $error
    );
  }

  method set_mime_type (Str() $mime_type) {
    e_source_mail_signature_set_mime_type($!ess, $mime_type);
  }

  multi method symlink (
    Str()        $symlink_target,
                 &callback,
    gpointer     $user_data       = gpointer,
    gint         :$io_priority    = G_PRIORITY_DEFAULT,
    GCancellable :$cancellable    = GCancellable
  ) {
    samewith(
      $symlink_target,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method symlink (
    Str()          $symlink_target,
    Int()          $io_priority,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data       = gpointer
  ) {
    my gint $i = $io_priority;

    e_source_mail_signature_symlink(
      $!ess,
      $symlink_target,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method symlink_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    e_source_mail_signature_symlink_finish($!ess, $result, $error);
  }

  method symlink_sync (
    Str()                   $symlink_target,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    e_source_mail_signature_symlink_sync(
      $!ess,
      $symlink_target,
      $cancellable,
      $error
    );
  }

}
