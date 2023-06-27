use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Distro;

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

constant ecal           is export = version-by-distro('ecal');
constant ebook          is export = version-by-distro('ebook');
constant ebook-contacts is export = version-by-distro('ebook-contacts');
constant edata-cal      is export = version-by-distro('edata-cal');
constant edata-book     is export = version-by-distro('edata-book');
constant eds            is export = version-by-distro('edataserver');
constant edsui          is export = version-by-distro('edataserverui');
constant ebackend       is export = version-by-distro('ebackend');

class CamelMsgPort               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendFile           is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSqliteDB       is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSummary        is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookBackendSync           is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookQuery                 is repr<CPointer> is export does GLib::Roles::Pointers { }
class EbSdbCursor                is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookSqliteKeys            is repr<CPointer> is export does GLib::Roles::Pointers { }
class EbSqlCursor                is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarm         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalBackendWeather         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmInstance is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmRepeat   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarms        is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarmTrigger  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAttendee      is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentDateTime      is repr<CPointer> is export does GLib::Roles::Pointers { }
#class ECalComponentId            is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentOrganizer     is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentParameterBag  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPeriod        is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPrivate       is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentPropertyBag   is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentRange         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentText          is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECellRendererColor         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECertificateWidget         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECollator                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECredentialsPrompter       is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECredentialsPrompterImpl   is repr<CPointer> is export does GLib::Roles::Pointers { }
class EExtensible                is repr<CPointer> is export does GLib::Roles::Pointers { }
class EGDataQuery                is repr<CPointer> is export does GLib::Roles::Pointers { }
class EGDataSession              is repr<CPointer> is export does GLib::Roles::Pointers { }
class ENamedParameters           is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2Service             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2ServiceGoogle       is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2Support             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EPhoneNumber               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EReminderData              is repr<CPointer> is export does GLib::Roles::Pointers { }
class ERemindersWidget           is repr<CPointer> is export does GLib::Roles::Pointers { }
class ESourceWebDAVNotes         is repr<CPointer> is export does GLib::Roles::Pointers { }
class ETimezoneCache             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttribute            is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttributeParam       is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWeatherSource             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWebDAVDiscoverContent     is repr<CPointer> is export does GLib::Roles::Pointers { }
class EWebDAVDiscoverDialog      is repr<CPointer> is export does GLib::Roles::Pointers { }
class EXmlHash                   is repr<CPointer> is export does GLib::Roles::Pointers { }
class EXmlUtils                  is repr<CPointer> is export does GLib::Roles::Pointers { }

# Exceptions

class X::Evolution::VCard::AttributeVersionMismatch is Exception {
  has $.expected;
  has $.received;

  submethod BUILD (:$!expected, :$!received) { }

  method new ($expected, $received) {
    self.bless($expected, $received);
  }

  method message {
    "Encountered version {
     $!received } of an attribute when expecting version { $!expected }";
  }

}

# Global constants
constant CAMEL_FOLDER_TYPE_BIT                               is export = 10;

