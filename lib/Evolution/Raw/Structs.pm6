use v6.c;

use NativeCall;

use GLib::Compat::Definitions;
use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GLib::Class::TypeModule;
use ICal::Raw::Enums;
use GIO::Raw::Definitions;
use SOUP::Raw::Definitions;
use SOUP::Class::Auth;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

use GLib::Class::Object;

use GLib::Roles::Pointers;

unit package Evolution::Raw::Structs;

class CamelAddress is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject             $!parent;
	has Pointer $!priv  ;
}

class CamelBlockFile is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject               $!parent;
	has Pointer $!priv  ;
}

class CamelBlockRoot is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str           $!version   ;
	has guint32       $!flags     ;
	has guint32       $!block_size;
	has camel_block_t $!free      ;
	has camel_block_t $!last      ;
}

class CamelCertDB is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelCharset is repr<CStruct> does GLib::Roles::Pointers is export {
	has guint $!mask ;
	has gint  $!level;
}

class CamelCipherCertInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                  $!name           ;
	has Str                  $!email          ;
	has gpointer             $!cert_data      ;
	has GDestroyNotify       $!cert_data_free ;
	has CamelCipherCloneFunc $!cert_data_clone;
	has GSList               $!properties     ;
}

class CamelCipherCertInfoProperty is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                $!name       ;
	has gpointer             $!value      ;
	has GDestroyNotify       $!value_free ;
	has CamelCipherCloneFunc $!value_clone;
}

class CamelCipherContext is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class camel_header_param is repr<CStruct> does GLib::Roles::Pointers is export {
	has camel_header_param $!next ;
	has Str                $!name ;
	has Str                $!value;
}

class CamelContentDisposition is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                 $!disposition;
	has camel_header_param  $!params     ;
	has guint               $!refcount   ;
}

class CamelDB is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelDataCache is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelDataWrapper is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelFIRecord is repr<CStruct> does GLib::Roles::Pointers is export {
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
	has Str     $!bdata        ;
}

class CamelFilterDriver is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelFilterInputStream is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GFilterInputStream $!parent;
	has Pointer            $!priv  ;
}

class CamelFilterOutputStream is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GFilterOutputStream $!parent;
	has Pointer             $!priv  ;
}

class CamelObject is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelFolder is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelObject  $!parent;
	has Pointer      $!priv  ;
}

class CamelFolderChangeInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	has GPtrArray $!uid_added  ;
	has GPtrArray $!uid_removed;
	has GPtrArray $!uid_changed;
	has GPtrArray $!uid_recent ;
	has Pointer   $!priv       ;
}

class CamelFolderInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	has CamelFolderInfo      $!next        ;
	has CamelFolderInfo      $!parent      ;
	has CamelFolderInfo      $!child       ;
	has Str                  $!full_name   ;
	has Str                  $!display_name;
	has CamelFolderInfoFlags $!flags       ;
	has gint32               $!unread      ;
	has gint32               $!total       ;
}

class CamelFolderQuotaInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                   $!name ;
	has guint64               $!used ;
	has guint64               $!total;
	has CamelFolderQuotaInfo  $!next ;
}

class CamelFolderSearch is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelFolderSummary is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelGpgContext is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelCipherContext $!parent;
	has Pointer            $!priv  ;
}

class CamelHTMLParser is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelIndex is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject        $!parent        ;
	has Pointer        $!priv          ;
	has Str            $!path          ;
	has guint32        $!version       ;
	has guint32        $!flags         ;
	has guint32        $!state         ;
	has CamelIndexNorm $!normalize     ;
	has gpointer       $!normalize_data;
}

class CamelIndexCursor is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject    $!parent;
	has Pointer    $!priv  ;
	has CamelIndex $!index ;
}

class CamelIndexName is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject    $!parent;
	has Pointer    $!priv  ;
	has CamelIndex $!index ;
	has Str        $!name  ;
	has GByteArray $!buffer;
	has GHashTable $!words ;
}

class CamelInternetAddress is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelAddress $!parent;
	has Pointer      $!priv  ;
}

class CamelKeyFile is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelKeyRootBlock is repr<CStruct> does GLib::Roles::Pointers is export {
	has camel_block_t $!first;
	has camel_block_t $!last ;
	has camel_key_t   $!free ;
}

class CamelKeyTable is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelSettings is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelService is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelObject $!parent;
	has Pointer     $!priv  ;
}

class CamelStore is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelService $!parent;
	has Pointer      $!priv  ;
}

class CamelStoreSettings is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSettings $!parent;
	has Pointer       $!priv  ;
}

class CamelLocalSettings is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStoreSettings $!parent;
	has Pointer            $!priv  ;
}

class CamelLockHelperMsg is repr<CStruct> does GLib::Roles::Pointers is export {
	has guint32 $!magic;
	has guint32 $!seq  ;
	has guint32 $!id   ;
	has guint32 $!data ;
}

