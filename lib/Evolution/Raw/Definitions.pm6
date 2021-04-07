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

class CamelMsgPort  is repr<CPointer>    is export does GLib::Roles::Pointers { }
class ENamedParameters is repr<CPointer> is export does GLib::Roles::Pointers { }

constant CAMEL_FOLDER_TYPE_BIT               is export = 10;

constant E_OAUTH2_SECRET_REFRESH_TOKEN       is export = 'refresh_token';
constant E_OAUTH2_SECRET_ACCESS_TOKEN        is export = 'access_token';
constant E_OAUTH2_SECRET_EXPIRES_AFTER       is export = 'expires_after';

constant E_SOURCE_EXTENSION_ADDRESS_BOOK     is export = 'Address Book';
constant E_SOURCE_EXTENSION_ALARMS           is export = 'Alarms';
constant E_SOURCE_EXTENSION_AUTHENTICATION   is export = 'Authentication';
constant E_SOURCE_EXTENSION_AUTOCOMPLETE     is export = 'Autocomplete';
constant E_SOURCE_EXTENSION_AUTOCONFIG       is export = 'Autoconfig';
constant E_SOURCE_EXTENSION_CALENDAR         is export = 'Calendar';
constant E_SOURCE_EXTENSION_COLLECTION       is export = 'Collection';
constant E_SOURCE_EXTENSION_CONTACTS_BACKEND is export = 'Contacts Backend';
constant E_SOURCE_EXTENSION_GOA              is export = 'GNOME Online Accounts';
constant E_SOURCE_EXTENSION_LDAP_BACKEND     is export = 'LDAP Backend';
constant E_SOURCE_EXTENSION_LOCAL_BACKEND    is export = 'Local Backend';
constant E_SOURCE_EXTENSION_MAIL_ACCOUNT     is export = 'Mail Account';
constant E_SOURCE_EXTENSION_MAIL_COMPOSITION is export = 'Mail Composition';
constant E_SOURCE_EXTENSION_MAIL_IDENTITY    is export = 'Mail Identity';
constant E_SOURCE_EXTENSION_MAIL_SIGNATURE   is export = 'Mail Signature';
constant E_SOURCE_EXTENSION_MAIL_SUBMISSION  is export = 'Mail Submission';
constant E_SOURCE_EXTENSION_MAIL_TRANSPORT   is export = 'Mail Transport';
constant E_SOURCE_EXTENSION_MDN              is export = 'Message Disposition Notifications';
constant E_SOURCE_EXTENSION_MEMO_LIST        is export = 'Memo List';
constant E_SOURCE_EXTENSION_OFFLINE          is export = 'Offline';
constant E_SOURCE_EXTENSION_OPENPGP          is export = 'Pretty Good Privacy (OpenPGP)';
constant E_SOURCE_EXTENSION_PROXY            is export = 'Proxy';
constant E_SOURCE_EXTENSION_REFRESH          is export = 'Refresh';
constant E_SOURCE_EXTENSION_RESOURCE         is export = 'Resource';
constant E_SOURCE_EXTENSION_REVISION_GUARDS  is export = 'Revision Guards';
constant E_SOURCE_EXTENSION_SECURITY         is export = 'Security';
constant E_SOURCE_EXTENSION_SMIME            is export = 'Secure MIME (S/MIME)';
constant E_SOURCE_EXTENSION_TASK_LIST        is export = 'Task List';
constant E_SOURCE_EXTENSION_UOA              is export = 'Ubuntu Online Accounts';
constant E_SOURCE_EXTENSION_WEATHER_BACKEND  is export = 'Weather Backend';
constant E_SOURCE_EXTENSION_WEBDAV_BACKEND   is export = 'WebDAV Backend';
