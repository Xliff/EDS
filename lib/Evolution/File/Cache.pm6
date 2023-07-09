use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::File::Cache;

use GLib::GList;

use GLib::Roles::Object;

our subset EFileCacheAncestry is export of Mu
  where EFileCache | GObject;

class Evolution::File::Cache {
  also does GLib::Roles::Object;

  has EFileCache $!efc;

  submethod BUILD (:$file-cache) {
    self.setEFileCache($file-cache) if $file-cache;
  }

  method setEFileCache (EFileCacheAncestry $_) {
    my $to-parent;

    $!efc = do {
      when EFileCache {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EFileCache, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EFileCache
    is also<EFileCache>
  { $!efc }

  multi method new (EFileCacheAncestry $file-cache, :$ref = True) {
    return Nil unless $file-cache;

    my $o = self.bless( :$file-cache );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $filename) {
    my $file-cache = e_file_cache_new($filename);

    $file-cache ?? self.bless( :$file-cache ) !! Nil;
  }

  method add_object (Str() $key, Str() $value) is also<add-object> {
    so e_file_cache_add_object($!efc, $key, $value);
  }

  method clean {
    e_file_cache_clean($!efc);
  }

  method freeze_changes is also<freeze-changes> {
    e_file_cache_freeze_changes($!efc);
  }

  method get_filename is also<get-filename> {
    e_file_cache_get_filename($!efc);
  }

  method get_keys (:$glist = False, :$raw = False) is also<get-keys> {
    returnGList(
      e_file_cache_get_keys($!efc),
      $glist,
      $raw
    );
  }

  method get_object (Str() $key) is also<get-object> {
    e_file_cache_get_object($!efc, $key);
  }

  method get_objects (:$glist = False, :$raw = False) is also<get-objects> {
    returnGList(
      e_file_cache_get_objects($!efc),
      $glist,
      $raw
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_file_cache_get_type, $n, $t )
  }

  method remove {
    so e_file_cache_remove($!efc);
  }

  method remove_object (Str() $key) is also<remove-object> {
    so e_file_cache_remove_object($!efc, $key);
  }

  method replace_object (Str() $key, Str() $new_value)
    is also<replace-object>
  {
    so e_file_cache_replace_object($!efc, $key, $new_value);
  }

  method thaw_changes is also<thaw-changes> {
    e_file_cache_thaw_changes($!efc);
  }

}