class CamelMIRecord is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str      $!uid                  ;
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
	has Str      $!subject              ;
	has Str      $!from                 ;
	has Str      $!to                   ;
	has Str      $!cc                   ;
	has Str      $!mlist                ;
	has Str      $!followup_flag        ;
	has Str      $!followup_completed_on;
	has Str      $!followup_due_by      ;
	has Str      $!part                 ;
	has Str      $!labels               ;
	has Str      $!usertags             ;
	has Str      $!cinfo                ;
	has Str      $!bdata                ;
}

class CamelMedium is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelDataWrapper $!parent;
	has Pointer          $!priv  ;
}

class CamelContentType is repr<CStruct> does GLib::Roles::Pointers is export {
  has Str                $!type;
  has Str                $!subtype;
  has camel_header_param $!params;
  has guint              $!refcount;
}

class CamelMessageContentInfo is repr<CStruct> does GLib::Roles::Pointers is export {
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

class CamelMessageInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelMessageInfoBase is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMessageInfo     $!parent;
	has Pointer              $!priv;
}

class CamelMimeFilter is repr<CStruct> does GLib::Roles::Pointers is export {
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

class CamelMimeFilterBasic is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterBestenc is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterCRLF is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterCanon is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterCharset is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterEnriched is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterFrom is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterGZip is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterHTML is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterIndex is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterLinewrap is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterPgp is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterProgress is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterToHTML is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterWindows is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimeFilterYenc is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimeFilter $!parent;
	has Pointer         $!priv  ;
}

class CamelMimePart is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMedium   $!parent;
	has Pointer       $!priv  ;
}

class CamelMimeMessage is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMimePart $!parent;
	has Pointer       $!priv  ;
}

class CamelMimeParser is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelMsg is repr<CStruct> does GLib::Roles::Pointers is export {
	has CamelMsgPort $.reply_port;
	has gint         $!flags     ;
}

class CamelMultipart is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelDataWrapper $!parent;
	has Pointer          $!priv  ;
}

class CamelMultipartEncrypted is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMultipart $!parent;
	has Pointer        $!priv  ;
}

class CamelMultipartSigned is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMultipart $!parent;
	has Pointer        $!priv  ;
}

class CamelNNTPAddress is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelAddress   $!parent;
	has Pointer        $!priv  ;
}

class CamelNullOutputStream is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GOutputStream $!parent;
	has Pointer       $!priv  ;
}

class CamelOfflineFolder is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelFolder $!parent;
	has Pointer     $!priv  ;
}

class CamelOfflineSettings is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStoreSettings $!parent;
	has Pointer            $!priv  ;
}

class CamelOfflineStore is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStore $!parent;
	has Pointer    $!priv  ;
}

class CamelOperation is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GCancellable $!parent;
	has Pointer      $!priv  ;
}

class CamelPartitionKey is repr<CStruct> does GLib::Roles::Pointers is export {
	has camel_hash_t $!hashid;
	has camel_key_t  $!keyid ;
}

class CamelPartitionMap is repr<CStruct> does GLib::Roles::Pointers is export {
	has camel_hash_t  $!hashid ;
	has camel_block_t $!blockid;
}

class CamelPartitionTable is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelSExp is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelSMIMEContext is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelCipherContext $!parent;
	has Pointer            $!priv  ;
}

class CamelSasl is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelSaslAnonymous is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSasl $!parent;
	has Pointer   $!priv  ;
}

class CamelSaslGssapi is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSasl $!parent;
	has Pointer   $!priv  ;
}

class CamelSaslLogin is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSasl $!parent;
	has Pointer   $!priv  ;
}

class CamelSaslNTLM is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSasl $!parent;
	has Pointer   $!priv  ;
}

class CamelSaslPlain is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelSasl $!parent;
	has Pointer   $!priv  ;
}

class CamelSession is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelStoreSummary is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelStream is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelStreamBuffer is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelStreamFilter is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelStreamFs is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelStreamMem is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelStreamNull is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelStreamProcess is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStream $!parent;
	has Pointer     $!priv  ;
}

class CamelTextIndex is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelIndex $!parent;
	has Pointer    $!priv  ;
}

class CamelTextIndexCursor is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelIndexCursor $!parent;
	has Pointer          $!priv  ;
}

class CamelTextIndexKeyCursor is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelIndexCursor $!parent;
	has Pointer          $!priv  ;
}

class CamelTextIndexName is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelIndexName $!parent;
	has Pointer        $!priv  ;
}

class CamelTransport is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelService $!parent;
	has Pointer      $!priv  ;
}

class CamelURL is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str   $!protocol;
	has Str   $!user    ;
	has Str   $!authmech;
	has Str   $!host    ;
	has gint  $!port    ;
	has Str   $!path    ;
	has GData $!params  ;
	has Str   $!query   ;
	has Str   $!fragment;
}

class CamelVeeFolder is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelFolder $!parent;
	has Pointer     $!priv  ;
}

class CamelVTrashFolder is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelVeeFolder $!parent;
	has Pointer        $!priv  ;
}

