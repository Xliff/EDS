use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::IntervalTree;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libedata-cal/e-cal-backend-intervaltree.h

sub e_intervaltree_destroy (EIntervalTree $tree)
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_dump (EIntervalTree $tree)
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_get_type
  returns GType
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_insert (
  EIntervalTree $tree,
  time_t        $start,
  time_t        $end,
  ECalComponent $comp
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_new
  returns EIntervalTree
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_remove (
  EIntervalTree $tree,
  Str           $uid,
  Str           $rid
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_intervaltree_search (
  EIntervalTree $tree,
  time_t        $start,
  time_t        $end
)
  returns GList
  is      native(edata-cal)
  is      export
{ * }
