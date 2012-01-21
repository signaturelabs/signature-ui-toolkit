//
//  SGPushNotificationSimulator.m
//  APNTest
//
//  Created by Nate Lyman on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGPushNotificationSimulator.h"

@interface SGPushNotificationSimulator()
- (id)plistWithName:(NSString *)fileName;
- (NSDictionary *) userInfoDictionaryWithNotificationName:(NSString *)name;
@end;

@implementation SGPushNotificationSimulator

+ (void)simulatePushNotificationWithName:(NSString *)notificationName {
    
    UIApplication *application = [UIApplication sharedApplication];
    id appDelegate = [application delegate];
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [appInfo objectForKey:@"CFBundleName"];
    
    SGPushNotificationSimulator *sim = [[SGPushNotificationSimulator alloc] init];
    
    
    NSDictionary *userInfo = [sim userInfoDictionaryWithNotificationName:notificationName];
    
    if(userInfo != nil) {
        id aps = [userInfo objectForKey:@"aps"];
        NSLog(@"Getting APS");
        
        if(aps != nil && [aps isKindOfClass:[NSDictionary class]]) {
            NSDictionary *apsDict = (NSDictionary *)aps;
            
            id alert = [apsDict objectForKey:@"alert"];
            if(alert != nil) {
                NSString *alertMessage = (NSString *)alert;
                
                [[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"];
                
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:appName 
                                                             message:alertMessage 
                                                            delegate:nil 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles: nil];
                [al show];
                [al release];
            }
        }
    }
    
    [appDelegate application:application didReceiveRemoteNotification:nil];
    [sim release];
}
- (NSDictionary *)userInfoDictionaryWithNotificationName:(NSString *)name {
    // Load/Parse the plist file for the notification
    id plist = [self plistWithName:name];
    
    if([plist isKindOfClass:[NSDictionary class]]) {
        NSDictionary *plistDict = (NSDictionary *)plist;
        id userInfo = [plistDict objectForKey:@"userInfo"];
        if([userInfo isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *userInfoDict = (NSDictionary *)userInfo;
            return userInfoDict;
        }
    }
    return nil;
}

- (id)plistWithName:(NSString *)fileName {
    NSData *plistData;  
    NSString *error;  
    NSPropertyListFormat format;  
    id plist;  

    NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];  
    plistData = [NSData dataWithContentsOfFile:localizedPath];   

    plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];  
    if (!plist) {  
    NSLog(@"Error reading plist from file '%s', error = '%s'", [localizedPath UTF8String], [error UTF8String]);  
    [error release];  
    }  

    return plist;  
}  

@end
