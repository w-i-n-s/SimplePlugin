//
//  SimplePluginOptions.h
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import <Foundation/Foundation.h>

@interface SimplePluginOptions : NSObject

+ (id)sharedOptions;
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

@end
