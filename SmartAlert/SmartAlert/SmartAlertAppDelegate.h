//
//  SmartAlertAppDelegate.h
//  SmartAlert
//
//  Created by Nate Lyman on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SmartAlertViewController;

@interface SmartAlertAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SmartAlertViewController *viewController;

@end
