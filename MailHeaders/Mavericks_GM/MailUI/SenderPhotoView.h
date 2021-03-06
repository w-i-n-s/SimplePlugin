/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import "NSImageView.h"

@class NSLayoutConstraint;

@interface SenderPhotoView : NSImageView
{
    NSLayoutConstraint *_widthConstraint;
    NSLayoutConstraint *_heightConstraint;
    unsigned long long _photoSize;
}

@property(nonatomic) unsigned long long photoSize; // @synthesize photoSize=_photoSize;
@property(retain, nonatomic) NSLayoutConstraint *heightConstraint; // @synthesize heightConstraint=_heightConstraint;
@property(retain, nonatomic) NSLayoutConstraint *widthConstraint; // @synthesize widthConstraint=_widthConstraint;
- (void)drawRect:(struct CGRect)arg1;
- (BOOL)isOpaque;
- (void)updateConstraints;
- (void)dealloc;
- (void)_senderPhotoViewCommonInit;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;

@end