class CamelVeeDataCache is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelVeeMessageInfo is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelMessageInfo $!parent;
	has Pointer          $!priv  ;
}

class CamelVeeMessageInfoData is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelVeeStore is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelStore $!parent;
	has Pointer    $!priv  ;
}

class CamelVeeSubfolderData is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class CamelVeeSummary is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS CamelFolderSummary $!parent;
	has Pointer            $!priv  ;
}

class EClient is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ECalClient is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS EClient $!parent;
	has Pointer $!priv  ;
}

class ECalClientView is repr<CStruct> does GLib::Roles::Pointers is export {
	has GObject $!object;
	has Pointer $!priv  ;
}

class ECalComponent is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ECalComponentId is repr<CStruct> does GLib::Roles::Pointers is export {
  has Str $!uid;
  has Str $!rid;
}

class ECalComponentClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class;
}

class ECancellableLocksBase is repr<CStruct> does GLib::Roles::Pointers is export {
	has GMutex $!cond_mutex;
	has GCond  $!cond      ;
}

class ECancellableMutex is repr<CStruct> does GLib::Roles::Pointers is export {
	has ECancellableLocksBase $!base ;
	has GMutex                $!mutex;
}

class ECancellableRecMutex is repr<CStruct> does GLib::Roles::Pointers is export {
	has ECancellableLocksBase $!base     ;
	has GRecMutex             $!rec_mutex;
}

class EClientErrorsList is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str  $!name    ;
	has gint $!err_code;
}

class ECredentials is repr<CStruct> does GLib::Roles::Pointers is export {
	has Pointer $!priv;
}

class EExtensibleInterface is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GTypeInterface $!parent_interface;
}

class EExtension is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class EExtensionClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class   ;
	has GType        $!extensible_type;
}

class EFreeFormExpSymbol is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                       $!names     ;
	has Str                       $!hint      ;
	has EFreeFormExpBuildSexpFunc $!build_sexp;
}

class EIterator is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
}

class EList is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject       $!parent   ;
	has GList         $!list     ;
	has GList         $!iterators;
	has EListCopyFunc $!copy     ;
	has EListFreeFunc $!free     ;
	has gpointer      $!closure  ;
}

class EListClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class;
}

class EListIterator is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS EIterator $!parent  ;
	has EList     $!list    ;
	has GList     $!iterator;
}

class EIteratorClass is repr<CStruct> does GLib::Roles::Pointers is export {
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

class EListIteratorClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS EIteratorClass $.parent_class;
}

class EModule is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GTypeModule $!parent;
	has Pointer     $!priv  ;
}

class EModuleClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GTypeModuleClass $.parent_class;
}

class ENetworkMonitor is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ENetworkMonitorClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class;
}

class EOAuth2Services is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv;
}

class EOAuth2ServicesClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;

  # Padding for future expansion
  HAS gpointer     @!reserved[10] is CArray;
}

class EProxy is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class EReminderWatcher is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject                 $!parent;
	has Pointer $!priv  ;
}

class ESExp is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject      $!parent_object;
	has Pointer $!priv         ;
}

class ESExpClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class;
}

class ESoupAuthBearer is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS SoupAuth               $!parent;
	has Pointer $!priv  ;
}

class ESoupAuthBearerClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS SoupAuthClass $.parent_class;
}

class ESoupSession is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS SoupSession         $!parent;
	has Pointer $!priv  ;
}

class ESourceExtension is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv;
}

class ESourceExtensionClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;
  has Str          $!name;

	method name is rw {
		Proxy.new:
			FETCH => -> $           { $!name },
			STORE => -> $, Str() $n { $!name := $n }
	}
}

