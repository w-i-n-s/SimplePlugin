/*
 *     Generated by class-dump 3.3.3 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2010 by Steve Nygard.
 */


#import "MessageContentDisplay-Protocol.h"
#import "DocumentEditorManaging-Protocol.h"

@class ActivityMonitor, BannerController, EmbeddedNoteDocumentEditor, MFTaskOperation, Message, MessageContentView, MessageViewingPaneController, MessageViewingState, NSArray, NSMutableDictionary, NSSet, NSView;

@interface MessageContentController : NSResponder <DocumentEditorManaging, NSCopying>
{
    Message *_message;
    ActivityMonitor *_documentMonitor;
    ActivityMonitor *_urlificationMonitor;
    MessageViewingPaneController *_parentController;
    NSSet *_allMessagesInConversation;
    NSArray *_selectedMailboxes;
    Message *_parentMessageUsedForRedundantTextIdentification;
    MFTaskOperation *_loadOperation;
    id <MessageContentDisplay> _messageContentDisplay;
    MessageContentView *_messageContentView;
    double _foregroundLoadStartTime;
    double _backgroundLoadStartTime;
    double _backgroundLoadEndTime;
    double _webViewLoadStartTime;
    BOOL _isForPrinting;
    BOOL _showDefaultHeadersStickily;
    MessageViewingState *_stickyViewingState;
    MessageViewingState *_viewingState;
    NSMutableDictionary *_editorCache;
    EmbeddedNoteDocumentEditor *_currentEditor;
    BannerController *_bannerController;
    double _preferredHeight;
    double _accumulatedMagnification;
    double _displayWidth;
    BOOL _canZoomIn;
    BOOL _canZoomOut;
    BOOL _isSelected;
    BOOL _isActiveSelection;
    BOOL _shouldDisplayShowInMailboxLink;
    BOOL _shouldLoadMessageDisplay;
    unsigned long long _numberOfDuplicates;
    BOOL _finishedLoadingMessageContent;
    BOOL _displayAsSingleMessage;
    BOOL _hasSetupMessageDisplay;
    BOOL _hasSetupMessageBody;
    BOOL _isVisible;
    unsigned long long _messageNumber;
    long long _relatedMessageType;
    NSView *_viewForAccessibilityLinks;
}

