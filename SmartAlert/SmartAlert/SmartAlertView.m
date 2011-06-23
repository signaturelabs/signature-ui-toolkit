//
//  SmartAlertView.m
//  SmartAlert
//
//  Created by Nate Lyman on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmartAlertView.h"


@implementation SmartAlertView

@synthesize labels,_messages;
- (void) setMessages:(NSMutableDictionary *)messages {
    self._messages = messages;
    
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
/*
- (void) setMessage:(NSString *)_message forKey: (NSString *)_key {
    [self.messages setValue:_message forKey:_key];
    
    [self setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = _message;
    
    [self.labels setValue:lbl forKey:_key];
    [lbl release];
    
    [self layoutSubviews];
}
 */

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self._messages = [[NSMutableDictionary alloc] init];
        self.labels = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setFrame:(CGRect)rect {  
    int max = [self.messages count] > 5 ? 5 : [self._messages count];
    [super setFrame:CGRectMake(0, 0, rect.size.width, (max*30)+110)];
    self.center = CGPointMake(320/2, 480/2);
}

- (void)layoutSubviews {
    
    CGFloat buttonTop;
    
    for (UIView *view in self.subviews) {
        
        if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);
            buttonTop = view.frame.origin.y;
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
    
    NSLog(@"%i labels",[self.labels count]);
    
    if([self.labels count] > 0){
        for(NSString *key in self.labels){
            NSLog(@"%@",key);
            UILabel *lbl = (UILabel*)[self.labels objectForKey:key];
            lbl.frame = CGRectMake(15, newY, 250, 25);
            lbl.textColor = [UIColor whiteColor];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.textAlignment = UITextAlignmentCenter;
            [self addSubview:lbl];
            
            newY+=30;
        }
    }
}


- (void) dealloc {
    [super dealloc];
    self._messages = nil;
}


@end