constant CLIENT_BACKEND_PROPERTY_CACHE_DIR                   is export =  "cache-dir";
constant CLIENT_BACKEND_PROPERTY_CAPABILITIES                is export =  "capabilities";
constant CLIENT_BACKEND_PROPERTY_ONLINE                      is export =  "online";
constant CLIENT_BACKEND_PROPERTY_OPENED                      is export =  "opened";
constant CLIENT_BACKEND_PROPERTY_OPENING                     is export =  "opening";
constant CLIENT_BACKEND_PROPERTY_READONLY                    is export =  "readonly";
constant CLIENT_BACKEND_PROPERTY_REVISION                    is export =  "revision";
constant E_BOOK_BACKEND_PROPERTY_CATEGORIES                  is export =  "categories";
constant E_BOOK_BACKEND_PROPERTY_REQUIRED_FIELDS             is export =  "required-fields";
constant E_BOOK_BACKEND_PROPERTY_REVISION                    is export =  "revision";
constant E_BOOK_BACKEND_PROPERTY_SUPPORTED_FIELDS            is export =  "supported-fields";
constant E_BOOK_SQL_IS_POPULATED_KEY                         is export =  "eds-reserved-namespace-is-populated";
constant E_BOOK_SQL_SYNC_DATA_KEY                            is export =  "eds-reserved-namespace-sync-data";
constant E_CACHE_COLUMN_OBJECT                               is export =  "ECacheOBJ";
constant E_CACHE_COLUMN_REVISION                             is export =  "ECacheREV";
constant E_CACHE_COLUMN_STATE                                is export =  "ECacheState";
constant E_CACHE_COLUMN_UID                                  is export =  "ECacheUID";
constant E_CACHE_TABLE_KEYS                                  is export =  "ECacheKeys";
constant E_CACHE_TABLE_OBJECTS                               is export =  "ECacheObjects";
constant E_CAL_BACKEND_PROPERTY_ALARM_EMAIL_ADDRESS          is export =  "alarm-email-address";
constant E_CAL_BACKEND_PROPERTY_CAL_EMAIL_ADDRESS            is export =  "cal-email-address";
constant E_CAL_BACKEND_PROPERTY_DEFAULT_OBJECT               is export =  "default-object";
constant E_CAL_BACKEND_PROPERTY_REVISION                     is export =  "revision";
constant E_CAL_EVOLUTION_ALARM_UID_PROPERTY                  is export =  "X-EVOLUTION-ALARM-UID";
constant E_CAL_EVOLUTION_ENDDATE_PARAMETER                   is export =  "X-EVOLUTION-ENDDATE";
constant E_CAL_STATIC_CAPABILITY_ALARM_DESCRIPTION           is export =  "alarm-description";
constant E_CAL_STATIC_CAPABILITY_ALL_DAY_EVENT_AS_TIME       is export =  "all-day-event-as-time";
constant E_CAL_STATIC_CAPABILITY_BULK_ADDS                   is export =  "bulk-adds";
constant E_CAL_STATIC_CAPABILITY_BULK_MODIFIES               is export =  "bulk-modifies";
constant E_CAL_STATIC_CAPABILITY_BULK_REMOVES                is export =  "bulk-removes";
constant E_CAL_STATIC_CAPABILITY_COMPONENT_COLOR             is export =  "component-color";
constant E_CAL_STATIC_CAPABILITY_CREATE_MESSAGES             is export =  "create-messages";
constant E_CAL_STATIC_CAPABILITY_DELEGATE_SUPPORTED          is export =  "delegate-support";
constant E_CAL_STATIC_CAPABILITY_DELEGATE_TO_MANY            is export =  "delegate-to-many";
constant E_CAL_STATIC_CAPABILITY_HAS_UNACCEPTED_MEETING      is export =  "has-unaccepted-meeting";
constant E_CAL_STATIC_CAPABILITY_NO_ALARM_AFTER_START        is export =  "no-alarm-after-start";
constant E_CAL_STATIC_CAPABILITY_NO_ALARM_REPEAT             is export =  "no-alarm-repeat";
constant E_CAL_STATIC_CAPABILITY_NO_AUDIO_ALARMS             is export =  "no-audio-alarms";
constant E_CAL_STATIC_CAPABILITY_NO_CONV_TO_ASSIGN_TASK      is export =  "no-conv-to-assign-task";
constant E_CAL_STATIC_CAPABILITY_NO_CONV_TO_RECUR            is export =  "no-conv-to-recur";
constant E_CAL_STATIC_CAPABILITY_NO_DISPLAY_ALARMS           is export =  "no-display-alarms";
constant E_CAL_STATIC_CAPABILITY_NO_EMAIL_ALARMS             is export =  "no-email-alarms";
constant E_CAL_STATIC_CAPABILITY_NO_GEN_OPTIONS              is export =  "no-general-options";
constant E_CAL_STATIC_CAPABILITY_NO_MEMO_START_DATE          is export =  "no-memo-start-date";
constant E_CAL_STATIC_CAPABILITY_NO_ORGANIZER                is export =  "no-organizer";
constant E_CAL_STATIC_CAPABILITY_NO_PROCEDURE_ALARMS         is export =  "no-procedure-alarms";
constant E_CAL_STATIC_CAPABILITY_NO_TASK_ASSIGNMENT          is export =  "no-task-assignment";
constant E_CAL_STATIC_CAPABILITY_NO_THISANDFUTURE            is export =  "no-thisandfuture";
constant E_CAL_STATIC_CAPABILITY_NO_THISANDPRIOR             is export =  "no-thisandprior";
constant E_CAL_STATIC_CAPABILITY_NO_TRANSPARENCY             is export =  "no-transparency";
constant E_CAL_STATIC_CAPABILITY_ONE_ALARM_ONLY              is export =  "one-alarm-only";
constant E_CAL_STATIC_CAPABILITY_ORGANIZER_MUST_ACCEPT       is export =  "organizer-must-accept";
constant E_CAL_STATIC_CAPABILITY_ORGANIZER_MUST_ATTEND       is export =  "organizer-must-attend";
constant E_CAL_STATIC_CAPABILITY_ORGANIZER_NOT_EMAIL_ADDRESS is export =  "organizer-not-email-address";
constant E_CAL_STATIC_CAPABILITY_RECURRENCES_NO_MASTER       is export =  "recurrences-no-master-object";
constant E_CAL_STATIC_CAPABILITY_REFRESH_SUPPORTED           is export =  "refresh-supported";
constant E_CAL_STATIC_CAPABILITY_REMOVE_ALARMS               is export =  "remove-alarms";
constant E_CAL_STATIC_CAPABILITY_REMOVE_ONLY_THIS            is export =  "remove-only-this";
constant E_CAL_STATIC_CAPABILITY_REQ_SEND_OPTIONS            is export =  "require-send-options";
constant E_CAL_STATIC_CAPABILITY_SAVE_SCHEDULES              is export =  "save-schedules";
constant E_CAL_STATIC_CAPABILITY_SIMPLE_MEMO                 is export =  "simple-memo";
constant E_CAL_STATIC_CAPABILITY_SIMPLE_MEMO_WITH_SUMMARY    is export =  "simple-memo-with-summary";
constant E_CAL_STATIC_CAPABILITY_TASK_CAN_RECUR              is export =  "task-can-recur";
constant E_CAL_STATIC_CAPABILITY_TASK_DATE_ONLY              is export =  "task-date-only";
constant E_CAL_STATIC_CAPABILITY_TASK_ESTIMATED_DURATION     is export =  "task-estimated-duration";
constant E_CAL_STATIC_CAPABILITY_TASK_HANDLE_RECUR           is export =  "task-handle-recur";
constant E_CAL_STATIC_CAPABILITY_TASK_NO_ALARM               is export =  "task-no-alarm";
constant E_CREDENTIALS_KEY_AUTH_METHOD                       is export =  "auth-method";
constant E_CREDENTIALS_KEY_FOREIGN_REQUEST                   is export =  "foreign-request";
constant E_CREDENTIALS_KEY_PASSWORD                          is export =  "password";
constant E_CREDENTIALS_KEY_PROMPT_FLAGS                      is export =  "prompt-flags";
constant E_CREDENTIALS_KEY_PROMPT_KEY                        is export =  "prompt-key";
constant E_CREDENTIALS_KEY_PROMPT_REASON                     is export =  "prompt-reason";
constant E_CREDENTIALS_KEY_PROMPT_TEXT                       is export =  "prompt-text";
constant E_CREDENTIALS_KEY_PROMPT_TITLE                      is export =  "prompt-title";
constant E_CREDENTIALS_KEY_USERNAME                          is export =  "username";
constant E_DEBUG_LOG_DOMAIN_CAL_QUERIES                      is export =  "CalQueries";
constant E_DEBUG_LOG_DOMAIN_GLOG                             is export =  "GLog";
constant E_DEBUG_LOG_DOMAIN_USER                             is export =  "USER";
constant E_NETWORK_MONITOR_ALWAYS_ONLINE_NAME                is export =  "always-online";
constant E_OAUTH2_SECRET_ACCESS_TOKEN                        is export =  "access_token";
constant E_OAUTH2_SECRET_EXPIRES_AFTER                       is export =  "expires_after";
constant E_OAUTH2_SECRET_REFRESH_TOKEN                       is export =  "refresh_token";
constant E_SOURCE_CREDENTIAL_PASSWORD                        is export =  "password";
constant E_SOURCE_CREDENTIAL_SSL_TRUST                       is export =  "ssl-trust";
constant E_SOURCE_CREDENTIAL_USERNAME                        is export =  "username";
constant E_SOURCE_EXTENSION_ADDRESS_BOOK                     is export =  "Address Book";
constant E_SOURCE_EXTENSION_ALARMS                           is export =  "Alarms";
constant E_SOURCE_EXTENSION_AUTHENTICATION                   is export =  "Authentication";
constant E_SOURCE_EXTENSION_AUTOCOMPLETE                     is export =  "Autocomplete";
constant E_SOURCE_EXTENSION_AUTOCONFIG                       is export =  "Autoconfig";
constant E_SOURCE_EXTENSION_BACKEND_SUMMARY_SETUP            is export =  "Backend Summary Setup";
constant E_SOURCE_EXTENSION_CALENDAR                         is export =  "Calendar";
constant E_SOURCE_EXTENSION_COLLECTION                       is export =  "Collection";
constant E_SOURCE_EXTENSION_CONTACTS_BACKEND                 is export =  "Contacts Backend";
constant E_SOURCE_EXTENSION_GOA                              is export =  "GNOME Online Accounts";
constant E_SOURCE_EXTENSION_LDAP_BACKEND                     is export =  "LDAP Backend";
constant E_SOURCE_EXTENSION_LOCAL_BACKEND                    is export =  "Local Backend";
constant E_SOURCE_EXTENSION_MAIL_ACCOUNT                     is export =  "Mail Account";
constant E_SOURCE_EXTENSION_MAIL_COMPOSITION                 is export =  "Mail Composition";
constant E_SOURCE_EXTENSION_MAIL_IDENTITY                    is export =  "Mail Identity";
constant E_SOURCE_EXTENSION_MAIL_SIGNATURE                   is export =  "Mail Signature";
constant E_SOURCE_EXTENSION_MAIL_SUBMISSION                  is export =  "Mail Submission";
constant E_SOURCE_EXTENSION_MAIL_TRANSPORT                   is export =  "Mail Transport";
constant E_SOURCE_EXTENSION_MDN                              is export =  "Message Disposition Notifications";
constant E_SOURCE_EXTENSION_MEMO_LIST                        is export =  "Memo List";
constant E_SOURCE_EXTENSION_OFFLINE                          is export =  "Offline";
constant E_SOURCE_EXTENSION_OPENPGP                          is export =  "Pretty Good Privacy (OpenPGP)";
constant E_SOURCE_EXTENSION_PROXY                            is export =  "Proxy";
constant E_SOURCE_EXTENSION_REFRESH                          is export =  "Refresh";
constant E_SOURCE_EXTENSION_RESOURCE                         is export =  "Resource";
constant E_SOURCE_EXTENSION_REVISION_GUARDS                  is export =  "Revision Guards";
constant E_SOURCE_EXTENSION_SECURITY                         is export =  "Security";
constant E_SOURCE_EXTENSION_SMIME                            is export =  "Secure MIME (S/MIME)";
constant E_SOURCE_EXTENSION_TASK_LIST                        is export =  "Task List";
constant E_SOURCE_EXTENSION_UOA                              is export =  "Ubuntu Online Accounts";
constant E_SOURCE_EXTENSION_WEATHER_BACKEND                  is export =  "Weather Backend";
constant E_SOURCE_EXTENSION_WEBDAV_BACKEND                   is export =  "WebDAV Backend";
constant E_SOURCE_EXTENSION_WEBDAV_NOTES                     is export =  "WebDAV Notes";
constant E_WEBDAV_CAPABILITY_ACCESS_CONTROL                  is export =  "access-control";
constant E_WEBDAV_CAPABILITY_ADDRESSBOOK                     is export =  "addressbook";
constant E_WEBDAV_CAPABILITY_BIND                            is export =  "bind";
constant E_WEBDAV_CAPABILITY_CALENDAR_ACCESS                 is export =  "calendar-access";
constant E_WEBDAV_CAPABILITY_CALENDAR_AUTO_SCHEDULE          is export =  "calendar-auto-schedule";
constant E_WEBDAV_CAPABILITY_CALENDAR_PROXY                  is export =  "calendar-proxy";
constant E_WEBDAV_CAPABILITY_CALENDAR_SCHEDULE               is export =  "calendar-schedule";
constant E_WEBDAV_CAPABILITY_CLASS_1                         is export =  "1";
constant E_WEBDAV_CAPABILITY_CLASS_2                         is export =  "2";
constant E_WEBDAV_CAPABILITY_CLASS_3                         is export =  "3";
constant E_WEBDAV_CAPABILITY_EXTENDED_MKCOL                  is export =  "extended-mkcol";
constant E_WEBDAV_COLLATION_ASCII_CASEMAP_SUFFIX             is export =  "ascii-casemap";
constant E_WEBDAV_COLLATION_ASCII_NUMERIC_SUFFIX             is export =  "ascii-numeric";
constant E_WEBDAV_COLLATION_UNICODE_CASEMAP_SUFFIX           is export =  "unicode-casemap";
constant E_WEBDAV_COLLATION_OCTET_SUFFIX                     is export =  "octet";
constant E_WEBDAV_COLLATION_ASCII_CASEMAP                    is export =  "i;" ~ E_WEBDAV_COLLATION_ASCII_CASEMAP_SUFFIX;
constant E_WEBDAV_COLLATION_ASCII_NUMERIC                    is export =  "i;" ~ E_WEBDAV_COLLATION_ASCII_NUMERIC_SUFFIX;
constant E_WEBDAV_COLLATION_OCTET                            is export =  "i;" ~ E_WEBDAV_COLLATION_OCTET_SUFFIX;
constant E_WEBDAV_COLLATION_UNICODE_CASEMAP                  is export =  "i;" ~ E_WEBDAV_COLLATION_UNICODE_CASEMAP_SUFFIX;
constant E_WEBDAV_CONTENT_TYPE_CALENDAR                      is export =  "text/calendar; charset=\"utf-8\"";
constant E_WEBDAV_CONTENT_TYPE_VCARD                         is export =  "text/vcard; charset=\"utf-8\"";
constant E_WEBDAV_CONTENT_TYPE_XML                           is export =  "application/xml; charset=\"utf-8\"";
constant E_WEBDAV_DEPTH_INFINITY                             is export =  "infinity";
constant E_WEBDAV_DEPTH_THIS                                 is export =  "0";
constant E_WEBDAV_DEPTH_THIS_AND_CHILDREN                    is export =  "1";
constant E_WEBDAV_NS_CALDAV                                  is export =  "urn:ietf:params:xml:ns:caldav";
constant E_WEBDAV_NS_CALENDARSERVER                          is export =  "http://calendarserver.org/ns/";
constant E_WEBDAV_NS_CARDDAV                                 is export =  "urn:ietf:params:xml:ns:carddav";
constant E_WEBDAV_NS_DAV                                     is export =  "DAV:";
constant E_WEBDAV_NS_ICAL                                    is export =  "http://apple.com/ns/ical/";
constant EDS_ADDRESS_BOOK_MODULES                            is export =  "EDS_ADDRESS_BOOK_MODULES";
constant EDS_CALENDAR_MODULES                                is export =  "EDS_CALENDAR_MODULES";
constant EDS_REGISTRY_MODULES                                is export =  "EDS_REGISTRY_MODULES";
constant EDS_SUBPROCESS_BOOK_PATH                            is export =  "EDS_SUBPROCESS_BOOK_PATH";
constant EDS_SUBPROCESS_CAL_PATH                             is export =  "EDS_SUBPROCESS_CAL_PATH";
constant EVC_ADR                                             is export =  "ADR";
constant EVC_BDAY                                            is export =  "BDAY";
constant EVC_CALURI                                          is export =  "CALURI";
constant EVC_CATEGORIES                                      is export =  "CATEGORIES";
constant EVC_CL_UID                                          is export =  "X-EVOLUTION-CONTACT-LIST-UID";
constant EVC_CONTACT_LIST                                    is export =  "X-EVOLUTION-CONTACT-LIST-INFO";
constant EVC_EMAIL                                           is export =  "EMAIL";
constant EVC_ENCODING                                        is export =  "ENCODING";
constant EVC_FBURL                                           is export =  "FBURL";
constant EVC_FN                                              is export =  "FN";
constant EVC_GEO                                             is export =  "GEO";
constant EVC_ICSCALENDAR                                     is export =  "ICSCALENDAR";
constant EVC_KEY                                             is export =  "KEY";
constant EVC_LABEL                                           is export =  "LABEL";
constant EVC_LOGO                                            is export =  "LOGO";
constant EVC_MAILER                                          is export =  "MAILER";
constant EVC_N                                               is export =  "N";
constant EVC_NICKNAME                                        is export =  "NICKNAME";
constant EVC_NOTE                                            is export =  "NOTE";
constant EVC_ORG                                             is export =  "ORG";
constant EVC_PARENT_CL                                       is export =  "X-EVOLUTION-PARENT-UID";
constant EVC_PHOTO                                           is export =  "PHOTO";
constant EVC_PRODID                                          is export =  "PRODID";
constant EVC_QUOTEDPRINTABLE                                 is export =  "QUOTED-PRINTABLE";
constant EVC_REV                                             is export =  "REV";
constant EVC_ROLE                                            is export =  "ROLE";
constant EVC_TEL                                             is export =  "TEL";
constant EVC_TITLE                                           is export =  "TITLE";
constant EVC_TYPE                                            is export =  "TYPE";
constant EVC_UID                                             is export =  "UID";
constant EVC_URL                                             is export =  "URL";
constant EVC_VALUE                                           is export =  "VALUE";
constant EVC_VERSION                                         is export =  "VERSION";
constant EVC_X_AIM                                           is export =  "X-AIM";
constant EVC_X_ANNIVERSARY                                   is export =  "X-EVOLUTION-ANNIVERSARY";
constant EVC_X_ASSISTANT                                     is export =  "X-EVOLUTION-ASSISTANT";
constant EVC_X_BIRTHDAY                                      is export =  "X-EVOLUTION-BIRTHDAY";
constant EVC_X_BLOG_URL                                      is export =  "X-EVOLUTION-BLOG-URL";
constant EVC_X_BOOK_UID                                      is export =  "X-EVOLUTION-BOOK-UID";
constant EVC_X_CALLBACK                                      is export =  "X-EVOLUTION-CALLBACK";
constant EVC_X_COMPANY                                       is export =  "X-EVOLUTION-COMPANY";
constant EVC_X_DEST_CONTACT_UID                              is export =  "X-EVOLUTION-DEST-CONTACT-UID";
constant EVC_X_DEST_EMAIL                                    is export =  "X-EVOLUTION-DEST-EMAIL";
constant EVC_X_DEST_EMAIL_NUM                                is export =  "X-EVOLUTION-DEST-EMAIL-NUM";
constant EVC_X_DEST_HTML_MAIL                                is export =  "X-EVOLUTION-DEST-HTML-MAIL";
constant EVC_X_DEST_NAME                                     is export =  "X-EVOLUTION-DEST-NAME";
constant EVC_X_DEST_SOURCE_UID                               is export =  "X-EVOLUTION-DEST-SOURCE-UID";
constant EVC_X_E164                                          is export =  "X-EVOLUTION-E164";
constant EVC_X_FILE_AS                                       is export =  "X-EVOLUTION-FILE-AS";
constant EVC_X_GADUGADU                                      is export =  "X-GADUGADU";
constant EVC_X_GOOGLE_TALK                                   is export =  "X-GOOGLE-TALK";
constant EVC_X_GROUPWISE                                     is export =  "X-GROUPWISE";
constant EVC_X_ICQ                                           is export =  "X-ICQ";
constant EVC_X_JABBER                                        is export =  "X-JABBER";
constant EVC_X_LIST                                          is export =  "X-EVOLUTION-LIST";
constant EVC_X_LIST_NAME                                     is export =  "X-EVOLUTION-LIST-NAME";
constant EVC_X_LIST_SHOW_ADDRESSES                           is export =  "X-EVOLUTION-LIST-SHOW-ADDRESSES";
constant EVC_X_MANAGER                                       is export =  "X-EVOLUTION-MANAGER";
constant EVC_X_MATRIX                                        is export =  "X-MATRIX";
constant EVC_X_MSN                                           is export =  "X-MSN";
constant EVC_X_RADIO                                         is export =  "X-EVOLUTION-RADIO";
constant EVC_X_SIP                                           is export =  "X-SIP";
constant EVC_X_SKYPE                                         is export =  "X-SKYPE";
constant EVC_X_SPOUSE                                        is export =  "X-EVOLUTION-SPOUSE";
constant EVC_X_TELEX                                         is export =  "X-EVOLUTION-TELEX";
constant EVC_X_TTYTDD                                        is export =  "X-EVOLUTION-TTYTDD";
constant EVC_X_TWITTER                                       is export =  "X-TWITTER";
constant EVC_X_VIDEO_URL                                     is export =  "X-EVOLUTION-VIDEO-URL";
constant EVC_X_WANTS_HTML                                    is export =  "X-MOZILLA-HTML";
constant EVC_X_YAHOO                                         is export =  "X-YAHOO";

sub e-test-utils is export {
  state $libname = do {
    my ($arch, $os, $ext) = resources-info;
    my $libkey = "lib/{ $arch }/{ $os }/e-test-utils.{ $ext }";
    say "Using '$libkey' as tree support library." if $DEBUG;
    $libname = %?RESOURCES{$libkey}.absolute;
  }

  $libname;
}

# BEGIN {
#   constant e-test-utils is export = e-test-utils-location;
# }
