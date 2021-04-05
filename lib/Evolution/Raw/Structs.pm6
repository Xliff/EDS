use v6.c;

use NativeCall;

use GLib::Compat::Definitions;
use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GLib::Class::TypeModule;
use GIO::Raw::Definitions;
use SOUP::Raw::Definitions;
use SOUP::Class::Auth;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

use GLib::Class::Object;

unit package Evolution::Raw::Structs;

class CamelAddress is repr<CStruct> is export {
	HAS GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelBlockFile is repr<CStruct> is export {
	HAS GObject               $!parent;
	has Pointer $!priv  ;
}

class CamelBlockRoot is repr<CStruct> is export {
	has Str         $!version   ;
	has guint32       $!flags     ;
	has guint32       $!block_size;
	has camel_block_t $!free      ;
	has camel_block_t $!last      ;
}

class CamelCertDB is repr<CStruct> is export {
	HAS GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelCharset is repr<CStruct> is export {
	has guint $!mask ;
	has gint  $!level;
}

class CamelCipherCertInfo is repr<CStruct> is export {
	has Str                $!name           ;
	has Str                $!email          ;
	has gpointer             $!cert_data      ;
	has GDestroyNotify       $!cert_data_free ;
	has CamelCipherCloneFunc $!cert_data_clone;
	has GSList               $!properties     ;
}

class CamelCipherCertInfoProperty is repr<CStruct> is export {
	has Str                $!name       ;
	has gpointer             $!value      ;
	has GDestroyNotify       $!value_free ;
	has CamelCipherCloneFunc $!value_clone;
}

class CamelCipherContext is repr<CStruct> is export {
	HAS GObject                   $!parent;
	has Pointer $!priv  ;
}

class camel_header_param is repr<CStruct> is export {
	has camel_header_param $!next ;
	has Str                $!name ;
	has Str                $!value;
}

class CamelContentDisposition is repr<CStruct> is export {
	has Str                 $!disposition;
	has camel_header_param  $!params     ;
	has guint               $!refcount   ;
}

class CamelDB is repr<CStruct> is export {
	HAS GObject        $!parent;
	has Pointer $!priv  ;
}

class CamelDataCache is repr<CStruct> is export {
	HAS GObject               $!parent;
	has Pointer $!priv  ;
}

class CamelDataWrapper is repr<CStruct> is export {
	HAS GObject                 $!parent;
	has Pointer $!priv  ;
}

class CamelFIRecord is repr<CStruct> is export {
	has Str   $!folder_name  ;
	has guint32 $!version      ;
	has guint32 $!flags        ;
	has guint32 $!nextuid      ;
	has gint64  $!timestamp    ;
	has guint32 $!saved_count  ;
	has guint32 $!unread_count ;
	has guint32 $!deleted_count;
	has guint32 $!junk_count   ;
	has guint32 $!visible_count;
	has guint32 $!jnd_count    ;
	has Str   $!bdata        ;
}

class CamelFilterDriver is repr<CStruct> is export {
	HAS GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelFilterInputStream is repr<CStruct> is export {
	HAS GFilterInputStream            $!parent;
	has Pointer $!priv  ;
}

class CamelFilterOutputStream is repr<CStruct> is export {
	HAS GFilterOutputStream            $!parent;
	has Pointer $!priv  ;
}

class CamelObject is repr<CStruct> is export {
	HAS GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelFolder is repr<CStruct> is export {
	HAS CamelObject        $!parent;
	has Pointer $!priv  ;
}

class CamelFolderChangeInfo is repr<CStruct> is export {
	has GPtrArray                    $!uid_added  ;
	has GPtrArray                    $!uid_removed;
	has GPtrArray                    $!uid_changed;
	has GPtrArray                    $!uid_recent ;
	has Pointer $!priv       ;
}

class CamelFolderInfo is repr<CStruct> is export {
	has CamelFolderInfo      $!next        ;
	has CamelFolderInfo      $!parent      ;
	has CamelFolderInfo      $!child       ;
	has Str                  $!full_name   ;
	has Str                  $!display_name;
	has CamelFolderInfoFlags $!flags       ;
	has gint32               $!unread      ;
	has gint32               $!total       ;
}

class CamelFolderQuotaInfo is repr<CStruct> is export {
	has Str                   $!name ;
	has guint64               $!used ;
	has guint64               $!total;
	has CamelFolderQuotaInfo  $!next ;
}

class CamelFolderSearch is repr<CStruct> is export {
	HAS GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelFolderSummary is repr<CStruct> is export {
	HAS GObject                   $!parent;
	has Pointer $!priv  ;
}

class CamelGpgContext is repr<CStruct> is export {
	HAS CamelCipherContext     $!parent;
	has Pointer $!priv  ;
}

class CamelHTMLParser is repr<CStruct> is export {
	HAS GObject                $!parent;
	has Pointer $!priv  ;
}

class CamelIndex is repr<CStruct> is export {
	HAS GObject           $!parent        ;
	has Pointer $!priv          ;
	has Str             $!path          ;
	has guint32           $!version       ;
	has guint32           $!flags         ;
	has guint32           $!state         ;
	has CamelIndexNorm    $!normalize     ;
	has gpointer          $!normalize_data;
}

class CamelIndexCursor is repr<CStruct> is export {
	HAS GObject                 $!parent;
	has Pointer $!priv  ;
	has CamelIndex              $!index ;
}

class CamelIndexName is repr<CStruct> is export {
	HAS GObject               $!parent;
	has Pointer $!priv  ;
	has CamelIndex            $!index ;
	has Str                 $!name  ;
	has GByteArray            $!buffer;
	has GHashTable            $!words ;
}

class CamelInternetAddress is repr<CStruct> is export {
	HAS CamelAddress                $!parent;
	has Pointer $!priv  ;
}

class CamelKeyFile is repr<CStruct> is export {
	HAS GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelKeyRootBlock is repr<CStruct> is export {
	has camel_block_t $!first;
	has camel_block_t $!last ;
	has camel_key_t   $!free ;
}

class CamelKeyTable is repr<CStruct> is export {
	HAS GObject              $!parent;
	has Pointer $!priv  ;
}

class CamelSettings is repr<CStruct> is export {
	HAS GObject              $!parent;
	has Pointer $!priv  ;
}

class CamelService is repr<CStruct> is export {
	HAS CamelObject         $!parent;
	has Pointer $!priv  ;
}

class CamelStore is repr<CStruct> is export {
	HAS CamelService      $!parent;
	has Pointer $!priv  ;
}

class CamelStoreSettings is repr<CStruct> is export {
	HAS CamelSettings             $!parent;
	has Pointer $!priv  ;
}

class CamelLocalSettings is repr<CStruct> is export {
	HAS CamelStoreSettings        $!parent;
	has Pointer $!priv  ;
}

class CamelLockHelperMsg is repr<CStruct> is export {
	has guint32 $!magic;
	has guint32 $!seq  ;
	has guint32 $!id   ;
	has guint32 $!data ;
}

class CamelMIRecord is repr<CStruct> is export {
	has Str    $!uid                  ;
	has guint32  $!flags                ;
	has guint32  $!msg_type             ;
	has guint32  $!dirty                ;
	has gboolean $!read                 ;
	has gboolean $!deleted              ;
	has gboolean $!replied              ;
	has gboolean $!important            ;
	has gboolean $!junk                 ;
	has gboolean $!attachment           ;
	has guint32  $!size                 ;
	has gint64   $!dsent                ;
	has gint64   $!dreceived            ;
	has Str    $!subject              ;
	has Str    $!from                 ;
	has Str    $!to                   ;
	has Str    $!cc                   ;
	has Str    $!mlist                ;
	has Str    $!followup_flag        ;
	has Str    $!followup_completed_on;
	has Str    $!followup_due_by      ;
	has Str    $!part                 ;
	has Str    $!labels               ;
	has Str    $!usertags             ;
	has Str    $!cinfo                ;
	has Str    $!bdata                ;
}

class CamelMedium is repr<CStruct> is export {
	HAS CamelDataWrapper   $!parent;
	has Pointer $!priv  ;
}

class CamelContentType is repr<CStruct> is export {
  has Str                $!type;
  has Str                $!subtype;
  has camel_header_param $!params;
  has guint              $!refcount;
}

class CamelMessageContentInfo is repr<CStruct> is export {
	has CamelMessageContentInfo $!next       ;
	has CamelMessageContentInfo $!childs     ;
	has CamelMessageContentInfo $!parent     ;
	has CamelContentType        $!type       ;
	has CamelContentDisposition $!disposition;
	has Str                     $!id         ;
	has Str                     $!description;
	has Str                     $!encoding   ;
	has guint32                 $!size       ;
}

class CamelMessageInfo is repr<CStruct> is export {
	HAS GObject                 $!parent;
	has Pointer $!priv  ;
}

class CamelMessageInfoBase is repr<CStruct> is export {
	HAS CamelMessageInfo     $!parent;
	has Pointer              $!priv;
}

class CamelMimeFilter is repr<CStruct> is export {
	HAS GObject              $!parent  ;
	has Pointer              $!priv    ;
	has Str                  $!outreal ;
	has Str                  $!outbuf  ;
	has Str                  $!outptr  ;
	has gsize                $!outsize ;
	has gsize                $!outpre  ;
	has Str                  $!backbuf ;
	has gsize                $!backsize;
	has gsize                $!backlen ;
}

class CamelMimeFilterBasic is repr<CStruct> is export {
	HAS CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterBestenc is repr<CStruct> is export {
	HAS CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCRLF is repr<CStruct> is export {
	HAS CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCanon is repr<CStruct> is export {
	HAS CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterCharset is repr<CStruct> is export {
	HAS CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterEnriched is repr<CStruct> is export {
	HAS CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterFrom is repr<CStruct> is export {
	HAS CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterGZip is repr<CStruct> is export {
	HAS CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterHTML is repr<CStruct> is export {
	HAS CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterIndex is repr<CStruct> is export {
	HAS CamelMimeFilter             $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterLinewrap is repr<CStruct> is export {
	HAS CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterPgp is repr<CStruct> is export {
	HAS CamelMimeFilter           $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterProgress is repr<CStruct> is export {
	HAS CamelMimeFilter                $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterToHTML is repr<CStruct> is export {
	HAS CamelMimeFilter              $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterWindows is repr<CStruct> is export {
	HAS CamelMimeFilter               $!parent;
	has Pointer $!priv  ;
}

class CamelMimeFilterYenc is repr<CStruct> is export {
	HAS CamelMimeFilter            $!parent;
	has Pointer $!priv  ;
}

class CamelMimePart is repr<CStruct> is export {
	HAS CamelMedium          $!parent;
	has Pointer $!priv  ;
}

class CamelMimeMessage is repr<CStruct> is export {
	HAS CamelMimePart           $!parent;
	has Pointer $!priv  ;
}

class CamelMimeParser is repr<CStruct> is export {
	HAS GObject                $!parent;
	has Pointer $!priv  ;
}

class CamelMsg is repr<CStruct> is export {
	has CamelMsgPort $!reply_port;
	has gint         $!flags     ;
}

class CamelMultipart is repr<CStruct> is export {
	HAS CamelDataWrapper      $!parent;
	has Pointer $!priv  ;
}

class CamelMultipartEncrypted is repr<CStruct> is export {
	HAS CamelMultipart                 $!parent;
	has Pointer $!priv  ;
}

class CamelMultipartSigned is repr<CStruct> is export {
	HAS CamelMultipart              $!parent;
	has Pointer $!priv  ;
}

class CamelNNTPAddress is repr<CStruct> is export {
	HAS CamelAddress            $!parent;
	has Pointer $!priv  ;
}

class CamelNullOutputStream is repr<CStruct> is export {
	HAS GOutputStream                $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineFolder is repr<CStruct> is export {
	HAS CamelFolder               $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineSettings is repr<CStruct> is export {
	HAS CamelStoreSettings          $!parent;
	has Pointer $!priv  ;
}

class CamelOfflineStore is repr<CStruct> is export {
	HAS CamelStore               $!parent;
	has Pointer $!priv  ;
}

class CamelOperation is repr<CStruct> is export {
	HAS GCancellable          $!parent;
	has Pointer $!priv  ;
}

class CamelPartitionKey is repr<CStruct> is export {
	has camel_hash_t $!hashid;
	has camel_key_t  $!keyid ;
}

class CamelPartitionMap is repr<CStruct> is export {
	has camel_hash_t  $!hashid ;
	has camel_block_t $!blockid;
}

class CamelPartitionTable is repr<CStruct> is export {
	HAS GObject                    $!parent;
	has Pointer $!priv  ;
}

class CamelSExp is repr<CStruct> is export {
	HAS GObject          $!parent;
	has Pointer $!priv  ;
}

class CamelSMIMEContext is repr<CStruct> is export {
	HAS CamelCipherContext       $!parent;
	has Pointer $!priv  ;
}

class CamelSasl is repr<CStruct> is export {
	HAS GObject          $!parent;
	has Pointer $!priv  ;
}

class CamelSaslAnonymous is repr<CStruct> is export {
	HAS CamelSasl                 $!parent;
	has Pointer $!priv  ;
}

class CamelSaslGssapi is repr<CStruct> is export {
	HAS CamelSasl              $!parent;
	has Pointer $!priv  ;
}

class CamelSaslLogin is repr<CStruct> is export {
	HAS CamelSasl             $!parent;
	has Pointer $!priv  ;
}

class CamelSaslNTLM is repr<CStruct> is export {
	HAS CamelSasl            $!parent;
	has Pointer $!priv  ;
}

class CamelSaslPlain is repr<CStruct> is export {
	HAS CamelSasl             $!parent;
	has Pointer $!priv  ;
}

class CamelSession is repr<CStruct> is export {
	HAS GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelStoreSummary is repr<CStruct> is export {
	HAS GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelStream is repr<CStruct> is export {
	HAS GObject            $!parent;
	has Pointer $!priv  ;
}

class CamelStreamBuffer is repr<CStruct> is export {
	HAS CamelStream              $!parent;
	has Pointer $!priv  ;
}

class CamelStreamFilter is repr<CStruct> is export {
	HAS CamelStream              $!parent;
	has Pointer $!priv  ;
}

class CamelStreamFs is repr<CStruct> is export {
	HAS CamelStream          $!parent;
	has Pointer $!priv  ;
}

class CamelStreamMem is repr<CStruct> is export {
	HAS CamelStream           $!parent;
	has Pointer $!priv  ;
}

class CamelStreamNull is repr<CStruct> is export {
	HAS CamelStream            $!parent;
	has Pointer $!priv  ;
}

class CamelStreamProcess is repr<CStruct> is export {
	HAS CamelStream               $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndex is repr<CStruct> is export {
	HAS CamelIndex            $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexCursor is repr<CStruct> is export {
	HAS CamelIndexCursor            $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexKeyCursor is repr<CStruct> is export {
	HAS CamelIndexCursor               $!parent;
	has Pointer $!priv  ;
}

class CamelTextIndexName is repr<CStruct> is export {
	HAS CamelIndexName            $!parent;
	has Pointer $!priv  ;
}

class CamelTransport is repr<CStruct> is export {
	HAS CamelService          $!parent;
	has Pointer $!priv  ;
}

class CamelURL is repr<CStruct> is export {
	has Str $!protocol;
	has Str $!user    ;
	has Str $!authmech;
	has Str $!host    ;
	has gint  $!port    ;
	has Str $!path    ;
	has GData $!params  ;
	has Str $!query   ;
	has Str $!fragment;
}

class CamelVeeFolder is repr<CStruct> is export {
	HAS CamelFolder           $!parent;
	has Pointer $!priv  ;
}

class CamelVTrashFolder is repr<CStruct> is export {
	HAS CamelVeeFolder           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeDataCache is repr<CStruct> is export {
	HAS GObject                  $!parent;
	has Pointer $!priv  ;
}

class CamelVeeMessageInfo is repr<CStruct> is export {
	HAS CamelMessageInfo           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeMessageInfoData is repr<CStruct> is export {
	HAS GObject                        $!parent;
	has Pointer $!priv  ;
}

class CamelVeeStore is repr<CStruct> is export {
	HAS CamelStore           $!parent;
	has Pointer $!priv  ;
}

class CamelVeeSubfolderData is repr<CStruct> is export {
	HAS GObject                      $!parent;
	has Pointer $!priv  ;
}

class CamelVeeSummary is repr<CStruct> is export {
	HAS CamelFolderSummary     $!parent;
	has Pointer $!priv  ;
}

class EClient is repr<CStruct> is export {
	HAS GObject $.parent;
	has Pointer $!priv  ;
}

class ECalClient is repr<CStruct> is export {
	HAS EClient $.parent;
	has Pointer $!priv  ;
}

class ECalClientView is repr<CStruct> is export {
	has GObject               $!object;
	has Pointer $!priv  ;
}

class ECalComponent is repr<CStruct> is export {
	HAS GObject              $!parent;
	has Pointer $!priv  ;
}

class ECalComponentClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class ECancellableLocksBase is repr<CStruct> is export {
	has GMutex $!cond_mutex;
	has GCond  $!cond      ;
}

class ECancellableMutex is repr<CStruct> is export {
	has ECancellableLocksBase $!base ;
	has GMutex                $!mutex;
}

class ECancellableRecMutex is repr<CStruct> is export {
	has ECancellableLocksBase $!base     ;
	has GRecMutex             $!rec_mutex;
}

class EClientErrorsList is repr<CStruct> is export {
	has Str $!name    ;
	has gint  $!err_code;
}

class ECredentials is repr<CStruct> is export {
	has Pointer $!priv;
}

class EExtensibleInterface is repr<CStruct> is export {
	HAS GTypeInterface $!parent_interface;
}

class EExtension is repr<CStruct> is export {
	HAS GObject           $!parent;
	has Pointer $!priv  ;
}

class EExtensionClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class   ;
	has GType        $!extensible_type;
}

class EFreeFormExpSymbol is repr<CStruct> is export {
	has Str                     $!names     ;
	has Str                     $!hint      ;
	has EFreeFormExpBuildSexpFunc $!build_sexp;
}

class EIterator is repr<CStruct> is export {
	HAS GObject $!parent;
}

class EList is repr<CStruct> is export {
	HAS GObject       $!parent   ;
	has GList         $!list     ;
	has GList         $!iterators;
	has EListCopyFunc $!copy     ;
	has EListFreeFunc $!free     ;
	has gpointer      $!closure  ;
}

class EListClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class EListIterator is repr<CStruct> is export {
	HAS EIterator $!parent  ;
	has EList     $!list    ;
	has GList     $!iterator;
}

class EIteratorClass is repr<CStruct> is export {
   HAS GObjectClass $.parent_class;

   # Signals
   has Pointer $!invalidate; # void            (*invalidate)           (EIterator *iterator);

   # Methods
   has Pointer $!get;        # gconstpointer   (*get)                  (EIterator *iterator);
   has Pointer $!reset;      # void            (*reset)                (EIterator *iterator);
   has Pointer $!last;       # void            (*last)                 (EIterator *iterator);
   has Pointer $!next;       # gboolean        (*next)                 (EIterator *iterator);
   has Pointer $!prev;       # gboolean        (*prev)                 (EIterator *iterator);
   has Pointer $!remove;     # void            (*remove)               (EIterator *iterator);
   has Pointer $!insert;     # void            (*insert)               (EIterator *iterator, gconstpointer object, gboolean before);
   has Pointer $!set;        # void            (*set)                  (EIterator *iterator, gconstpointer object);
   has Pointer $!is_valid;   # gboolean        (*is_valid)             (EIterator *iterator);
};

class EListIteratorClass is repr<CStruct> is export {
	HAS EIteratorClass $!parent_class;
}

class EModule is repr<CStruct> is export {
	HAS GTypeModule    $!parent;
	has Pointer $!priv  ;
}

class EModuleClass is repr<CStruct> is export {
	HAS GTypeModuleClass $!parent_class;
}

class ENetworkMonitor is repr<CStruct> is export {
	HAS GObject                $!parent;
	has Pointer $!priv  ;
}

class ENetworkMonitorClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class EProxy is repr<CStruct> is export {
	HAS GObject       $!parent;
	has Pointer $!priv  ;
}

class EReminderWatcher is repr<CStruct> is export {
	HAS GObject                 $!parent;
	has Pointer $!priv  ;
}

class ESExp is repr<CStruct> is export {
	HAS GObject      $!parent_object;
	has Pointer $!priv         ;
}

class ESExpClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class ESoupAuthBearer is repr<CStruct> is export {
	HAS SoupAuth               $!parent;
	has Pointer $!priv  ;
}

class ESoupAuthBearerClass is repr<CStruct> is export {
	HAS SoupAuthClass $!parent_class;
}

class ESoupSession is repr<CStruct> is export {
	HAS SoupSession         $!parent;
	has Pointer $!priv  ;
}

class ESourceExtension is repr<CStruct> is export {
  HAS GObject $.parent;
  has Pointer $!priv;
}

class ESourceExtensionClass is repr<CStruct> is export {
  HAS GObjectClass $.parent_class;
  has Str          $!name;

	method name is rw {
		Proxy.new:
			FETCH => -> $           { $!name },
			STORE => -> $, Str() $n { $!name := $n }
	}
}

class ESource is repr<CStruct> is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ESourceBackend is repr<CStruct> is export {
	HAS ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceBackendClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceAddressBook is repr<CStruct> is export {
	HAS ESourceBackend            $!parent;
	has Pointer $!priv  ;
}

class ESourceAddressBookClass is repr<CStruct> is export {
	HAS ESourceBackendClass $!parent_class;
}

class ESourceAlarms is repr<CStruct> is export {
	HAS ESourceExtension     $!parent;
	has Pointer $!priv  ;
}

class ESourceAlarmsClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceAuthentication is repr<CStruct> is export {
	HAS ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceAuthenticationClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceAutocomplete is repr<CStruct> is export {
	HAS ESourceExtension           $!parent;
	has Pointer $!priv  ;
}

class ESourceAutocompleteClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceAutoconfig is repr<CStruct> is export {
	HAS ESourceExtension         $!parent;
	has Pointer $!priv  ;
}

class ESourceAutoconfigClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceSelectable is repr<CStruct> is export {
	HAS ESourceBackend           $!parent;
	has Pointer $!priv  ;
}

class ESourceSelectableClass is repr<CStruct> is export {
	HAS ESourceBackendClass $!parent_class;
}

class ESourceCalendar is repr<CStruct> is export {
	HAS ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceCalendarClass is repr<CStruct> is export {
	HAS ESourceSelectableClass $!parent_class;
}

class ESourceCamel is repr<CStruct> is export {
	HAS ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceCamelClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class ;
	has GType                 $!settings_type;
}

class ESourceCollection is repr<CStruct> is export {
	HAS ESourceBackend           $!parent;
	has Pointer $!priv  ;
}

class ESourceCollectionClass is repr<CStruct> is export {
	HAS ESourceBackendClass $!parent_class;
}

class ESourceContacts is repr<CStruct> is export {
	HAS ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceContactsClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceCredentialsProvider is repr<CStruct> is export {
	HAS GObject                           $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImpl is repr<CStruct> is export {
	HAS EExtension                            $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImplPassword is repr<CStruct> is export {
	HAS ESourceCredentialsProviderImpl                $!parent;
	has Pointer $!priv  ;
}

# class ESourceCredentialsProviderImplPasswordClass is repr<CStruct> is export {
# 	HAS ESourceCredentialsProviderImplClass $!parent_class;
# }

class ESourceGoa is repr<CStruct> is export {
	HAS ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceGoaClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceLDAP is repr<CStruct> is export {
	HAS ESourceExtension   $!parent;
	has Pointer $!priv  ;
}

class ESourceLDAPClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceLocal is repr<CStruct> is export {
	HAS ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceLocalClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMDN is repr<CStruct> is export {
	HAS ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceMDNClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMailAccount is repr<CStruct> is export {
	HAS ESourceBackend            $!parent;
	has Pointer $!priv  ;
}

class ESourceMailAccountClass is repr<CStruct> is export {
	HAS ESourceBackendClass $!parent_class;
}

class ESourceMailComposition is repr<CStruct> is export {
	HAS ESourceExtension              $!parent;
	has Pointer $!priv  ;
}

class ESourceMailCompositionClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMailIdentity is repr<CStruct> is export {
	HAS ESourceExtension           $!parent;
	has Pointer $!priv  ;
}

class ESourceMailIdentityClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMailSignature is repr<CStruct> is export {
	HAS ESourceExtension            $!parent;
	has Pointer $!priv  ;
}

class ESourceMailSignatureClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMailSubmission is repr<CStruct> is export {
	HAS ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceMailSubmissionClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceMailTransport is repr<CStruct> is export {
	HAS ESourceBackend              $!parent;
	has Pointer $!priv  ;
}

class ESourceMailTransportClass is repr<CStruct> is export {
	HAS ESourceBackendClass $!parent_class;
}

class ESourceMemoList is repr<CStruct> is export {
	HAS ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceMemoListClass is repr<CStruct> is export {
	HAS ESourceSelectableClass $!parent_class;
}

class ESourceOffline is repr<CStruct> is export {
	HAS ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceOfflineClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceOpenPGP is repr<CStruct> is export {
	HAS ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceOpenPGPClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceProxy is repr<CStruct> is export {
	HAS ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceProxyClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceRefresh is repr<CStruct> is export {
	HAS ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceRefreshClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceRegistry is repr<CStruct> is export {
	HAS GObject                $!parent;
	has Pointer $!priv  ;
}

class ESourceRegistryWatcher is repr<CStruct> is export {
	HAS GObject                       $!parent;
	has Pointer $!priv  ;
}

class ESourceResource is repr<CStruct> is export {
	HAS ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceResourceClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceRevisionGuards is repr<CStruct> is export {
	HAS ESourceExtension             $!parent;
	has Pointer $!priv  ;
}

class ESourceRevisionGuardsClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceSMIME is repr<CStruct> is export {
	HAS ESourceExtension    $!parent;
	has Pointer $!priv  ;
}

class ESourceSMIMEClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceSecurity is repr<CStruct> is export {
	HAS ESourceExtension       $!parent;
	has Pointer $!priv  ;
}

class ESourceSecurityClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceTaskList is repr<CStruct> is export {
	HAS ESourceSelectable      $!parent;
	has Pointer $!priv  ;
}

class ESourceTaskListClass is repr<CStruct> is export {
	HAS ESourceSelectableClass $!parent_class;
}

class ESourceUoa is repr<CStruct> is export {
	HAS ESourceExtension  $!parent;
	has Pointer $!priv  ;
}

class ESourceUoaClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceWeather is repr<CStruct> is export {
	HAS ESourceExtension      $!parent;
	has Pointer $!priv  ;
}

class ESourceWeatherClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class ESourceWebdav is repr<CStruct> is export {
	HAS ESourceExtension     $!parent;
	has Pointer $!priv  ;
}

class ESourceWebdavClass is repr<CStruct> is export {
	HAS ESourceExtensionClass $!parent_class;
}

class EUri is repr<CStruct> is export {
	has Str $!protocol;
	has Str $!user    ;
	has Str $!authmech;
	has Str $!passwd  ;
	has Str $!host    ;
	has gint  $!port    ;
	has Str $!path    ;
	has GData $!params  ;
	has Str $!query   ;
	has Str $!fragment;
}

class EWebDAVAccessControlEntry is repr<CStruct> is export {
	has EWebDAVACEPrincipalKind $!principal_kind;
	has Str                   $!principal_href;
	has guint32                 $!flags         ;
	has Str                   $!inherited_href;
	has GSList                  $!privileges    ;
}

class EWebDAVDiscoveredSource is repr<CStruct> is export {
	has Str   $!href        ;
	has guint32 $!supports    ;
	has Str   $!display_name;
	has Str   $!description ;
	has Str   $!color       ;
}

class EWebDAVPrivilege is repr<CStruct> is export {
	has Str                $!ns_uri     ;
	has Str                $!name       ;
	has Str                $!description;
	has EWebDAVPrivilegeKind $!kind       ;
	has EWebDAVPrivilegeHint $!hint       ;
}

class EWebDAVPropertyChange is repr<CStruct> is export {
	has EWebDAVPropertyChangeKind $!kind  ;
	has Str                     $!ns_uri;
	has Str                     $!name  ;
	has Str                     $!value ;
}

class EWebDAVResource is repr<CStruct> is export {
	has EWebDAVResourceKind $!kind          ;
	has guint32             $!supports      ;
	has Str               $!href          ;
	has Str               $!etag          ;
	has Str               $!display_name  ;
	has Str               $!content_type  ;
	has gsize               $!content_length;
	has glong               $!creation_date ;
	has glong               $!last_modified ;
	has Str               $!description   ;
	has Str               $!color         ;
}

class EWebDAVSession is repr<CStruct> is export {
	HAS ESoupSession          $!parent;
	has Pointer $!priv  ;
}

class EXmlDocument is repr<CStruct> is export {
	HAS GObject             $!parent;
	has Pointer $!priv  ;
}

class addrinfo is repr<CStruct> is export {
	has gint     $!ai_flags    ;
	has gint     $!ai_family   ;
	has gint     $!ai_socktype ;
	has gint     $!ai_protocol ;
	has gsize    $!ai_addrlen  ;
	has sockaddr $!ai_addr     ;
	has Str    $!ai_canonname;
	has addrinfo $!ai_next     ;
}

class camel_search_word is repr<CStruct> is export {
	has camel_search_word_t $!type;
	has Str               $!word;
}

class camel_search_words is repr<CStruct> is export {
	has gint                $!len  ;
	has camel_search_word_t $!type ;
	has camel_search_word  $!words;
}

class encrypt is repr<CStruct> is export {
	has CamelCipherValidityEncrypt $!status     ;
	has Str                      $!description;
	has GQueue                     $!encrypters ;
}

class sign is repr<CStruct> is export {
	has CamelCipherValiditySign $!status     ;
	has Str                   $!description;
	has GQueue                  $!signers    ;
}
