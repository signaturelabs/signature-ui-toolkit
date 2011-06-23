//
//  SmartAlertView.h
//  SmartAlert
//
//  Created by Nate Lyman on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SmartAlertView : UIAlertView {
    
}

@property (nonatomic,retain) NSMutableDictionary *_messages;
@property (nonatomic,retain) NSMutableDictionary *labels;

- (id)initWithFrame:(CGRect)frame;
- (void)setFrame:(CGRect)rect;
- (void)layoutSubviews;

- (void) setMessages:(NSMutableDictionary *)messages;
- (NSMutableDictionary *) messages;

@end
