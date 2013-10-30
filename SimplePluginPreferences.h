//
//  SimplePluginPreferences.h
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import <NSPreferences.h>
#import <AppKit/AppKit.h>
#import "NSPreferencesModule.h"

@interface SimplePluginPreferences : NSPreferencesModule {}

@property (nonatomic, assign) IBOutlet NSView *view_preferences;

@end
