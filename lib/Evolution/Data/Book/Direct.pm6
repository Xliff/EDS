use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Roles::Object;

our subset EDataBookDirectAncestry is export of Mu
  where EDataBookDirect | GObject;

class Evolution::Data::Book::Direct {
  also does GLib::Roles::Object;

  has EDataBookDirect $!edbd is implementor;

  submethod BUILD ( :$e-data-book-direct ) {
    self.setEDataBookDirect($e-data-book-direct) if $e-data-book-direct;
  }

  method setEDataBookDirect (EDataBookDirectAncestry $_) {
    my $to-parent;

    $!edbd = do {
      when EDataBookDirect {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataBookDirect, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EDataBookDirect
    is also<EDataBookDirect>
  { $!edbd }

  multi method new (EDataBookDirectAncestry $e-data-book-direct, :$ref = True) {
    return Nil unless $e-data-book-direct;

    my $o = self.bless( :$e-data-book-direct );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $backend_path,
    Str() $backend_factory_name,
    Str() $config
  ) {
    my $e-data-book-direct = e_data_book_direct_new(
      $backend_path,
      $backend_factory_name,
      $config
    );

    $e-data-book-direct ?? self.bless( :$e-data-book-direct ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_book_direct_get_type, $n, $t );
  }

  method register_gdbus_object (
    GDBusConnection()       $connection,
    Str()                   $object_path,
    CArray[Pointer[GError]] $error
  )
    is also<register-gdbus-object>
  {
    clear_error;
    my $rv = e_data_book_direct_register_gdbus_object(
      $!edbd,
      $connection,
      $object_path,
      $error
    );
    set_error($error);
    $rv.so;
  }

}


### /usr/include/evolution-data-server/libedata-book/e-data-book-direct.h

sub e_data_book_direct_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_data_book_direct_new (
  Str $backend_path,
  Str $backend_factory_name,
  Str $config
)
  returns EDataBookDirect
  is native(edata-book)
  is export
{ * }

sub e_data_book_direct_register_gdbus_object (
  EDataBookDirect         $direct,
  GDBusConnection         $connection,
  Str                     $object_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }
