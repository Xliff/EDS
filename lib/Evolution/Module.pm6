use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use GLib::GList;
use GLib::Object::TypeModule;

# cw: In the future, where much of the ancestry logic is done by RakuAST,
#     there will need to be a duplication of data to properly capture
#     the type ancestries so that they can be used. As of this writing,
#     you cannot extract the types from a subset, so an array containing
#     the same information will be required.

our subset EModuleAncestry is export of Mu
  where EModule | GTypeModuleAncestry;

class Evolution::Module is GLib::Object::TypeModule {
  has EModule $!em is implementor;

  submethod BUILD (:$emodule) {
    self.setEModule($emodule) if $emodule;
  }

  method setEModule (EModuleAncestry $_) {
    my $to-parent;

    $!em = do {
      when EModule {
        $to-parent = cast(GTypeModule, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EModule, $_);
      }
    }
    self.setGTypeModule($to-parent);
  }

  method Evolution::Raw::Definitions::EModule
  { $!em }

  multi method new (EModuleAncestry $emodule, :$ref = True) {
    return Nil unless $emodule;

    my $o = self.bless( :$emodule );
    $o.ref if $ref;
    $o;
  }
  multi method new (Evolution::Module:U: Str() $filename) {
    my $emodule = e_module_new($filename);

    $emodule ?? self.bless( :$emodule ) !! Nil;
  }
  multi method new (
    Evolution::Module:U:

    Str() $filename,

    :from_file(
      :from-file(:$file)
    ) is required
  ) {
    Evolution::Module.load_file($filename);
  }
  method load_file (Evolution::Module:U: Str() $filename) {
    my $emodule = e_module_load_file($filename);

    $emodule ?? self.bless( :$emodule ) !! Nil;
  }

  method get_filename {
    e_module_get_filename($!em);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_module_get_type, $n, $t );
  }

  method load_all_in_directory (
    Evolution::Module:U:

    Str() $dirname,
          :$glist   = False,
          :$raw     = False
  ) {
    returnGList(
      e_module_load_all_in_directory($dirname),
      $glist,
      $raw,
      EModule,
      Evolution::Module
    )
  }


}

### /usr/include/evolution-data-server/libedataserver/e-module.h

sub e_module_get_filename (EModule $module)
  returns Str
  is native(eds)
  is export
{ * }

sub e_module_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_module_load_all_in_directory (Str $dirname)
  returns GList
  is native(eds)
  is export
{ * }

sub e_module_load_file (Str $filename)
  returns EModule
  is native(eds)
  is export
{ * }

sub e_module_new (Str $filename)
  returns EModule
  is native(eds)
  is export
{ * }
