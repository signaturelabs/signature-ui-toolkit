//
//  SmartAlertViewController.m
//  SmartAlert
//
//  Created by Nate Lyman on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmartAlertViewController.h"
#import "SmartAlert.h"

@implementation SmartAlertViewController

-(IBAction) showAlert {
    for(int i = 0; i < 5; i++){
        NSString *msg = [[NSString alloc] initWithFormat:@"%i new messages.",i];
        [SmartAlert showAlert:msg forKey:@"message" withMode:@"replace"];
        [msg release];
    }
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