class ESource is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ESourceClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent;

  # Signals
  has Pointer $!changed;                          #= void      (*changed)              (ESource *source);
  has Pointer $!credentials_required;             #= void      (*credentials_required) (ESource *source, ESourceCredentialsReason reason, const gchar *certificate_pem, GTlsCertificateFlags certificate_errors, const GError *op_error);
  has Pointer $!authenticate;                     #= void      (* authenticate)        (ESource *source, const ENamedParameters *credentials);

  # Methods
  has Pointer $!remove_sync;                                    #= gboolean  (*remove_sync)          (ESource *source, GCancellable *cancellable, GError **error);
  has Pointer $!remove;                                         #= void      (*remove)               (ESource *source, GCancellable *cancellable, GAsyncReadyCallback callback, gpointer user_data);
  has Pointer $!remove_finish;                                  #= gboolean  (*remove_finish)        (ESource *source, GAsyncResult *result, GError **error);
  has Pointer $!write_sync;                                     #= gboolean  (*write_sync)           (ESource *source, GCancellable *cancellable, GError **error);
  has Pointer $!write;                                          #= void      (*write)                (ESource *source, GCancellable *cancellable, GAsyncReadyCallback callback, gpointer user_data);
  has Pointer $!write_finish;                                   #= gboolean  (*write_finish)         (ESource *source, GAsyncResult *result, GError **error);
  has Pointer $!remote_create_sync;                             #= gboolean  (*remote_create_sync)   (ESource *source, ESource *scratch_source, GCancellable *cancellable, GError **error);
  has Pointer $!remote_create;                                  #= void      (*remote_create)        (ESource *source, ESource *scratch_source, GCancellable *cancellable, GAsyncReadyCallback callback, gpointer user_data);
  has Pointer $!remote_create_finish;                           #= gboolean  (*remote_create_finish) (ESource *source, GAsyncResult *result, GError **error);
  has Pointer $!remote_delete_sync;                             #= gboolean  (*remote_delete_sync)   (ESource *source, GCancellable *cancellable, GError **error);
  has Pointer $!remote_delete;                                  #= void      (*remote_delete)        (ESource *source, GCancellable *cancellable, GAsyncReadyCallback callback, gpointer user_data);
  has Pointer $!remote_delete_finish;                           #= gboolean  (*remote_delete_finish) (ESource *source, GAsyncResult *result, GError **error);
  has Pointer $!get_oauth2_access_token_sync;                   #= gboolean  (*get_oauth2_access_token_sync)                   (ESource *source, GCancellable *cancellable, gchar **out_access_token, gint *out_expires_in, GError **error);
  has Pointer $!get_oauth2_access_token;                        #= void      (*get_oauth2_access_token)                        (ESource *source, GCancellable *cancellable, GAsyncReadyCallback callback, gpointer user_data);
  has Pointer $!get_oauth2_access_token_finish;                 #= gboolean  (*get_oauth2_access_token_finish)                 (ESource *source, GAsyncResult *result, gchar **out_access_token, gint *out_expires_in, GError **error);
  has Pointer $!invoke_credentials_required_impl;               #= gboolean  (*invoke_credentials_required_impl)               (ESource *source, gpointer dbus_source, /* EDBusSource * */ const gchar *arg_reason, const gchar *arg_certificate_pem, const gchar *arg_certificate_errors, const gchar *arg_dbus_error_name, const gchar *arg_dbus_error_message, GCancellable *cancellable, GError **error);
  has Pointer $!invoke_authenticate_impl;                       #= gboolean  (*invoke_authenticate_impl)                       (ESource *source, gpointer dbus_source, /* EDBusSource * */ const gchar * const *arg_credentials, GCancellable *cancellable, GError **error);
  has Pointer $!unset_last_credentials_required_arguments_impl; #= gboolean  (*unset_last_credentials_required_arguments_impl) (ESource *source, GCancellable *cancellable, GError **error);

  HAS gpointer @.reserved[6] is CArray;
}

class ESourceBackend is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceBackendClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceAddressBook is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackend $!parent;
	has Pointer        $!priv  ;
}

class ESourceAddressBookClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackendClass $.parent_class;
}

class ESourceAlarms is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension  $!parent;
	has Pointer           $!priv  ;
}

class ESourceAlarmsClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceAuthentication is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceAuthenticationClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceAutocomplete is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceAutocompleteClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceAutoconfig is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv;
}

class ESourceAutoconfigClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceSelectable is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackend $!parent;
	has Pointer        $!priv;
}

class ESourceSelectableClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackendClass $.parent_class;
}

class ESourceCalendar is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectable  $!parent;
	has Pointer            $!priv;
}

class ESourceCalendarClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectableClass $.parent_class;
}

class ESourceCamel is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceCamelClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class ;
	has GType                 $!settings_type;
}

class ESourceCollection is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackend $!parent;
	has Pointer        $!priv  ;
}

class ESourceCollectionClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackendClass $.parent_class;
}

class ESourceContacts is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceContactsClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceCredentialsProvider is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ESourceCredentialsProviderImpl is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS EExtension $!parent;
	has Pointer    $!priv  ;
}

class ESourceCredentialsProviderImplPassword is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceCredentialsProviderImpl $!parent;
	has Pointer                        $!priv  ;
}

class ESourceCredentialsProviderClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;
  has Pointer      $!ref_source;   #= ESource *       (*ref_source)   (ESourceCredentialsProvider *provider, const gchar *uid);
}

# class ESourceCredentialsProviderImplPasswordClass is repr<CStruct> does GLib::Roles::Pointers is export {
# 	HAS ESourceCredentialsProviderImplClass $.parent_class;
# }

class ESourceGoa is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceGoaClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceLDAP is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceLDAPClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceLocal is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceLocalClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMDN is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceMDNClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMailAccount is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackend $!parent;
	has Pointer        $!priv  ;
}

class ESourceMailAccountClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackendClass $.parent_class;
}

class ESourceMailComposition is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceMailCompositionClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMailIdentity is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceMailIdentityClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMailSignature is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceMailSignatureClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMailSubmission is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceMailSubmissionClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceMailTransport is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackend $!parent;
	has Pointer        $!priv  ;
}

class ESourceMailTransportClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceBackendClass $.parent_class;
}

