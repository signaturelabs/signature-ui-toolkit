/*
 ``The contents of this file are subject to the Mozilla Public License
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

@implementation SmartAlert

@synthesize alerts,title;

+ (void) showAlert:(NSString*)_alert forKey:(NSString *)key {
    SmartAlert *sa = [SmartAlert shared];  
    
    // Pull object
    id test = [sa.alerts objectForKey:key];
    
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        
        NSMutableDictionary *alert = [NSMutableDictionary dictionary];
        SmartAlertView *alertView = [alert objectForKey:@"alert"];
        
        // Create SmartAlertView to store in our dictionary
        if(alertView == nil){
          alertView = [[SmartAlertView alloc] initWithTitle:sa.title message:@"" delegate:sa cancelButtonTitle:@"OK" otherButtonTitles: nil];
        }
        [alertView setMessage:_alert forKey:key];
        [alertView show];
        
        
        // Add Alert object to dictionary
        [alert setValue:alertView forKey:@"alert"];
        
        // Add Count object to dictionary
        [alert setValue:[NSNumber numberWithInt:1] forKey:@"count"];
        
        // Store alert dictionary to tracking dictionary
        [sa.alerts setObject:alert forKey:key];
    }
    
    
}

+ (void) showAlert:(NSString *)_alert forKey:(NSString *)key withMode:(NSString *)mode {
    SmartAlert *sa = [SmartAlert shared];
    
    id test = [sa.alerts objectForKey:key];
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        
        // Fire a basic first alert
        [SmartAlert showAlert:_alert forKey:key];
        
    }else{
        
        NSMutableDictionary *alert = (NSMutableDictionary *)test;
        
        SmartAlertView *alertView = [alert objectForKey:@"alert"];
        
        NSNumber *count = (NSNumber *)[alert objectForKey:@"count"];
        
        count = [NSNumber numberWithInt:[count intValue]+1];
        
        if([mode isEqual:@"append"]){
            NSString *msg = [alertView.message stringByAppendingFormat:@"\n%@",_alert];
            [alertView setMessage:msg forKey:key];
            
        }else{
            NSString *string = [[NSString alloc] initWithFormat:@"(%i) %@",[count intValue],_alert];
            [alertView setMessage:string forKey:key];
            [string release];
        }
        
        // Add Alert object to dictionary
        [alert setValue:alertView forKey:@"alert"];
        
        // Add Count object to dictionary
        [alert setValue:count forKey:@"count"];
        
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




#pragma mark Singleton Methods
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
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; // Can never be released;
}
- (void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if ((self = [super init])) {
        self.alerts = [[NSMutableDictionary alloc] init];
        self.title = @"Smart Alert";
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
    self.alerts = nil;
    self.title = nil;
}


@end
