/*
 ``The contents of this file are subject to the Mozilla Public License
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

/*********************************************************************

 ATTENTION
 
 This file is just to demonstrate how SmartAlert handles alerts coming
 from the background.  All you need to do is call:
 
 [SmartAlert showAlert:@"Your Message"
             forKey:@"msg_key" 
             withMode:@"replace||append"];
 
*********************************************************************/

#import "SmartAlertViewController.h"
#import "SmartAlert.h"

@implementation SmartAlertViewController

#pragma mark -
#pragma mark Instance Methods
// +--------------------------------------------------------------------
// | Instance Methods
// +--------------------------------------------------------------------

-(IBAction)showAlert {
    count = 0;
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];
}

- (void)timerEvent:(NSTimer *)theTimer {
    if(count < 5){
        [self fireAlert];
    }
    count++;
}

- (void)fireAlert {   
     
    // SET MAX MESSAGES DISPLAYED IN A ALERT WINDOW
    [[SmartAlert shared] setMaxMessages:3];    
    
    // DISPLAY ALERTS FOR message KEY
    static NSString *kMessagesKey = @"messages";
    NSArray *alertMessages = [NSArray arrayWithObjects:
                              NSLocalizedString(@"Test message that is really long and will hopefully overflow", nil),
                              NSLocalizedString(@"A panda!", nil),
                              NSLocalizedString(@"A panda?", nil),
                              NSLocalizedString(@"A cougar?", nil),
                              NSLocalizedString(@"A lion?", nil),
                              NSLocalizedString(@"A dog?", nil), nil];
  
    for (NSString *alertMessage in alertMessages)
    {
      [SmartAlert showAlert:alertMessage forKey:kMessagesKey];
    }    
    
    // DISPLAY ALERT FOR message2 KEY
    static NSString *kMessagesTwoKey = @"messages2";
    [SmartAlert showAlert:@"3 missed calls" forKey:kMessagesTwoKey];
}

#pragma mark -
#pragma mark Memory Management
// +--------------------------------------------------------------------
// | Memory Management
// +--------------------------------------------------------------------

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark View Lifecycle
// +--------------------------------------------------------------------
// | View Lifecycle
// +--------------------------------------------------------------------

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    /*
     * OK, We're doing a scheduled timer and attaching it to the run loop because 
     * we want to simulate something happening in the background causing a new alert
     * to be triggered.  This would mimic the behavior or a push notification, or some
     * repeating alert in your app.  You dont need to implement anything in this file other
     * than the line of code fired in -(void) fireAlert;
     */
    
    // Set high count so alerts dont fire in the run loop until user clicks ok
    count = 99999;
    
    NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(timerEvent:)];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sgn];
    [inv setTarget: self];
    [inv setSelector:@selector(timerEvent:)];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:inv repeats:YES];

    // Set the title of the Alert Dialog
    [[SmartAlert shared] setTitle:NSLocalizedString(@"Smart Alert Demo", nil)];
    
}

#pragma mark -
#pragma mark Device Orientation & Editing Methods
// +--------------------------------------------------------------------
// | Device Orientation & Editing Methods
// +--------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