class ESourceMemoList is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectable $!parent;
	has Pointer           $!priv  ;
}

class ESourceMemoListClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectableClass $.parent_class;
}

class ESourceOffline is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension  $!parent;
	has Pointer           $!priv  ;
}

class ESourceOfflineClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceOpenPGP is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceOpenPGPClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceProxy is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceProxyClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceRefresh is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceRefreshClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceRegistry is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ESourceRegistryWatcher is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class ESourceResource is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceResourceClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceRevisionGuards is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceRevisionGuardsClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceSMIME is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceSMIMEClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceSecurity is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceSecurityClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceTaskList is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectable $!parent;
	has Pointer           $!priv  ;
}

class ESourceTaskListClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceSelectableClass $.parent_class;
}

class ESourceUoa is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceUoaClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceWeather is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceWeatherClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class ESourceWebdav is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtension $!parent;
	has Pointer          $!priv  ;
}

class ESourceWebdavClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESourceExtensionClass $.parent_class;
}

class EUri is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str   $!protocol;
	has Str   $!user    ;
	has Str   $!authmech;
	has Str   $!passwd  ;
	has Str   $!host    ;
	has gint  $!port    ;
	has Str   $!path    ;
	has GData $!params  ;
	has Str   $!query   ;
	has Str   $!fragment;
}

class EWebDAVAccessControlEntry is repr<CStruct> does GLib::Roles::Pointers is export {
	has EWebDAVACEPrincipalKind $!principal_kind;
	has Str                     $!principal_href;
	has guint32                 $!flags         ;
	has Str                     $!inherited_href;
	has GSList                  $!privileges    ;
}

class EWebDAVDiscoveredSource is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str     $!href        ;
	has guint32 $!supports    ;
	has Str     $!display_name;
	has Str     $!description ;
	has Str     $!color       ;
}

class EWebDAVPrivilege is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str                  $!ns_uri     ;
	has Str                  $!name       ;
	has Str                  $!description;
	has EWebDAVPrivilegeKind $!kind       ;
	has EWebDAVPrivilegeHint $!hint       ;
}

class EWebDAVPropertyChange is repr<CStruct> does GLib::Roles::Pointers is export {
	has EWebDAVPropertyChangeKind $!kind  ;
	has Str                       $!ns_uri;
	has Str                       $!name  ;
	has Str                       $!value ;
}

class EWebDAVResource is repr<CStruct> does GLib::Roles::Pointers is export {
	has EWebDAVResourceKind $!kind          ;
	has guint32             $!supports      ;
	has Str                 $!href          ;
	has Str                 $!etag          ;
	has Str                 $!display_name  ;
	has Str                 $!content_type  ;
	has gsize               $!content_length;
	has glong               $!creation_date ;
	has glong               $!last_modified ;
	has Str                 $!description   ;
	has Str                 $!color         ;
}

class EWebDAVSession is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ESoupSession $!parent;
	has Pointer      $!priv  ;
}

class EXmlDocument is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $!parent;
	has Pointer $!priv  ;
}

class addrinfo is repr<CStruct> does GLib::Roles::Pointers is export {
	has gint     $!ai_flags    ;
	has gint     $!ai_family   ;
	has gint     $!ai_socktype ;
	has gint     $!ai_protocol ;
	has gsize    $!ai_addrlen  ;
	has sockaddr $!ai_addr     ;
	has Str      $!ai_canonname;
	has addrinfo $!ai_next     ;
}

class camel_search_word is repr<CStruct> does GLib::Roles::Pointers is export {
	has camel_search_word_t $!type;
	has Str                 $!word;
}

class camel_search_words is repr<CStruct> does GLib::Roles::Pointers is export {
	has gint                $!len  ;
	has camel_search_word_t $!type ;
	has camel_search_word   $!words;
}

class encrypt is repr<CStruct> does GLib::Roles::Pointers is export {
	has CamelCipherValidityEncrypt $!status     ;
	has Str                        $!description;
	has GQueue                     $!encrypters ;
}

class sign is repr<CStruct> does GLib::Roles::Pointers is export {
	has CamelCipherValiditySign $!status     ;
	has Str                     $!description;
	has GQueue                  $!signers    ;
}

class EBook is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ;
}

class EBookClient is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EClient $!parent;
  has Pointer $!priv  ;
}

class EBookClientClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS Pointer $.parent_class; # EClientClass
}

class EBookClientCursor is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ;
}

class EBookClientView is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ;
}

class EBookView is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ;
}

class EDestination is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $.object;
  has Pointer $!priv  ;
}

class EVCard is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ;
}

class EVCardClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObjectClass $.parent_class;
	has Pointer      $!reserved0;    #= &(void);
	has Pointer      $!reserved1;    #= &(void);
	has Pointer      $!reserved2;    #= &(void);
	has Pointer      $!reserved3;    #= &(void);
	has Pointer      $!reserved4;    #= &(void);
}

class EContact is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EVCard  $!parent;
  has Pointer $!priv  ;
}

