/*
 The contents of this file are subject to the Mozilla Public License
 Version 1.1 (the "License"); you may not use this file except in
 compliance with the License. You may obtain a copy of the License at
 http://www.mozilla.org/MPL/
 
 The Initial Developer of the Original Code is Hollrr, LLC.
 Portions created by the Initial Developer are Copyright (C) 2011
 the Initial Developer. All Rights Reserved.
 
 Contributor(s):
 
 Nate Lyman <nlyman@natesite.com>
 Traun Leyden <tleyden@signature-app.com>
 
 */


#import "SmartAlert.h"

static const NSString * kSmartAlertAlertKey = @"alert";
static const NSString * kSmartAlertMessagesKey = @"messages";

@interface SmartAlert() 
+ (void) showNewAlert:(NSString *)alert forKey:(NSString *)key;
- (BOOL)objectIsNillOrAnNSNull:(id)object;
@end


@implementation SmartAlert

@synthesize alerts,title,maxMessages;

#pragma mark - Public

+ (void) showAlert:(NSString *)theAlert forKey:(NSString *)theKey {
    SmartAlert *smartAlertInstance = [SmartAlert shared];
  
    if(theKey == nil) 
    {
      theKey = @"";
    }
    
    
    id object = [[smartAlertInstance alerts] objectForKey:theKey];
    if([smartAlertInstance objectIsNillOrAnNSNull:object] == YES){
        
        // Fire off a new alert
        [SmartAlert showNewAlert:theAlert forKey:theKey];
        
    }else{
        NSMutableDictionary *alert = (NSMutableDictionary *)object;
        
        SmartAlertView *alertView = [alert objectForKey:kSmartAlertAlertKey];
        
        NSMutableDictionary *messages = [alert objectForKey:kSmartAlertMessagesKey];
        
        id message = [messages objectForKey:theAlert];
        if([smartAlertInstance objectIsNillOrAnNSNull:message] == YES) {
            
            // New Message
            [messages setObject:[NSNumber numberWithInt:1] forKey:theAlert];
            
        }else{
            
            NSNumber *count = (NSNumber *)message;
            count = [NSNumber numberWithInt:[count intValue]+1];
            [messages setObject:count forKey:theAlert];
            
        }
        
        [alertView queueMessages:messages];
        
        [alert setObject:alertView forKey:kSmartAlertAlertKey];
        
        [[smartAlertInstance alerts] setObject:alert forKey:theKey];
        
    }

}




#pragma mark - SmartAlertViewDelegate
- (void) alertView:(SmartAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex {
    
  static NSInteger kCancelButtonIndex = 0;
    if(theButtonIndex == kCancelButtonIndex){ // Cancel
        [self.alerts removeAllObjects];
    }
}

- (void) alertViewCancel:(SmartAlertView *)alertView {
    NSLog(@"Cancel");
}



#pragma mark - Private
// Method creates a new SmartAlertView object
+ (void) showNewAlert:(NSString*)theAlert forKey:(NSString *)theKey {
    SmartAlert *smartAlertInstance = [SmartAlert shared];  
    if(theKey == nil) 
    {
      theKey = @"";
    }
    
    // Pull object
    id test = [[smartAlertInstance alerts] objectForKey:theKey];
    if([smartAlertInstance objectIsNillOrAnNSNull:test] == YES){
        
        NSMutableDictionary *alert = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *messages = [NSMutableDictionary dictionary];
        
        [messages setObject:[NSNumber numberWithInt:1] forKey:theAlert];
        
        SmartAlertView *alertView = [[SmartAlertView alloc] initWithTitle:smartAlertInstance.title message:@"" delegate:smartAlertInstance cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alertView setMaxMessages:smartAlertInstance.maxMessages];
        
        [alertView queueMessages:messages];
        [alertView show];
        
        [alert setObject:alertView forKey:kSmartAlertAlertKey];
        [alert setObject:messages forKey:kSmartAlertMessagesKey];
        
        [[smartAlertInstance alerts] setObject:alert forKey:theKey];
        
        [alertView release];
    }
    
    
}


- (BOOL)objectIsNillOrAnNSNull:(id)theObject
{
  BOOL objectIsNil = (theObject == nil);
  BOOL objectClassIsNSNull = ([theObject isKindOfClass:[NSNull class]]);
  return (objectIsNil || objectClassIsNSNull);
}


#pragma mark - Singleton Methods
+ (id)shared {
  static dispatch_once_t pred;
	static SmartAlert *sharedInstance = nil;
  
	dispatch_once(&pred, ^{ sharedInstance = [[SmartAlert alloc] init]; });
  
	return sharedInstance;
}

#pragma mark - Memory / Init
- (id)init {
    if ((self = [super init])) {
        alerts = [[NSMutableDictionary alloc] init];
        title = [[NSString alloc] initWithString:NSLocalizedString(@"SmartAlert", nil)];
        maxMessages = 5;
    }
    return self;
}
- (void)dealloc {    
    [alerts release]; alerts = nil;
    [title release]; title = nil;
    [super dealloc];
}


@end
