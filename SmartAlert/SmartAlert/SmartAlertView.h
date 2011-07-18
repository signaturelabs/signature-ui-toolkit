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


@interface SmartAlertView : UIAlertView {
    
}

@property (nonatomic,retain) NSMutableDictionary *_messages;
@property (nonatomic,retain) NSMutableDictionary *labels;
@property (nonatomic) NSInteger maxMessages;


- (id)initWithFrame:(CGRect)frame;
- (void)setFrame:(CGRect)rect;
- (void)layoutSubviews;

- (void) setMessages:(NSMutableDictionary *)messages;
- (NSMutableDictionary *) messages;

@end
