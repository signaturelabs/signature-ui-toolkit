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
    
    int height = 110;
    
    for(UIView *inner in self.subviews){
        
        if([inner isKindOfClass:[UILabel class]]){
            height += [(UILabel *)inner numberOfLines]*30;
        }
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    [super setFrame:CGRectMake(0, 0, rect.size.width, height)];
    self.center = CGPointMake(screen.size.width/2, screen.size.height/2);
}

- (void)layoutSubviews {
    
    for (UIView *view in self.subviews) {
        
        if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);
            
        }
        
        if([view isKindOfClass:[UILabel class]]){
            UILabel *l = (UILabel *)view;
            if(![l.text isEqualToString:self.title]){
                // REMOVE UILabels except the title
                [l removeFromSuperview];
            }
        }
    }
    
    int newY = 45;
    
    int count = 0;
    
    if([self.labels count] > 0){
        for(NSString *key in self.labels){
            if(count < maxMessages){
                
                UILabel *lbl = (UILabel*)[self.labels objectForKey:key];
                
                int height = 25;
                int lines = 1;
                CGSize size = [lbl.text sizeWithFont:[UIFont systemFontOfSize:17.0]];
                if(size.width > 250){
                    lines = ceil(size.width/250);
                    height = height*lines;
                }
                
                lbl.numberOfLines = lines;
                lbl.frame = CGRectMake(15, newY, 250, height);
                lbl.textColor = [UIColor whiteColor];
                lbl.backgroundColor = [UIColor clearColor];
                lbl.textAlignment = UITextAlignmentCenter;
                [self addSubview:lbl];
                
                newY+=(height+5);
                
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
