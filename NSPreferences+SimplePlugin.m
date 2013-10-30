//
//  NSPreferences+SimplePlugin.m
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import "NSPreferences+SimplePlugin.h"
#import "SimplePluginPreferences.h"
#import "SimplePluginOptions.h"

//work with ivars
#import "NSObject+LPDynamicIvars.h"

#define kLastSelectedItem   @"MailPreferencesLastSelectedToolbarItem"
#define kPanel              @"_preferencesPanel"
#define kMakeAllVisible     @"makeAllToolbarItemsVisible"

@implementation NSPreferences (SimplePlugin)

+ (id)SPSharedPreferences {
	static BOOL added = NO;
	
	id preferences = [self SPSharedPreferences];
    
    if(preferences == nil)
        return nil;
    
    if(added)
        return preferences;
    
    // Check modules, if PowerbotPreferences is not yet in there.
    NSPreferencesModule *simplePluginPreferences = [SimplePluginPreferences sharedInstance];
    
    NSString *preferencesName = @"SimplePlugin";
    
    [preferences addPreferenceNamed:preferencesName owner:simplePluginPreferences];
    added = YES;
	
    NSWindow *preferencesPanel = [preferences valueForKey:kPanel];
    NSToolbar *toolbar = [preferencesPanel toolbar];
    // If the toolbar is nil, the setup will be done later by Mail.app.
    if(!toolbar)
        return preferences;
    
    BOOL simplePluginPreferencesToolbarExists = NO;
    // Mail Preferences is not able to restore to the Powerbot preference module
    // if it was last open.
    // That's why Powerbot saves the information of the last open one and restores it
    // on its own.
    NSToolbarItem *lastSelectedItem = nil;
    NSString *lastSelectedItemIdentifier = [[SimplePluginOptions sharedOptions] valueForKey:kLastSelectedItem];
    int i = 0;
    for(id item in [toolbar items]) {
        if((!lastSelectedItemIdentifier && i == 0) || [lastSelectedItemIdentifier isEqualToString:[item itemIdentifier]])
            lastSelectedItem = item;
        
        if([[item itemIdentifier] isEqualToString:preferencesName]) {
            simplePluginPreferencesToolbarExists = YES;
            break;
        }
        i++;
    }
    
    // If the Powerbot Preference toolbar item doesn't exist,
    // add it.
    if(!simplePluginPreferencesToolbarExists)
        [toolbar insertItemWithItemIdentifier:preferencesName atIndex:[[toolbar items] count]];
    
    // Make sure the preferences window shows all toolbar items.
    [preferences setIvar:kMakeAllVisible value:@(YES)];
    // If the preference window wasn't closed before Mail.app was shutdown
    // and the last preference module to be shown was Powerbot,
    // Mail.app doesn't show it automatically after restarting and restoring
    // the preference pane window.
    // In case of Powerbot being the last item, it's not in the toolbar yet
    // since it was just recently added. Use _selectModuleOwner to select it.
    if(!lastSelectedItem && [lastSelectedItemIdentifier isEqualToString:preferencesName]) {
        NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:preferencesName];
        [preferences toolbarItemClicked:toolbarItem];
    }
    else
        [preferences toolbarItemClicked:lastSelectedItem];
    // Force resizing of the window so that all toolbar items fit.
    [preferences resizeWindowToShowAllToolbarItems:preferencesPanel];
    
    return preferences;
}

- (CGSize)sizeForWindowShowingAllToolbarItems:(NSWindow *)window {
    NSRect frame = [window frame];
    NSToolbar *toolbar = [window toolbar];
    float width = 0.0f;
    for(id view in [[[[toolbar valueForKey:@"_toolbarView"] subviews] objectAtIndex:0] subviews])
        width += [(NSView *)view frame].size.width;
    // Add padding to fit them all.
    width += 10;
    CGSize newSize = CGSizeMake(width, frame.size.height);
    return newSize;
}

- (struct CGSize)SPWindowWillResize:(id)window toSize:(struct CGSize)toSize {
    if(![[self getIvar:kMakeAllVisible] boolValue])
        return [self SPWindowWillResize:window toSize:toSize];
    
    CGSize newSize = [self sizeForWindowShowingAllToolbarItems:window];
    [self removeIvar:kMakeAllVisible];
    return newSize;
}

- (void)resizeWindowToShowAllToolbarItems:(NSWindow *)window {
    NSRect frame = [window frame];
    CGSize newSize = [self sizeForWindowShowingAllToolbarItems:window];
    frame.size = NSSizeFromCGSize(newSize);
    [self setIvar:kMakeAllVisible value:@(YES)];
    [window setFrame:frame display:YES];
}

- (void)SPToolbarItemClicked:(id)toolbarItem {
    // Resize the window, otherwise it would make it small
    // again.
    [[SimplePluginOptions sharedOptions] setValue:[toolbarItem itemIdentifier] forKey:kLastSelectedItem];
    [self SPToolbarItemClicked:toolbarItem];
    [self resizeWindowToShowAllToolbarItems:[self valueForKey:kPanel]];
}

- (void)SPShowPreferencesPanelForOwner:(id)owner {
    [self SPShowPreferencesPanelForOwner:owner];
    [self resizeWindowToShowAllToolbarItems:[self valueForKey:kPanel]];
}

@end