+ (id)_loadQueue;
- (id)initWithAllMessagesInConversation:(id)arg1 selectedMailboxes:(id)arg2;
- (id)description;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)documentEditors;
- (void)registerDocumentEditor:(id)arg1;
- (void)unregisterDocumentEditor:(id)arg1;
@property BOOL displayAsSingleMessage;
@property BOOL isSelected;
- (BOOL)isActiveSelection;
- (void)setIsActiveSelection:(BOOL)arg1;
@property BOOL isForPrinting;
@property(retain, nonatomic) NSMutableDictionary *editorCache;
- (void)release;
- (void)_resetContentViewData;
- (void)tearDown;
- (void)contentViewWillBeRemoved;
- (void)contentViewWasAdded;
- (void)dealloc;
- (void)_stopBackgroundMessageLoading:(BOOL)arg1 URLification:(BOOL)arg2 dataDetection:(BOOL)arg3;
- (void)cancelDataDetection;
@property(retain, nonatomic) MessageContentView *messageContentView;
- (BOOL)isSecondaryMessage;
@property unsigned long long numberOfDuplicates;
- (void)stopAllActivity;
- (id)documentView;
- (id)viewForKeyViewLoop;
- (BOOL)shouldManageQuotedContent;
- (void)makeMessageBeFirstResponder;
- (void)_updateIfDisplayingMessage:(id)arg1;
@property(retain) MessageViewingState *viewingState;
- (void)_fetchDataForMessageAndUpdateDisplay:(id)arg1;
- (void)_messageMayHaveBecomeAvailable;
- (void)_doUrlificationAndDataDetectionForViewingState:(id)arg1;
- (void)_backgroundLoadFinished:(id)arg1;
- (void)setMessageToDisplay:(id)arg1;
- (void)substituteMessage:(id)arg1;
- (void)_setMessage:(id)arg1;
- (void)_fetchEditorForMessage:(id)arg1 viewingState:(id)arg2;
- (void)editorDidLoad:(id)arg1;
- (void)editorFailedLoad:(id)arg1;
- (id)_existingEditor:(Class)arg1 forDocument:(id)arg2;
- (id)_messageInConversationWithMessageIDHeaderString:(id)arg1;
- (id)_mostRecentAncestorForRedundantTextComparisonForMessage:(id)arg1;
- (BOOL)_ancestorMessageIsValidForRedundantTextComparison:(id)arg1;
- (id)_messageForFinalizingHtmlContentWithViewingState:(id)arg1;
- (void)_finalizeHtmlContentForDisplayWithViewingState:(id)arg1 originalMessage:(id)arg2;
- (void)setMessageContentIsVisible:(BOOL)arg1;
- (void)_asyncFetchContentsForMessage:(id)arg1 withViewingState:(id)arg2;
- (void)_startBackgroundLoad:(id)arg1;
- (void)reloadCurrentMessageShouldReparseBody:(BOOL)arg1;
- (void)_viewerPreferencesChanged:(id)arg1;
@property BOOL shouldDisplayShowInMailboxLink;
- (void)showAllCopiesOfMessage;
- (long long)messageNumber;
- (void)setMessageNumber:(long long)arg1;
@property(nonatomic) long long relatedMessageType;
- (void)_addRecentAddress:(id)arg1;
- (void)_messageFlagsDidChange:(id)arg1;
- (void)_messagesDidUpdate:(id)arg1;
- (void)closeEditors;
- (id)editorForNote:(id)arg1 willLoad:(char *)arg2;
- (void)_updateEditorDisplay;
- (id)_dataDetectorsContextForMessage:(id)arg1;
@property(readonly) BOOL hasBeenToldToLoadHeadersAndBody;
- (void)loadMessageDisplayIncludeBody:(BOOL)arg1;
- (void)_webViewLoadTimeout;
@property(nonatomic) BOOL hasSetupMessageBody;
- (void)_displayMessageLoadBody:(BOOL)arg1;
- (void)_loadMessageBody;
- (void)_setupMessageContentDisplayLoadBody:(BOOL)arg1;
- (void)_displayChanged;
@property(nonatomic) BOOL finishedLoadingMessageContent;
- (void)prepareForRedundantTextExpansionAnimationWithTopYPosition:(double)arg1 bottomYPosition:(double)arg2 foldYPosition:(double)arg3 foldIsAtBottom:(BOOL)arg4;
- (void)_editorClosed:(id)arg1;
@property(retain, nonatomic) EmbeddedNoteDocumentEditor *currentEditor;
- (void)highlightSearchText:(id)arg1;
- (id)selectedText;
- (id)selectionParsedMessage;
- (id)attachmentsInSelection;
- (id)parsedMessage;
- (long long)headerDetailLevel;
- (BOOL)showingAllHeaders;
- (void)setShowAllHeaders:(BOOL)arg1;
- (void)downloadRemoteContent;
- (BOOL)remoteAttachmentsAreDownloaded;
- (void)makeStickyInfoFromViewingState:(id)arg1;
- (void)keyDown:(id)arg1;
- (void)_resetGestureState;
- (void)beginGestureWithEvent:(id)arg1;
- (void)endGestureWithEvent:(id)arg1;
- (void)magnifyWithEvent:(id)arg1;
- (void)messageContentViewWasClicked;
- (void)setUpAccessibilityLinksFromView:(id)arg1;
- (void)removeAccessibilityLinks;
- (id)findTarget;
- (void)showAllHeaders:(id)arg1;
- (void)showFilteredHeaders:(id)arg1;
- (void)viewSource:(id)arg1;
- (void)showFirstAlternative:(id)arg1;
- (void)showPreviousAlternative:(id)arg1;
- (void)showNextAlternative:(id)arg1;
- (void)_messageWouldHaveLoadedRemoteURL:(id)arg1;
- (void)showBestAlternative:(id)arg1;
- (void)changeTextEncoding:(id)arg1;
- (void)makeFontBigger:(id)arg1;
- (void)makeFontSmaller:(id)arg1;
- (void)jumpToSelection:(id)arg1;
- (void)takeFindStringFromSelection:(id)arg1;
- (id)headerSnapshot;
- (id)bodySnapshotWithSize:(struct CGSize)arg1;
- (struct CGSize)visibleBodySize;
- (BOOL)isHeaderViewFullyVisible;
- (id)viewWhereMessageIsDisplayed;
- (id)viewWhereMessageExists;
- (id)messageViewer;
- (void)saveAttachments:(id)arg1;
- (void)saveAttachmentsWithoutPrompting:(id)arg1;
@property double displayWidth; // @synthesize displayWidth=_displayWidth;
@property double preferredHeight; // @synthesize preferredHeight=_preferredHeight;
@property(retain) Message *parentMessageUsedForRedundantTextIdentification; // @synthesize parentMessageUsedForRedundantTextIdentification=_parentMessageUsedForRedundantTextIdentification;
@property(readonly, retain, nonatomic) NSArray *selectedMailboxes; // @synthesize selectedMailboxes=_selectedMailboxes;
@property(readonly, retain, nonatomic) NSSet *allMessagesInConversation; // @synthesize allMessagesInConversation=_allMessagesInConversation;
@property(assign) MessageViewingPaneController *parentController; // @synthesize parentController=_parentController;
@property(retain, nonatomic) Message *message; // @synthesize message=_message;
@property(retain) ActivityMonitor *urlificationMonitor; // @synthesize urlificationMonitor=_urlificationMonitor;
@property(retain) ActivityMonitor *documentMonitor; // @synthesize documentMonitor=_documentMonitor;
@property(retain) id <MessageContentDisplay> messageContentDisplay; // @synthesize messageContentDisplay=_messageContentDisplay;

@end

