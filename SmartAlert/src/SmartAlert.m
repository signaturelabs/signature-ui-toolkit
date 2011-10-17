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

static SmartAlert *shared = nil;

@interface SmartAlert() 
+ (void) showNewAlert:(NSString*)alert forKey:(NSString *)key;
@end


@implementation SmartAlert

@synthesize alerts,title,maxMessages;

#pragma mark - Public

+ (void) showAlert:(NSString *)_alert forKey:(NSString *)key {
    SmartAlert *sa = [SmartAlert shared];
    if(key == nil) key = @"";
    
    id object = [sa.alerts objectForKey:key];
    if(object == nil || [object isKindOfClass:[NSNull class]]){
        
        // Fire off a new alert
        [SmartAlert showNewAlert:_alert forKey:key];
        
    }else{
        NSMutableDictionary *alert = (NSMutableDictionary *)object;
        
        SmartAlertView *alertView = [alert objectForKey:@"alert"];
        
        NSMutableDictionary *messages = [alert objectForKey:@"messages"];
        
        id message = [messages objectForKey:_alert];
        if(message == nil || [message isKindOfClass:[NSNull class]]){
            
            // New Message
            [messages setObject:[NSNumber numberWithInt:1] forKey:_alert];
            
        }else{
            
            NSNumber *count = (NSNumber *)message;
            count = [NSNumber numberWithInt:[count intValue]+1];
            [messages setObject:count forKey:_alert];
            
        }
        
        [alertView setMessages:messages];
        
        [alert setObject:alertView forKey:@"alert"];
        
        [sa.alerts setObject:alert forKey:key];
        
    }

}




#pragma mark - SmartAlertViewDelegate
- (void) alertView:(SmartAlertView *)_alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0){ // Cancel
        [self.alerts removeAllObjects];
    }
}

- (void) alertViewCancel:(SmartAlertView *)alertView {
    NSLog(@"Cancel");
}



#pragma mark - Private
// Method creates a new SmartAlertView object
+ (void) showNewAlert:(NSString*)_alert forKey:(NSString *)key {
    SmartAlert *sa = [SmartAlert shared];  
    if(key == nil) key = @"";
    
    // Pull object
    id test = [sa.alerts objectForKey:key];
    
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        
        NSMutableDictionary *alert = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *messages = [NSMutableDictionary dictionary];
        
        [messages setObject:[NSNumber numberWithInt:1] forKey:_alert];
        
        SmartAlertView *alertView = [[SmartAlertView alloc] initWithTitle:sa.title message:@"" delegate:sa cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView setMaxMessages:sa.maxMessages];
        
        [alertView setMessages:messages];
        [alertView show];
        
        [alert setObject:alertView forKey:@"alert"];
        [alert setObject:messages forKey:@"messages"];
        
        [sa.alerts setObject:alert forKey:key];
        
        [alertView release];
    }
    
    
}



#pragma mark - Singleton Methods
+ (id)shared {
    @synchronized(self) {
        if(shared == nil)
            shared = [[super allocWithZone:NULL] init];
    }
    return shared;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self shared] retain];
}

#pragma mark - Memory / Init

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; // Can never be released;
}

- (id)autorelease {
    return self;
}
- (id)init {
    if ((self = [super init])) {
        self.alerts = [NSMutableDictionary dictionary];
        self.title = @"SmartAlert";
        self.maxMessages = 5;
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
    self.alerts = nil;
    self.title = nil;
}


@end
