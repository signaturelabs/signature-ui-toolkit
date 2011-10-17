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

#import <Foundation/Foundation.h>
#import "SmartAlertView.h"

#define kSmartAlertAppend 1;
#define kSmartAlertReplace 2;

@interface SmartAlert : NSObject <UIAlertViewDelegate> {
    
}

@property (retain) NSMutableDictionary *alerts;
@property (retain) NSString *title;
@property (nonatomic) NSInteger maxMessages;

+ (id)shared;

/*
 * alert = @"The string you want the alert to display"
 * key = @"error" // The unique key you want to group alerts by.
 */
 + (void) showAlert:(NSString*)alert forKey:(NSString *)key;


@end