class ESourceBackendSummarySetup is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESourceBackend  $!parent;
  has Pointer         $!priv  ;
}

class ESourceBackendSummarySetupClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESourceBackendClass $.p1arent_class;
}

class EContactName is repr<CStruct> does GLib::Roles::Pointers is export {
	# cw: Needs accessors!
  has Str $!family;
  has Str $!given;
  has Str $!additional;
  has Str $!prefixes;
  has Str $!suffixes;
}

class EContactGeo is repr<CStruct> does GLib::Roles::Pointers is export {
	has gdouble $.latitude  is rw;
	has gdouble $.longitude is rw;
}

class EPhotoDataInlined is repr<CStruct> {
  has Str           $!mime_type;
  has gsize         $.length     is rw;
  has CArray[uint8] $!data;

	submethod BUILD {
		$!mime_type //= '';
	}

	method data is rw {
		Proxy.new:
			FETCH => -> $     { $!data },
			STORE => -> $, \v { $!data := v };
	}

	method mime_type is rw {
		Proxy.new:
			FETCH => -> $     { $!mime_type },
			STORE => -> $, \v { $!mime_type := v // Str };
	}
}

class EPhotoData is repr<CUnion> {
  HAS EPhotoDataInlined $!inlined;
	has Str               $!uri;
}

class EContactPhoto is repr<CStruct> does GLib::Roles::Pointers is export {
   has EContactPhotoType $.type is rw;
	 HAS EPhotoData        $.data;
}

class EContactAddress is repr<CStruct> does GLib::Roles::Pointers is export {
	has Str $!address_format; #= the two letter country code that determines the format/meaning of the following fields
	has Str $!po;
	has Str $!ext;
	has Str $!street;
	has Str $!locality;
	has Str $!region;
	has Str $!code;
	has Str $!country;
}

class EContactDate is repr<CStruct> does GLib::Roles::Pointers is export {
  has guint $.year  is rw;
  has guint $.month is rw;
  has guint $.day   is rw;

	multi method new ($year, $month, $day, :international(:$intl) is required) {
		self.bless(:$year, :$month, :$day);
	}
	multi method new ($day, $month, $year) {
		self.bless(:$year, :$month, :$day);
	}

}

class EContactCert is repr<CStruct> does GLib::Roles::Pointers is export {
  has gsize         $.length is rw;
  has CArray[uint8] $.data;

	submethod BUILD (CArray[uint8] :$data = CArray[uint8], :$!length = 0) {
		$!data := $data;
	}

  multi method new (Str $s, :$encoding = 'utf8') {
  	samewith( $s.encode($encoding) );
  }
	multi method new (CArray[uint8] $ca) {
		# cw: xxx - Check to insure .elems is available;
		self.bless(
		  data   => $ca,
			length => $ca.elems
		);
	}
  multi method new (Blob $b) {
		self.bless(
		  data   => CArray[uint8].new($b),
			length => $b.bytes
		);
	}

	method data is rw {
		Proxy.new:
			FETCH => -> $                   { $!data },
			STORE => -> $, CArray[uint8] \v { $!data := v };
	}

}

class EContactClass is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS EVCardClass $.parent_class;
	has Pointer     $!reserved0;    #= &(void)
	has Pointer     $!reserved1;    #= &(void)
	has Pointer     $!reserved2;    #= &(void)
	has Pointer     $!reserved3;    #= &(void)
	has Pointer     $!reserved4;    #= &(void)
}

# libebackend

class EBackend is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= EBackendPrivate
}

class EBackendFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EExtension $!parent;
  has Pointer    $!priv  ; #= EBackendFactoryPrivate
}

class ECache is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= ECachePrivate
}

class ECollectionBackend is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EBackend $!parent;
  has Pointer  $!priv  ; #= ECollectionBackendPrivate
}

class ECollectionBackendFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EBackendFactory $!parent;
  has Pointer         $!priv  ; #= ECollectionBackendFactoryPrivate
}

class EDBusServer is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= EDBusServerPrivate
}

class EDataFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EDBusServer $!parent;
  has Pointer     $!priv  ; #= EDataFactoryPrivate
}

class EDbHash is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS Pointer $!priv; #= EDbHashPrivate
}

class EFileCache is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= EFileCachePrivate
}

class EFileCacheClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;
}

class EOfflineListener is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= EOfflineListenerPrivate
}

class EServerSideSource is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESource $!parent;
  has Pointer $!priv  ; #= EServerSideSourcePrivate
}

class EServerSideSourceClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESourceClass $.parent_class;
}

class EServerSideSourceCredentialsProvider is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESourceCredentialsProvider $!parent;
  has Pointer                    $!priv  ; #= EServerSideSourceCredentialsProviderPrivate
}

class EServerSideSourceCredentialsProviderClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS ESourceCredentialsProviderClass $.parent_class;
}

class ESourceRegistryServer is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EDataFactory $!parent;
  has Pointer      $!priv  ; #= ESourceRegistryServerPrivate
}

class ESubprocessFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= ESubprocessFactoryPrivate
}

class EUserPrompter is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $!parent;
  has Pointer $!priv  ; #= EUserPrompterPrivate
}

class EUserPrompterClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $!parent;
}

class EUserPrompterServer is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EDBusServer $!parent;
  has Pointer     $!priv  ; #= EUserPrompterServerPrivate
}

class EUserPrompterServerExtension is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EExtension $!parent;
  has Pointer    $!priv  ; #= EUserPrompterServerExtensionPrivate
}

class EWebDAVCollectionBackend is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS ECollectionBackend $!parent;
	has Pointer            $!priv  ; #= EWebDAVCollectionBackendPrivate
}

class ESourceCredentialsProviderImplClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EExtensionClass $.parent_class;
  has Pointer         $.can_process;   #= gboolean (*can_process)   (ESourceCredentialsProviderImpl *provider_impl, ESource *source);
  has Pointer         $.can_store;     #= gboolean (*can_store)     (ESourceCredentialsProviderImpl *provider_impl);
  has Pointer         $.can_prompt;    #= gboolean (*can_prompt)    (ESourceCredentialsProviderImpl *provider_impl);
  has Pointer         $.lookup_sync;   #= gboolean (*lookup_sync)   (ESourceCredentialsProviderImpl *provider_impl, ESource *source, GCancellable *cancellable, ENamedParameters **out_credentials, GError **error);
  has Pointer         $.store_sync;    #= gboolean (*store_sync)    (ESourceCredentialsProviderImpl *provider_impl, ESource *source, const ENamedParameters *credentials, gboolean permanently, GCancellable *cancellable, GError **error);
  has Pointer         $.delete_sync;   #= gboolean (*delete_sync)   (ESourceCredentialsProviderImpl *provider_impl, ESource *source, GCancellable *cancellable, GError **error);
}

# libedata-cal

class ECalBackendFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  has EBackendFactory $!parent;
  has Pointer         $!priv  ;
}

class EBackendFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EExtensionClass $.parent_class;

  has Pointer  $.get_hash_key;                # const gchar *   (*get_hash_key)         (EBackendFactory *factory);
  has Pointer  $.new_backend;                 # EBackend *      (*new_backend)          (EBackendFactory *factory, ESource *source);

  has EModule  $.e_module;
  has gboolean $.share_subprocess;

  HAS gpointer @.reserved[15]      is CArray;
};


class ECalBackendFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has EBackendFactoryClass $!parent_class  ;
  has gchar                $!factory_name  ;
  has icalcomponent_kind   $!component_kind;
  has GType                $!backend_type  ;
}

class ECalBackendSExp is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObject                $!parent;
  has Pointer $!priv  ;
}

class ECalBackendSExpClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObjectClass $!parent_class;
}

class ECalBackend is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EBackend $!parent;
  has Pointer  $!priv;
}

class ECalBackendSync is repr<CStruct> does GLib::Roles::Pointers is export {
  has ECalBackend            $!parent;
  has Pointer $!priv  ;
}

class ECalCache is repr<CStruct> does GLib::Roles::Pointers is export {
  has ECache           $!parent;
  has Pointer $!priv  ;
}

class ECalMetaBackend is repr<CStruct> does GLib::Roles::Pointers is export {
  has ECalBackendSync        $!parent;
  has Pointer $!priv  ;
}

class ECalMetaBackendInfo is repr<CStruct> does GLib::Roles::Pointers is export {
  has gchar $!uid     ;
  has gchar $!revision;
  has gchar $!object  ;
  has gchar $!extra   ;
}

class EDataCalClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObjectClass $!parent_class;
}

class EDataCalFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  has EDataFactory           $!parent;
  has Pointer $!priv  ;
}

class EDBusServerClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;

  has Str          $.bus_name;
  has Str          $.module_directory;

  has Pointer      $.bus_acquired;           # void                (*bus_acquired)         (EDBusServer *server, GDBusConnection *connection);
  has Pointer      $.bus_name_acquired;      # void                (*bus_name_acquired)    (EDBusServer *server, GDBusConnection *connection);
  has Pointer      $.bus_name_lost;          # void                (*bus_name_lost)        (EDBusServer *server, GDBusConnection *connection);
  has Pointer      $.run_server;             # EDBusServerExitCode (*run_server)           (EDBusServer *server);
  has Pointer      $.quit_server;            # void                (*quit_server)          (EDBusServer *server, EDBusServerExitCode code);

	has gpointer     @.reserved[14] is CArray;
}

class EDataFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS EDBusServerClass $.parent_class;
  has GType            $.backend_factory_type;
  has Str              $.factory_object_path;
  has Str              $.data_object_path_prefix;
  has Str              $.subprocess_object_path_prefix;
  has Str              $.subprocess_bus_name_prefix;

  has Pointer          $.get_dbus_interface_skeleton;   # GDBusInterfaceSkeleton * (*get_dbus_interface_skeleton) (EDBusServer *server);
  has Pointer          $.get_factory_name;              # const gchar *   (*get_factory_name)     (EBackendFactory *backend_factory);
  has Pointer          $.complete_open;                 # void            (*complete_open)        (EDataFactory *data_factory, GDBusMethodInvocation *invocation, const gchar *object_path, const gchar *bus_name, const gchar *extension_name);
  has Pointer          $.create_backend;                # EBackend *      (* create_backend)      (EDataFactory *data_factory, EBackendFactory *backend_factory, ESource *source);
  has Pointer          $.open_backend;                  # gchar *         (* open_backend)        (EDataFactory *data_factory, EBackend *backend, GDBusConnection *connection, GCancellable *cancellable, GError **error);

  HAS gpointer         @.reserved[13] is CArray;
}


class EDataCalFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has EDataFactoryClass $!parent_class;
}

class EDataCalView is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObject             $!parent;
  has Pointer $!priv  ;
}

class EDataCalViewClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObjectClass $!parent_class;
}

class EIntervalTree is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObject              $!parent;
  has Pointer $!priv  ;
}

class EIntervalTreeClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has GObjectClass $!parent_class;
}

class ESubprocessCalFactory is repr<CStruct> does GLib::Roles::Pointers is export {
  has ESubprocessFactory $!parent;
  has Pointer            $!priv  ;
}

class ESubprocessFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObjectClass $.parent_class;
  # Virtual Methods
  has Pointer      $.ref_backend;     # EBackend * (*ref_backend)          (ESourceRegistry *registry, ESource *source, const gchar *backend_factory_type_name);
  has Pointer      $.open_data;       # gchar *    (*open_data)            (ESubprocessFactory *subprocess_factory, EBackend *backend, GDBusConnection *connection, gpointer data, GCancellable *cancellable, GError **error);
	# Signals
  has Pointer      $.backend_created; # void       (*backend_created)      (ESubprocessFactory *subprocess_factory, EBackend *backend);
  has Pointer      $.backend_closed;  # void       (*backend_closed)       (ESubprocessFactory *subprocess_factory, EBackend *backend);
}

class ESubprocessCalFactoryClass is repr<CStruct> does GLib::Roles::Pointers is export {
  has ESubprocessFactoryClass $!parent_class;
}

class ESExpResultValue is repr<CUnion> does GLib::Roles::Pointers is export {
  has GPtrArray $!ptrarray;
  has gint      $.number   is rw;
  has gchar     $!string;
  has gint      $.boolean  is rw;
  has time_t    $.time     is rw;

	method ptrarray is rw {
		Proxy.new:
			FETCH => -> $                 { $!ptrarray       },
			STORE => -> $, GPtrArray() $p { $!ptrarray := $p };
	}

	method string is rw {
		Proxy.new:
			FETCH => -> $,          { $!string       },
			STORE => -> $, Str() $s { $!string := $s };
	}
}

class ESExpResult is repr<CStruct> does GLib::Roles::Pointers is export {
	has ESExpResultType  $.type;
	HAS ESExpResultValue $.value;
	has gboolean         $.time_generator;
	has time_t           $.occuring_start;
	has time_t           $.occuring_end;
}

# &ESExpFunc(ESExp, gint, CArray[Pointer[ESExpResult]], gpointer)
# &ESExpFuncI(ESExp, gint, CArray[Pointer[ESExpTerm]], gpointer)

class ESExpFunc is repr<CUnion> is export {
  has Pointer $!func;  #= fp:ESExpFunc
  has Pointer $!ifunc; #= fp:ESExpIFunc
}

class ESExpSymbol is repr<CStruct> is export {
  has gint       $.type is rw; #= vv:(ESEXP_TERM_FUNC, ESEXP_TERM_VAR)
  has Str        $!name      ;
  has gpointer   $!data      ;
  HAS ESExpFunc  $!f         ;
}

my %terms-cache;
class ESExpTermValue is repr<CUnion> is export {
  has Str          $.string  is rw;
  has gint         $.number  is rw;
  has gint         $.boolean is rw;
  has time_t       $.time    is rw;
  HAS ESExpFunc    $.func         ;
  has ESExpSymbol  $!var          ;
}

class ESExpTerm is repr<CStruct> is export {
  has ESExpTermType  $.type    is rw;
  HAS ESExpTermValue $.value        ;
}

class ESExpValueFunc {
  has ESExpSymbol                $!sym            ;
  has CArray[Pointer[ESExpTerm]] $!terms          ; #= sa:$!termcount
  has gint                       $.termcount is rw;

  method terms {
    unless %terms-cache{ self.WHERE } {
      %terms-cache{ self.WHERE } = SizedCArray.new($!terms, $!termcount);
    }
    %terms-cache{ self.WHERE }
  }
}

class EDataCal is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $.parent;
  has Pointer $!priv;
}

BEGIN {
	buildAccessors($_) for
												 EPhotoData,
												 #EPhotoDataInlined,
	                       EContactAddress,
												 #EContactCert,
												 EContactName,
                         ECalComponentId;
}
