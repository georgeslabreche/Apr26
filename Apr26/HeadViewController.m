//
//  HeadViewController.m
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadViewController.h"
#import "HeadView.h"

@interface HeadViewController ()

@end

@implementation HeadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        // Create head view and set it as the view of this controller.
        UIImage *headImage = [UIImage imageNamed:@"images/head.png"];
        headView = [[HeadView alloc] initWithImage:headImage];
        self.view = headView;
        
        // Init Pinch gesture
        [self initPinchGesture];
        
        // Init device rotation notification
        [self initDeviceRotationHandler];
        
    }
    return self;
}



// init device rotation handler
- (void) initDeviceRotationHandler{
    NSLog(@"Initialise device rotation handler");
    
    device = [UIDevice currentDevice];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //Send the handleDeviceRotate message to the head view
    //when we get a OrientationDidChange notification from the device.
    [center addObserver: self
               selector: @selector(handleDeviceRotate)
                   name: UIDeviceOrientationDidChangeNotification
                 object: device
     ];
    
     [device beginGeneratingDeviceOrientationNotifications];
}


// init pinch gesture handler
- (void) initPinchGesture{
    NSLog(@"Initialise pinch gesture handler...");
    
    previousPinchScale = 0;
    
    // Register pinch gesture recognizer
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget: self action: @selector(handlePinch:)
                                                 ];
    
    //pinchRecognizer.delegate = self;
    
    [self handlePinch: pinchRecognizer];
    [headView addGestureRecognizer: pinchRecognizer];
    
}

// Pinch handler
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    
    NSLog(@"Handle pinch.");
    
    if (recognizer.scale > previousPinchScale) {
        // Expand
        // Play expand sound
        NSLog(@"Head expand.");
    } else if (recognizer.scale < previousPinchScale) {
        // Shrink
        // Play shrink sound
        NSLog(@"Head shrink.");
    }
    
    // Animation
    [UIView animateWithDuration: 0.0 
                          delay: 0.0 
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         // define animation
                         headView.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
                     }
                     completion: NULL
     ];
    
    previousPinchScale = recognizer.scale;
}

// Handle device rotation
- (void)handleDeviceRotate{
    
    NSUInteger orientationId = [UIDevice currentDevice].orientation;
    NSLog(@"Rotated device: %i", orientationId);
    
    NSInteger rotationAngle = 0;
    
    if (UIDeviceOrientationPortrait == orientationId){
        rotationAngle = 0;
    }else if (UIDeviceOrientationPortraitUpsideDown == orientationId){
        rotationAngle = 180;
    }else if (UIDeviceOrientationLandscapeRight == orientationId){
        rotationAngle = -90;
    }else if (UIDeviceOrientationLandscapeLeft == orientationId){
        rotationAngle = 90;
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(previousPinchScale, previousPinchScale);
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(rotationAngle * M_PI / 180);
    
    // Animation
    [UIView animateWithDuration: 1.0
                          delay: 0.0 
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         // define animation
                         headView.transform = CGAffineTransformConcat(rotationTransform, scaleTransform);
                     }
                     completion: NULL
     ];
    
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
