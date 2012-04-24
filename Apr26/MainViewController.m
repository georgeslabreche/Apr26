//
//  MainViewController.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "MainView.h"
#import "HeadView.h"

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
        
        // Create and set the main view
        CGRect mainScreenBounds = [[UIScreen mainScreen]bounds];
        MainView *mainView = [[MainView alloc]initWithFrame:mainScreenBounds];
              
        // Create the image view that will serve as a background.
        // We use an image view because image views automatically scale the the background image.
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:mainView.frame];
        // Enabled detection of gestures and touches.
        backgroundImageView.userInteractionEnabled = YES;
        // Get background image
        UIImage *backgoundImage = [UIImage imageNamed:@"images/background.png"];
        // Set background image for the image view
        backgroundImageView.image = backgoundImage;
        
        
        // Now, to that background image view, let's add the head view as a subview
        NSBundle *bundle = [NSBundle mainBundle];
        if (bundle == nil) {
            NSLog(@"could not get the main bundle.");
            
        }else{
            
            UIImage *headImage = [UIImage imageNamed:@"images/head.png"];
            
            CGFloat headOriginX = (backgroundImageView.bounds.size.width / 2) - (headImage.size.width / 2);
            CGFloat headOriginY = (backgroundImageView.bounds.size.height / 2) - (headImage.size.height / 2);
            CGRect headImageFrame = CGRectMake(headOriginX, headOriginY, headImage.size.width, headImage.size.height);
            
            headView = [[HeadView alloc]initWithFrame:headImageFrame];
            headView.image = headImage;
            
            // Make the head view a sub view of the background image view.
            [backgroundImageView addSubview:headView];

        }

        
        // Make the background image view a subview of the main view.
        [mainView addSubview:backgroundImageView];
        
        // Set the main view to be the controller's view.
        self.view = mainView;
        
        //Send the handleDeviceRotate message to the head view
        //when we get a OrientationDidChange notification from the device.
        [center addObserver: headView
                   selector: @selector(handleDeviceRotate)
                       name: UIDeviceOrientationDidChangeNotification
                     object: device
         ];
        
   
        [device beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}

// touch detection to tell the head where to go.
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    
    // Using [event allTouches] because for some reason touches.count isn't behaving as expected.
    NSSet *allTouches = [event allTouches];
    
	if (allTouches.count >= 1) {
        
        // Animation. Not the diraction of the animation is the same as the duration of the audio
        [UIView animateWithDuration: 1.0 
                              delay: 0.0 
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             // define animation 
                             headView.center = [[touches anyObject] locationInView: self.view];
                         }
                         completion: NULL
         ]; 
    }
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

@end
