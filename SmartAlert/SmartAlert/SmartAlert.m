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
#import "SmartAlertView.h"

static SmartAlert *shared = nil;

@implementation SmartAlert

@synthesize alerts;

+ (void) showAlert:(NSString*)_alert forKey:(NSString *)key {
    SmartAlert *sa = [SmartAlert shared];  
    
    // Pull object
    id test = [sa.alerts objectForKey:key];
    
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        
        NSMutableDictionary *alert = [NSMutableDictionary dictionary];
        
        // Create SmartAlertView to store in our dictionary
        SmartAlertView *al = [[SmartAlertView alloc] initWithTitle:@"Smart Alert" message:_alert delegate:sa cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [al show];
        
        // Add SmartAlertView to Dictionary
        [alert setValue:al forKey:@"alertView"];
        
        // Add Count object to dictionary
        [alert setValue:[NSNumber numberWithInt:1] forKey:@"count"];
        
        // Store alert dictionary to tracking dictionary
        [sa.alerts setObject:alert forKey:key];
        [al release];
    }
    
    
}

+ (void) showAlert:(NSString *)_alert forKey:(NSString *)key withMode:(NSString *)mode {
    SmartAlert *sa = [SmartAlert shared];
    
    id test = [sa.alerts objectForKey:key];
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        
        // Fire a basic first alert
        [SmartAlert showAlert:_alert forKey:key];
        
    }else{
        
        NSMutableDictionary *dict = (NSMutableDictionary *)test;
        SmartAlertView *al = [dict objectForKey:@"alertView"];
        NSNumber *count = (NSNumber *)[dict objectForKey:@"count"];
        count = [NSNumber numberWithInt:[count intValue]+1];
        
        if([mode isEqual:@"append"]){
            NSString *msg = [al.message stringByAppendingFormat:@"\n%@",_alert];
            al.message = msg;
            
        }else{
            NSString *string = [[NSString alloc] initWithFormat:@"(%i) %@",[count intValue],_alert];
            al.message = string;
            [string release];
        }
        
        [dict setValue:al forKey:@"alertView"];
        [dict setValue:count forKey:@"count"];
        [sa.alerts setObject:dict forKey:key];
    }

}



#pragma mark - SmartAlertViewDelegate
- (void) alertView:(SmartAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0){ // Cancel
        
        for(NSString *key in self.alerts){
            NSMutableDictionary *alert = [self.alerts objectForKey:key];
            
            SmartAlertView *al = [alert objectForKey:@"alertView"];
            if([al isEqual:alertView]){
                // REMOVE IF VIEW IS THE SAME SO IT CAN RECEIVE MORE ALERTS
                [self.alerts removeObjectForKey:key];
                break;
            }
        }
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
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
    self.alerts = nil;
}


@end
