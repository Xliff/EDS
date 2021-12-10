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
constant ebackend       is export = version-by-distro('ebackend');

class CamelMsgPort               is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookQuery                 is repr<CPointer> is export does GLib::Roles::Pointers { }
class EBookSqlCursor             is repr<CPointer> is export does GLib::Roles::Pointers { }
class ECalComponentAlarm         is repr<CPointer> is export does GLib::Roles::Pointers { }
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
class ECollator                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class EExtensible                is repr<CPointer> is export does GLib::Roles::Pointers { }
class ENamedParameters           is repr<CPointer> is export does GLib::Roles::Pointers { }
class EOAuth2Service             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EPhoneNumber               is repr<CPointer> is export does GLib::Roles::Pointers { }
class ETimezoneCache             is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttribute            is repr<CPointer> is export does GLib::Roles::Pointers { }
class EVCardAttributeParam       is repr<CPointer> is export does GLib::Roles::Pointers { }

constant CAMEL_FOLDER_TYPE_BIT               is export = 10;

constant E_OAUTH2_SECRET_REFRESH_TOKEN       is export = 'refresh_token';
constant E_OAUTH2_SECRET_ACCESS_TOKEN        is export = 'access_token';
constant E_OAUTH2_SECRET_EXPIRES_AFTER       is export = 'expires_after';

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
constant EVC_ADR                   = 'ADR';
constant EVC_BDAY                  = 'BDAY';
constant EVC_CALURI                = 'CALURI';
constant EVC_CATEGORIES            = 'CATEGORIES';
constant EVC_EMAIL                 = 'EMAIL';
constant EVC_ENCODING              = 'ENCODING';
constant EVC_FBURL                 = 'FBURL';
constant EVC_FN                    = 'FN';
constant EVC_GEO                   = 'GEO';
constant EVC_ICSCALENDAR           = 'ICSCALENDAR';
constant EVC_KEY                   = 'KEY';
constant EVC_LABEL                 = 'LABEL';
constant EVC_LOGO                  = 'LOGO';
constant EVC_MAILER                = 'MAILER';
constant EVC_NICKNAME              = 'NICKNAME';
constant EVC_N                     = 'N';
constant EVC_NOTE                  = 'NOTE';
constant EVC_ORG                   = 'ORG';
constant EVC_PHOTO                 = 'PHOTO';
constant EVC_PRODID                = 'PRODID';
constant EVC_QUOTEDPRINTABLE       = 'QUOTED-PRINTABLE';
constant EVC_REV                   = 'REV';
constant EVC_ROLE                  = 'ROLE';
constant EVC_TEL                   = 'TEL';
constant EVC_TITLE                 = 'TITLE';
constant EVC_TYPE                  = 'TYPE';
constant EVC_UID                   = 'UID';
constant EVC_URL                   = 'URL';
constant EVC_VALUE                 = 'VALUE';
constant EVC_VERSION               = 'VERSION';
constant EVC_X_AIM                 = 'X-AIM';
constant EVC_X_ANNIVERSARY         = 'X-EVOLUTION-ANNIVERSARY';
constant EVC_X_ASSISTANT           = 'X-EVOLUTION-ASSISTANT';
constant EVC_X_BIRTHDAY            = 'X-EVOLUTION-BIRTHDAY';
constant EVC_X_BLOG_URL            = 'X-EVOLUTION-BLOG-URL';
constant EVC_X_CALLBACK            = 'X-EVOLUTION-CALLBACK';
constant EVC_X_COMPANY             = 'X-EVOLUTION-COMPANY';
constant EVC_X_DEST_CONTACT_UID    = 'X-EVOLUTION-DEST-CONTACT-UID';
constant EVC_X_DEST_EMAIL_NUM      = 'X-EVOLUTION-DEST-EMAIL-NUM';
constant EVC_X_DEST_HTML_MAIL      = 'X-EVOLUTION-DEST-HTML-MAIL';
constant EVC_X_DEST_SOURCE_UID     = 'X-EVOLUTION-DEST-SOURCE-UID';
constant EVC_X_E164                = 'X-EVOLUTION-E164';
constant EVC_X_FILE_AS             = 'X-EVOLUTION-FILE-AS';
constant EVC_X_GADUGADU            = 'X-GADUGADU';
constant EVC_X_GROUPWISE           = 'X-GROUPWISE';
constant EVC_X_ICQ                 = 'X-ICQ';
constant EVC_X_JABBER              = 'X-JABBER';
constant EVC_X_LIST_SHOW_ADDRESSES = 'X-EVOLUTION-LIST-SHOW-ADDRESSES';
constant EVC_X_LIST                = 'X-EVOLUTION-LIST';
constant EVC_X_LIST_NAME           = 'X-EVOLUTION-LIST-NAME';
constant EVC_X_MANAGER             = 'X-EVOLUTION-MANAGER';
constant EVC_X_MSN                 = 'X-MSN';
constant EVC_X_RADIO               = 'X-EVOLUTION-RADIO';
constant EVC_X_SKYPE               = 'X-SKYPE';
constant EVC_X_GOOGLE_TALK         = 'X-GOOGLE-TALK';
constant EVC_X_TWITTER             = 'X-TWITTER';
constant EVC_X_SIP                 = 'X-SIP';
constant EVC_X_SPOUSE              = 'X-EVOLUTION-SPOUSE';
constant EVC_X_TELEX               = 'X-EVOLUTION-TELEX';
constant EVC_X_TTYTDD              = 'X-EVOLUTION-TTYTDD';
constant EVC_X_VIDEO_URL           = 'X-EVOLUTION-VIDEO-URL';
constant EVC_X_WANTS_HTML          = 'X-MOZILLA-HTML';
constant EVC_X_YAHOO               = 'X-YAHOO';
constant EVC_X_BOOK_UID            = 'X-EVOLUTION-BOOK-UID';
constant EVC_CONTACT_LIST          = 'X-EVOLUTION-CONTACT-LIST-INFO';
constant EVC_PARENT_CL             = 'X-EVOLUTION-PARENT-UID';
constant EVC_CL_UID                = 'X-EVOLUTION-CONTACT-LIST-UID';
constant EVC_X_DEST_EMAIL          = 'X-EVOLUTION-DEST-EMAIL';
constant EVC_X_DEST_NAME           = 'X-EVOLUTION-DEST-NAME';

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
