//
//  SimplePluginOptions.m
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import "SimplePluginOptions.h"

@implementation SimplePluginOptions{
    id _userDefaults;
    NSMutableDictionary *_defaults;
}

#define kUSER_DEFAULTS_KEY   @"SimplePluginSettings"

+ (id)sharedOptions {
    static dispatch_once_t onceToken;
    static SimplePluginOptions *_sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SimplePluginOptions alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
	self = [super init];
    if(self) {
        
        _userDefaults = [NSUserDefaults standardUserDefaults];
        [_userDefaults synchronize];
        
        _defaults = [[NSMutableDictionary alloc] initWithDictionary:[_userDefaults objectForKey:kUSER_DEFAULTS_KEY]];
        
    }
	return self;
}

//User defaults load/save
- (id)valueForKey:(NSString *)key {
    
	return [_defaults objectForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [_defaults setValue:value forKey:key];
    [_userDefaults setValue:_defaults forKey:kUSER_DEFAULTS_KEY];
    [_userDefaults synchronize];
}

@end
