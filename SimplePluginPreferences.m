//
//  SimplePluginPreferences.m
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import "SimplePluginPreferences.h"
#import "SimplePluginBundle.h"

@implementation SimplePluginPreferences

- (SimplePluginBundle *)bundle {
	return [SimplePluginBundle sharedInstance];
}

- (NSImage *)imageForPreferenceNamed:(NSString *)aName {
    
    NSImage *image = [NSImage imageNamed:@"SimplePluginPreferences"];
	return image;
}

- (NSString *)copyright {
	return [[SimplePluginBundle bundle] infoDictionary][@"NSHumanReadableCopyright"];
}

- (void)willBeDisplayed {
	
    //something check etc..
}

- (BOOL)isResizable {
	return NO;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (NSView *)preferencesView
{
	if (!_view_preferences)
		[NSBundle loadNibNamed:[self preferencesNibName] owner:self];
	return _view_preferences;
}

- (id) viewForPreferenceNamed:(NSString *)aName
{
#pragma unused(aName)
	return [self preferencesView];
}

@end
