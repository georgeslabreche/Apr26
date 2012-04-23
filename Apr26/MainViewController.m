//
//  MainViewController.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "MainView.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
        
        // Notification
        device = [UIDevice currentDevice];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        //Send the handleDeviceRotate message to the head view
        //when we get a OrientationDidChange notification from the device.
        [center addObserver: [self.view.subviews objectAtIndex:0]
                   selector: @selector(handleDeviceRotate)
                       name: UIDeviceOrientationDidChangeNotification
                     object: device
         ];
        
   
        [device beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadView{
     CGRect mainScreenBounds = [[UIScreen mainScreen]bounds];
     MainView *mainView = [[MainView alloc]initWithFrame:mainScreenBounds];
    
    self.view = mainView;
}

@end
