//
//  SimplePluginBundle.h
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import <CoreFoundation/CoreFoundation.h>

@interface SimplePluginBundle : NSObject<NSToolbarDelegate> {
    
    NSMutableArray *_bundleImages;
}

//Returns the bundle
+ (NSBundle *)bundle;

// Returns the bundle version.
+ (NSString *)bundleVersion;

//Returns the version
- (NSString *)version;
// Load all necessary images.
- (void)_loadImages;

//Plugin preferences
+ (BOOL)hasPreferencesPanel;
+ (id)preferencesOwnerClassName;
+ (id)preferencesPanelName;

@end

@interface SimplePluginBundle (NoImplementation)
// Prevent "incomplete implementation" warning.
+ (id)sharedInstance;
@end


