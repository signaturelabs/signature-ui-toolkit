//
//  SGPushNotificationSimulator.h
//  APNTest
//
//  Created by Nate Lyman on 1/21/12.
//  Copyright (c) 2012 Signature Labs, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGPushNotificationSimulator : NSObject

+ (void)simulatePushNotificationWithName:(NSString *)notificationName;

@end
