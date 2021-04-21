use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package Evolution::Raw::Definitions;

constant forced = 0;

constant camel_block_t is export := guint32;
constant camel_hash_t  is export := guint32;
constant camel_key_t   is export := guint32;

constant CamelCipherCloneFunc      is export := Pointer;    # gpointer (* CamelCipherCloneFunc) (gpointer value)
constant CamelIndexNorm            is export := Pointer;    # gchar * (*CamelIndexNorm)(CamelIndex *index, const gchar *word, gpointer user_data);
constant EFreeFormExpBuildSexpFunc is export := Pointer;
constant EListCopyFunc             is export := Pointer;
constant EListFreeFunc             is export := Pointer;

constant ecal is export = 'ecal-2.0',v1;
constant eds  is export = 'edataserver-1.2',v25;

class CamelMsgPort               is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarm         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmInstance is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmRepeat   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarms        is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmTrigger  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAttendee      is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentDateTime      is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentId            is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentOrganizer     is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentParameterBag  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPeriod        is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPrivate       is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPropertyBag   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentRange         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentText          is repr<CPointer> is export does GLib::Roles::Pointers { }
class ENamedParameters           is repr<CPointer> is export does GLib::Roles::Pointers { }

constant CAMEL_FOLDER_TYPE_BIT               is export = 10;

constant E_OAUTH2_SECRET_REFRESH_TOKEN       is export = 'refresh_token';
constant E_OAUTH2_SECRET_ACCESS_TOKEN        is export = 'access_token';
constant E_OAUTH2_SECRET_EXPIRES_AFTER       is export = 'expires_after';
