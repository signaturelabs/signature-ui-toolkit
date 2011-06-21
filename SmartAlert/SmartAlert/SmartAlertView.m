//
//  SmartAlertView.m
//  SmartAlert
//
//  Created by Nate Lyman on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmartAlertView.h"


@implementation SmartAlertView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)rect {
    [super setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    self.center = CGPointMake(320/2, 480/2);
}

- (void)layoutSubviews {
    CGFloat buttonTop;
    for (UIView *view in self.subviews) {
        if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);
            buttonTop = view.frame.origin.y;
        }
    }
    
}



@end
