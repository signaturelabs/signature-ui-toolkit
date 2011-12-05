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
#import "SmartAlertView.h"

static CGFloat const kFontSize = 17.0;

@implementation SmartAlertView

@synthesize labels, messages, maxMessages;

- (void) queueMessages:(NSMutableDictionary *)theMessages {
    self.messages = theMessages;
    
    [self setFrame:self.frame];
    
    [self.labels removeAllObjects];
    
    for(NSString *messageString in self.messages){
        NSNumber *count = [self.messages objectForKey:messageString];        
        UILabel *lbl = [[UILabel alloc] init];
        
        if([count intValue] > 1){
            lbl.text = [NSString stringWithFormat:@"(%i) %@",[count intValue],messageString];
        }else{
            lbl.text = messageString;
        }
        
        [self.labels setObject:lbl forKey:messageString];
        [lbl release];
    }
    
    [self layoutSubviews];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        messages = [[NSMutableDictionary alloc] init];
        labels = [[NSMutableDictionary alloc] init];
        maxMessages = 5;
    }
    return self;
}

- (void)setFrame:(CGRect)rect {  
    
    NSUInteger height = 110;
    NSUInteger kHeightPadding = 30;
    
    for(UIView *inner in self.subviews){
        
        BOOL viewIsALabel = [inner isKindOfClass:[UILabel class]];
        if(viewIsALabel == YES){
            height += [(UILabel *)inner numberOfLines]*kHeightPadding;
        }
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    [super setFrame:CGRectMake(0, 0, rect.size.width, height)];
    self.center = CGPointMake(screen.size.width/2, screen.size.height/2);
}

- (void)layoutSubviews {
    static NSUInteger kYValuePadding = 15;
    
    for (UIView *view in self.subviews) {
        
        static NSString *kThreePartButton = @"UIThreePartButton";
        BOOL viewClassIsAThreePartButton = [[[view class] description] isEqualToString:kThreePartButton]; // jww: This is likely sketchy for App Store review.
        if (viewClassIsAThreePartButton == YES) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - kYValuePadding, view.frame.size.width, view.frame.size.height);
            
        }
        
        BOOL viewIsALabel = [view isKindOfClass:[UILabel class]];
        if(viewIsALabel == YES){
            UILabel *l = (UILabel *)view;
            if(![l.text isEqualToString:self.title]){
                // REMOVE UILabels except the title
                [l removeFromSuperview];
            }
        }
    }
    
    NSUInteger newX = 15;
    NSUInteger newY = 45;    
    NSUInteger count = 0;
    NSUInteger kDesiredWidth = 250;
    NSUInteger kHeightPadding = 5;
  
    if([self.labels count] > 0){
        for(NSString *key in self.labels){
            if(count < self.maxMessages){
                
                UILabel *currentLabel = (UILabel*)[self.labels objectForKey:key];
                
                int height = 25;
                int lines = 1;
                CGSize size = [currentLabel.text sizeWithFont:[UIFont systemFontOfSize:kFontSize]];
                if(size.width > kDesiredWidth){
                    lines = ceil(size.width/kDesiredWidth);
                    height = height*lines;
                }
                
                currentLabel.numberOfLines = lines;
                currentLabel.frame = CGRectMake(newX, newY, kDesiredWidth, height);
                currentLabel.textColor = [UIColor whiteColor];
                currentLabel.backgroundColor = [UIColor clearColor];
                currentLabel.textAlignment = UITextAlignmentCenter;
                [self addSubview:currentLabel];
                
                newY+=(height + kHeightPadding);
                
                count++;
            }
        }
    }
}


- (void) dealloc {
    [messages release]; messages = nil;
    [labels release]; labels = nil;
    [super dealloc];
}


@end
