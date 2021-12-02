use v6.c;

use GTK::Builder::Registry;

class Cursor::Builder::Registry is GTK::Builder::Registry {

  # Where is the constructor for the static class?
  method typeClass {
    (
      CursorSlot      => 'Cursor::Slot',
      CursorExample   => 'Cursor::Example',
      CursorSearch    => 'Cursor::Search',
      CursorNavigator => 'Cursor::Navigator'
    ).Map;
  }

}
