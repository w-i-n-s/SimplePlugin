//
//  SimplePluginBundle.m
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import "SimplePluginBundle.h"

#import "SimplePluginPreferences.h"
#import "NSToolbar+SimplePlugin.h"

#import "MVMailBundle.h"

#import <objc/message.h>
#import <objc/runtime.h>
#import "JRLPSwizzle.h"

@implementation SimplePluginBundle

#pragma mark - Init, dealloc etc.

+ (void)initialize {

    if(self != [SimplePluginBundle class])
        return;
    
    Class mvMailBundleClass = NSClassFromString(@"MVMailBundle");
    // If this class is not available that means Mail.app
    // doesn't allow plugins anymore. Fingers crossed that this
    // never happens!
    if(!mvMailBundleClass)
        return;
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated"
    class_setSuperclass([self class], mvMailBundleClass);
#pragma GCC diagnostic pop
    
    // Initialize the bundle by swizzling methods, loading keys, ...
    SimplePluginBundle *instance = [SimplePluginBundle sharedInstance];
    
    //swizzle, old style
    {
        const NSString *swizzleClassName = @"SimplePluginClass";
        NSArray *swizzleMap = [NSArray arrayWithObjects:
                               //preferences
                               [NSDictionary dictionaryWithObjectsAndKeys:
                                @"NSPreferences", @"class",
                                [NSArray arrayWithObjects:
                                 @"sharedPreferences",
                                 @"windowWillResize:toSize:",
                                 @"toolbarItemClicked:",
                                 @"showPreferencesPanelForOwner:",
                                 nil], @"selectors", nil],
                               //toolbar
                               [NSDictionary dictionaryWithObjectsAndKeys:
                                @"NSToolbar",@"class",
                                [NSArray arrayWithObjects:
                                 @"configureToolbarItems",
                                 nil],@"selectors",nil],
                               nil];
        
        NSError *error = nil;
        for(NSDictionary *swizzleInfo in swizzleMap) {

            Class mailClass = NSClassFromString([swizzleInfo objectForKey:@"class"]);
            if([swizzleInfo objectForKey:swizzleClassName]) {
                Class PowerbotMailClass = NSClassFromString([swizzleInfo objectForKey:swizzleClassName]);
                if(!mailClass) {
                    NSLog(@"WARNING: Class %@ doesn't exist. Powerbot might behave weirdly!", [swizzleInfo objectForKey:@"class"]);
                    continue;
                }
                if(!PowerbotMailClass) {
                    NSLog(@"WARNING: Class %@ doesn't exist. Powerbot might behave weirdly!", [swizzleInfo objectForKey:@"PowerbotClass"]);
                    continue;
                }
                [mailClass jrlp_addMethodsFromClass:PowerbotMailClass error:&error];
                if(error)
                    NSLog(@"[DEBUG] %s Error: %@", __PRETTY_FUNCTION__, error);
                error = nil;
            }
            for(NSString *method in [swizzleInfo objectForKey:@"selectors"]) {
                error = nil;
                NSString *PowerbotMethod = [NSString stringWithFormat:@"SP%@%@",
                                            [[method substringToIndex:1] uppercaseString],
                                            [method substringFromIndex:1]];
                
                [mailClass jrlp_swizzleMethod:NSSelectorFromString(method)
                                   withMethod:NSSelectorFromString(PowerbotMethod)
                                        error:&error];
                if(error) {
                    error = nil;
                    // Try swizzling as class method on error.
                    [mailClass jrlp_swizzleClassMethod:NSSelectorFromString(method)
                                       withClassMethod:NSSelectorFromString(PowerbotMethod)
                                                 error:&error];
                    if(error)
                        NSLog(@"[DEBUG] %s Class Error: %@", __PRETTY_FUNCTION__, error);
                }
            }
        }
    }

    
    [[((MVMailBundle *)self) class] registerBundle];             // To force registering composeAccessoryView and preferences
}

- (id)init {
	if (self = [super init]) {
		NSLog(@"Loaded SimplePlugin %@", [self version]);
        
        // Load all necessary images.
        [self _loadImages];
        
        // Inject the plugin code.
#warning TODO1
//        [SimplePluginInjector injectUsingMethodPrefix:GPGMailSwizzledMethodPrefix];
	}
    
	return self;
}

- (void)dealloc {

}

- (void)_loadImages {
    /**
     * Loads all images which are used in the User interface.
     */
    // We need to load images and name them, because all images are searched by their name; as they are not located in the main bundle,
	// +[NSImage imageNamed:] does not find them.
	NSBundle *myBundle = [SimplePluginBundle bundle];
    
    [(NSImage *)[[NSImage alloc] initByReferencingFile:[myBundle pathForImageResource:@"teapotPreferences"]] setName:@"SimplePluginPreferences"];
    
    NSArray *bundleImageNames = @[@"GreenDot",
                                  @"YellowDot",
                                  @"RedDot"];
    
    NSMutableArray *bundleImages = [[NSMutableArray alloc] initWithCapacity:[bundleImageNames count]];
    
    for (NSString *name in bundleImageNames) {
        NSImage *image = [[NSImage alloc] initByReferencingFile:[myBundle pathForImageResource:name]];
        
        // Shoud an image not exist, log a warning, but don't crash because of inserting
        // nil!
        if(!image) {
            NSLog(@"GPGMail: Image %@ not found in bundle resources.", name);
            continue;
        }
        [image setName:name];
        [bundleImages addObject:image];
    }
    
    _bundleImages = bundleImages;
    
}

#pragma mark - General Infos

+ (NSBundle *)bundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleForClass:[SimplePluginBundle class]];
    });
    return bundle;
}

- (NSString *)version {
	return [[SimplePluginBundle bundle] infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString *)bundleVersion {
    /**
     Returns the version of the bundle as string.
     */
    return [[[SimplePluginBundle bundle] infoDictionary] valueForKey:@"CFBundleVersion"];
}

+ (NSNumber *)bundleBuildNumber {
    return [[[SimplePluginBundle bundle] infoDictionary] valueForKey:@"BuildNumber"];
}

#pragma mark - Preferences

+ (BOOL)hasPreferencesPanel {
    // LEOPARD Invoked on +initialize. Else, invoked from +registerBundle.
	return YES;
}

+ (NSString *)preferencesOwnerClassName {
    
	return NSStringFromClass([SimplePluginPreferences class]);
}

+ (NSString *)preferencesPanelName {
	return @"Simple plugin preferences";
}

@end
