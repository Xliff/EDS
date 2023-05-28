use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use GTK::Raw::Types;
use Evolution::Raw::UI::WebDAV::Discover;

use GTK::Grid;
use GTK::Dialog;
use GTK::TreeSelection;
use GTK::Widget;

our subset EWebDAVDiscoverContentAncestry is export of Mu
  where EWebDAVDiscoverContent | GtkGridAncestry;

class Evolution::UI::WebDAV::Discover::Content is GTK::Grid {
  has EWebDAVDiscoverContent $!eds-wdc is implementor;

  submethod BUILD ( :$e-webdav-disc-content ) {
    self.setEWebDAVDiscoverContent($e-webdav-disc-content)
      if $e-webdav-disc-content
  }

  method setEWebDAVDiscoverContent (EWebDAVDiscoverContentAncestry $_) {
    my $to-parent;

    $!eds-wdc = do {
      when EWebDAVDiscoverContent {
        $to-parent = cast(GtkGrid, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EWebDAVDiscoverContent, $_);
      }
    }
    self.setGtkGrid($to-parent);
  }

  method Evolution::Raw::Definitions::EWebDAVDiscoverContent
  { $!eds-wdc }

  multi method new (
     $e-webdav-disc-content where * ~~ EWebDAVDiscoverContentAncestry,

    :$ref = True
  ) {
    return unless $e-webdav-disc-content;

    my $o = self.bless( :$e-webdav-disc-content );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    ECredentialsPrompter() $credentials_prompter,
    ESource()              $source,
    Str()                  $base_url,
    Int()                  $supports_filter
  ) {
    my guint $s = $supports_filter;

    my $e-webdav-disc-content = e_webdav_discover_content_new(
      $credentials_prompter,
      $source,
      $base_url,
      $s
    );

    $e-webdav-disc-content ?? self.bless( :$e-webdav-disc-content ) !! Nil;
  }

  method get_base_url is also<get-base-url> {
    e_webdav_discover_content_get_base_url($!eds-wdc);
  }

  method get_multiselect is also<get-multiselect> {
    so e_webdav_discover_content_get_multiselect($!eds-wdc);
  }

  proto method get_selected (|)
    is also<get-selected>
  { * }

  multi method get_selected (Int() $index) {
    samewith(
       $index,
       newCArray(Str),
       $,
       newCArray(Str),
       newCArray(Str),
       $,
      :all
    );
  }
  multi method get_selected (
    Int()        $index,
    CArray[Str]  $out_href,
                 $out_supports      is rw,
    CArray[Str]  $out_display_name,
    CArray[Str]  $out_color,
                 $out_order         is rw,
                :$all                      = False
  ) {
    my gint  $i        = $index;
    my gint ($os, $oo) = 0 xx 2;

    my $rv = e_webdav_discover_content_get_selected(
      $!eds-wdc,
      $i,
      $out_href,
      $os,
      $out_display_name,
      $out_color,
      $oo
    );

    ($out_supports, $out_display_name, $out_color, $out_order) =
      ($os, ppr($out_display_name), ppr($out_color), $oo);

    $all.not ?? $rv
             !! ($out_supports, $out_display_name, $out_color, $out_order)
  }

  method get_tree_selection ( :$raw = False ) is also<get-tree-selection> {
    propReturnObject(
      e_webdav_discover_content_get_tree_selection($!eds-wdc),
      $raw,
      |GTK::TreeSelection.getTypePair
    );
  }

  method get_user_address is also<get-user-address> {
    e_webdav_discover_content_get_user_address($!eds-wdc);
  }

  multi method refresh (
                    &callback,
    gpointer        $user_data           = gpointer,
    Str()          :nane(:$display_name) = Str,
    GCancellable() :$cancellable         = GCancellable
  ) {
    samewith($display_name, $cancellable, &callback, $user_data);
  }
  multi method refresh (
    Str()          $display_name,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_webdav_discover_content_refresh(
      $!eds-wdc,
      $display_name,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method refresh_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<refresh-finish>
  {
    clear_error;
    my $rv = so e_webdav_discover_content_refresh_finish(
      $!eds-wdc,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_base_url (Str() $base_url) is also<set-base-url> {
    e_webdav_discover_content_set_base_url($!eds-wdc, $base_url);
  }

  method set_multiselect (Int() $multiselect) is also<set-multiselect> {
    my gboolean $m = $multiselect.so.Int;

    e_webdav_discover_content_set_multiselect($!eds-wdc, $m);
  }

  method show_error (GError() $error) is also<show-error> {
    e_webdav_discover_content_show_error($!eds-wdc, $error);
  }

}

our subset EWebDAVDiscoverDialogAncestry is export of Mu
  where EWebDAVDiscoverDialog | GtkDialogAncestry;

class Evolution::UI::WebDAV::Discover::Dialog is GTK::Dialog {
  has EWebDAVDiscoverDialog $!eds-wdd is implementor;

  submethod BUILD ( :$e-webdav-disc-content ) {
    self.setEWebDAVDiscoverDialog($e-webdav-disc-content)
      if $e-webdav-disc-content
  }

  method setEWebDAVDiscoverDialog (EWebDAVDiscoverDialogAncestry $_) {
    my $to-parent;

    $!eds-wdd = do {
      when EWebDAVDiscoverDialog {
        $to-parent = cast(GtkGrid, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EWebDAVDiscoverDialog, $_);
      }
    }
    self.setGtkDialog($to-parent);
  }

  method Evolution::Raw::Definitions::EWebDAVDiscoverDialog
    is also<EWebDAVDiscoverDialog>
  { $!eds-wdd }

  multi method new (
     $e-webdav-disc-content where * ~~ EWebDAVDiscoverDialogAncestry,

    :$ref = True
  ) {
    return unless $e-webdav-disc-content;

    my $o = self.bless( :$e-webdav-disc-content );
    $o.ref if $ref;
    $o;
  }
  constant DEFAULT_FILTER = E_WEBDAV_DISCOVER_SUPPORTS_NONE;
  multi method new (
    ECredentialsPrompter()   $credentials_prompter,
    ESource()                $source,
    Int()                   :$supports_filter        = DEFAULT_FILTER,
    Str()                   :$title                  = 'Discovery',
    Str()                   :$base_url               = Str,
    GtkWindow()             :$parent                 = GtkWindow
  ) {
    samewith(
      $parent,
      $title,
      $credentials_prompter,
      $source,
      $base_url,
      $supports_filter
    );
  }
  multi method new (
    GtkWindow()            $parent,
    Str()                  $title,
    ECredentialsPrompter() $credentials_prompter,
    ESource()              $source,
    Str()                  $base_url,
    Int()                  $supports_filter
  ) {
    my guint $s = $supports_filter;

    my $e-webdav-disc-dialog = e_webdav_discover_dialog_new(
      $parent,
      $title,
      $credentials_prompter,
      $source,
      $base_url,
      $s
    );

    $e-webdav-disc-dialog ?? self.bless( :$e-webdav-disc-dialog ) !! Nil;
  }

  method get_content ( :$raw = False ) is also<get-content> {
    propReturnObject(
      e_webdav_discover_dialog_get_content($!eds-wdd),
      $raw,
      |Evolution::UI::WebDAV::Discover::Content.getTypePair
    );
  }

  method refresh {
    e_webdav_discover_dialog_refresh($!eds-wdd);
  }

}
