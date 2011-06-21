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

@property (nonatomic,retain) NSMutableDictionary *messages;
@property (nonatomic,retain) NSMutableDictionary *labels;

- (id)initWithFrame:(CGRect)frame;
- (void)setFrame:(CGRect)rect;
- (void)layoutSubviews;
- (void) setMessage:(NSString *)_message forKey: (NSString *)_key;

@end
