//
//  NSPreferences+SimplePlugin.h
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import <NSPreferences.h>

@interface NSPreferences (SimplePlugin)

+ (id)SPSharedPreferences;

/**
 Returns the window size necessary to fit all toolbar items.
 */
- (CGSize)sizeForWindowShowingAllToolbarItems:(NSWindow *)window;

/**
 Is called when the preference pane is first shown, or the user
 resizes the preference pane.
 If a use resizes the preference pane, the original method is invoked.
 If the preference is first shown, it calulcates the size needed to fit
 all toolbar items using -[NSPreferences(Powerbot)sizeForWindowShowingAllToolbarItems:]
 and returns that value, so the window is correctly resized.
 */
- (struct CGSize)SPWindowWillResize:(id)window toSize:(struct CGSize)toSize;

/**
 Helper function to resize the preference pane window to fit all
 toolbar items.
 */
- (void)resizeWindowToShowAllToolbarItems:(NSWindow *)window;

/**
 Is called whenever the user clicks on a toolbar item.
 This also resizes the window, which is why internally
 -[NSPreferences(Powerbot) resizeWindowToShowAllToolbarItems:]
 is called, to force the window to resize again to fit all toolbar items.
 */
- (void)SPToolbarItemClicked:(id)toolbarItem;

/**
 Is called whenever the preference pane is displayed.
 This also resizes the window, which is why internally
 -[NSPreferences(Powerbot) resizeWindowToShowAllToolbarItems:]
 is called, to force the window to resize again to fit all toolbar items.
 */
- (void)SPShowPreferencesPanelForOwner:(id)owner;

@end
