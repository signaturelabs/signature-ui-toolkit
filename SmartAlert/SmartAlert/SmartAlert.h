//
//  SmartAlert.h
//  SmartAlert
//
//  Created by Nate Lyman on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSmartAlertAppend 1;
#define kSmartAlertReplace 2;

@interface SmartAlert : NSObject <UIAlertViewDelegate> {
    
}

@property (retain) NSMutableDictionary *alerts;

+ (id)shared;
+ (void) showAlert:(NSString*)alert forKey:(NSString *)key;
+ (void) showAlert:(NSString *)alert forKey:(NSString *)key withMode:(NSString *)mode;

@end
