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

@synthesize labels,_messages,maxMessages;

- (void) setMessages:(NSMutableDictionary *)messages {
    self._messages = messages;
    
    [self setFrame:self.frame];
    
    [self.labels removeAllObjects];
    
    for(NSString *messageString in self._messages){
        NSNumber *count = [self._messages objectForKey:messageString];
        
        
        UILabel *lbl = [[UILabel alloc] init];
        
        if([count intValue] > 1){
            NSString *txt = [[NSString alloc] initWithFormat:@"(%i) %@",[count intValue],messageString];
            lbl.text = txt;
            [txt release];
        }else{
            lbl.text = messageString;
        }
        
        [self.labels setObject:lbl forKey:messageString];
        [lbl release];
    }
    
    [self layoutSubviews];
}

- (NSMutableDictionary *) messages {
    return self._messages;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self._messages = [[NSMutableDictionary alloc] init];
        self.labels = [[NSMutableDictionary alloc] init];
        self.maxMessages = 5;
    }
    return self;
}

- (void)setFrame:(CGRect)rect {  
    
    int max = [self._messages count] > self.maxMessages ? self.maxMessages : [self._messages count];
    int height = ((max > 0 ? max : 1)*30)+110;
    
    [super setFrame:CGRectMake(0, 0, rect.size.width, height)];
    self.center = CGPointMake(320/2, 480/2);
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
                lbl.frame = CGRectMake(15, newY, 250, 25);
                lbl.textColor = [UIColor whiteColor];
                lbl.backgroundColor = [UIColor clearColor];
                lbl.textAlignment = UITextAlignmentCenter;
                [self addSubview:lbl];
                
                newY+=30;
                
                count++;
            }
        }
    }
}


- (void) dealloc {
    [super dealloc];
    self._messages = nil;
}


@end
