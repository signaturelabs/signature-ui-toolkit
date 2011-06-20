//
//  SmartAlert.m
//  SmartAlert
//
//  Created by Nate Lyman on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmartAlert.h"

static SmartAlert *shared = nil;

@implementation SmartAlert

@synthesize alerts;

+ (void) showAlert:(NSString*)_alert forKey:(NSString *)key {
    SmartAlert *sa = [SmartAlert shared];  
    
    // Pull object
    id test = [sa.alerts objectForKey:key];
    
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Smart Alert" message:_alert delegate:sa cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [al show];
        [sa.alerts setObject:al forKey:key];
        [al release];
    }
    
    
}

+ (void) showAlert:(NSString *)_alert forKey:(NSString *)key withMode:(NSString *)mode {
    SmartAlert *sa = [SmartAlert shared];
    
    id test = [sa.alerts objectForKey:key];
    if(test == nil || [test isKindOfClass:[NSNull class]]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Smart Alert" message:_alert delegate:sa cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [al show];
        [sa.alerts setObject:al forKey:key];
        [al release];
    }else{
        
        UIAlertView *al = (UIAlertView *)test;
        if([mode isEqual:@"append"]){
            NSString *msg = [al.message stringByAppendingFormat:@"\n%@",_alert];
            al.message = msg;
            
        }else{
            al.message = _alert;
        }
        [sa.alerts setObject:al forKey:key];
    }

}



#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0){ // Cancel
        
        for(NSString *key in self.alerts){
            
            UIAlertView *al = [self.alerts objectForKey:key];
            if([al isEqual:alertView]){
                // REMOVE IF VIEW IS THE SAME SO IT CAN RECEIVE MORE ALERTS
                [self.alerts removeObjectForKey:key];
                break;
            }
        }
    }
}

- (void) alertViewCancel:(UIAlertView *)alertView {
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
