//
//  MainViewController.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "AsteroidViewController.h"

#import "MainView.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

// Init the main view
- (void) initMainView{
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
    
    // Set background image for the background image view
    backgroundImageView.image = backgoundImage;
    
    // Init the head view controller.
    // Get the head view from that controller and make it a subview of the background image view
    headViewController = [[HeadViewController alloc] initWithSpaceViewSize:backgroundImageView.bounds.size]; 
    [backgroundImageView addSubview:headViewController.view];
    
    // Get the image paths of the asteroids
    NSArray *asteroidImagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" 
                                                                     inDirectory:@"images/asteroids"];

    // Create a HeadView for every head image.
    for (NSInteger i = 0; i < [asteroidImagePaths count]; i++){
        NSString *asteroidImagePath = [asteroidImagePaths objectAtIndex: i];
        
        // Create image object
        UIImage *asteroidImage = [UIImage imageWithContentsOfFile: asteroidImagePath];
        if (asteroidImage == nil) {
            NSLog(@"Could not find the image: %@", asteroidImagePath);
            
        }else{
            NSLog (@"Loaded image: %@", asteroidImagePath);
            
            AsteroidViewController *asteroidViewController = [[AsteroidViewController alloc] 
                                                              initWithImage: asteroidImage 
                                                              andSpaceViewSize:backgroundImageView.bounds.size];
            // Add asteroid view as a sub view
            [backgroundImageView addSubview:asteroidViewController.view];
        }
    }
    
    
    
    // Make the background image view a subview of the main view.
    [mainView addSubview:backgroundImageView];
    
    // Set the main view to be the controller's view.
    self.view = mainView;
}

// touch detection to tell the head where to go.
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    
    // Using [event allTouches] because for some reason touches.count isn't behaving as expected.
    NSSet *allTouches = [event allTouches];
    
	if (allTouches.count >= 1) {
        
        [headSoundPlayer playMoveSound];
        
        // Animation. Not the diraction of the animation is the same as the duration of the audio
        [UIView animateWithDuration: [headSoundPlayer moveAudioPlayer].duration
                              delay: 0.0 
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             // define animation 
                             headViewController.view.center = [[touches anyObject] locationInView: self.view];
                         }
                         completion: NULL
         ]; 
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init the main view.
    [self initMainView];
    
    headSoundPlayer = [[HeadSoundPlayer alloc]init];
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
