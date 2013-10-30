//
//  NSToolbar+SimplePlugin.m
//  SimplePlugin
//
//  Created by Sergey Vinogradov on 30.10.13.
//
//

#import "NSToolbar+SimplePlugin.h"
#import <AppKit/NSToolbar.h>

@implementation NSToolbar (SimplePlugin)

- (id)SPConfigureToolbarItems{
    
    id result = [self SPConfigureToolbarItems];
    NSString* tbName = [self identifier];
    NSArray * toolbarArray;

    NSString *itemAtRightFromDefaults = @"";
    
    if ([tbName isEqualToString:@"MainWindow"] ){
        
        //check presenting of buttons
        
        NSDictionary *segment1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"1",@"segmented",
                                  @"Help for simple button",@"help",
                                  @"doSomething:",@"identifier",//must define in MessageViewer_SimplePlugin:NSObject
                                  @"SimplePluginPreferences",@"image",
                                  @"9000",@"tag",
                                  @"Do something",@"title",
                                  @"First",@"paletteLabel",
                                  @"Hidden title",@"altTitle",
                                  nil];
        NSDictionary *segment2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"1",@"segmented",
                                  @"Help for simple button",@"help",
                                  @"doSomethingOther:",@"identifier",//must define in MessageViewer_SimplePlugin:NSObject
                                  //@"SimplePluginPreferences",@"image",
                                  @"9010",@"tag",
                                  @"Do something",@"title",
                                  @"Second",@"paletteLabel",
                                  @"Hidden title",@"altTitle",
                                  nil];
        
        NSArray *listOfSegments = [NSArray arrayWithObjects:
                                   segment1,
                                   segment2,
                                   nil];
        NSDictionary *buttonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"powerbotSendToEvernote",@"identifier",
                                    @"1",@"segmented",
                                    listOfSegments,@"segments",
                                    nil];
        
        toolbarArray = [NSArray arrayWithObjects:buttonDict,nil];
        
        itemAtRightFromDefaults = @"Search";
        
    }else{
            toolbarArray = [NSArray array];
            
            /*
             NSDictionary *buttonDict = [NSDictionary dictionaryWithObjectsAndKeys:
             @"1",@"segmented",
             tbName,@"help",
             @"anotherSelector:",@"identifier",//must define in ..._SimplePlugin:NSObject
             @"prettyImage",@"image",
             @"9999",@"tag",
             @"Title",@"title",
             @"Palette title",@"paletteLabel",
             @"Alt title",@"altTitle",
             nil];
             toolbarArray = [NSArray arrayWithObjects:
             buttonDict,
             nil];
             */
        }
    
    NSInteger itemsCount = [toolbarArray count];
    
    if(itemsCount){
        
        NSInteger i;
        
        NSArray *defaultItems = [result objectForKey:@"DefaultToolbarItems"];
        
        NSInteger index = [defaultItems indexOfObject:itemAtRightFromDefaults];
        
        //Add gap to defaults
        [[result objectForKey:@"DefaultToolbarItems"] insertObject:@"NSToolbarSpaceItem"
                                                           atIndex:index-1];
        
        
        for (i=0;i<itemsCount; i++){
            
            id identifier = [[toolbarArray objectAtIndex:i] objectForKey:@"identifier"];
            
            [result setObject: [toolbarArray objectAtIndex:i] forKey: identifier];
            
            //all
            if(![[result objectForKey:@"AllToolbarItems"] containsObject:identifier])
                [[result objectForKey:@"AllToolbarItems"] addObject:identifier];
            
            //defaults
            if(![[result objectForKey:@"DefaultToolbarItems"] containsObject:identifier])
                [[result objectForKey:@"DefaultToolbarItems"] insertObject:identifier
                                                                   atIndex:index-1];
        }
    }
    
    return result;
}

@end
