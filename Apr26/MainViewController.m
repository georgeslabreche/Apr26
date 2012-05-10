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
    
    // Init our asteroid views array
    asteroidViews = [[NSMutableArray alloc] init];
    
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
            
            // Keep track of the added asteroids views. Put in an array.
            [asteroidViews addObject:asteroidViewController.view];
        }
    }
    
    // Init the head view controller.
    // Get the head view from that controller and make it a subview of the background image view
    headViewController = [[HeadViewController alloc] initWithSpaceViewSize:backgroundImageView.bounds.size]; 
    [backgroundImageView addSubview:headViewController.view];
    
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
    
    headSoundPlayer = [HeadSoundPlayer sharedInstance];
    
    
    // start collision detection.
    [NSTimer scheduledTimerWithTimeInterval:0.5 
                                     target:self 
                                   selector:@selector(detectAsteroidImpact) 
                                   userInfo:nil 
                                    repeats:YES];
    
    
}


- (void) detectAsteroidImpact{
    
   
    for(NSInteger i = 0; i < [asteroidViews count]; i++){
        
        // Changing the center point of the asteroid doesn't change to origin value of the asteroid's frame
        // (it was initialised with (0, 0).
        // Don't use exact height and width of the view but smaller one, this is to take into account parts
        // That are transparent
        CGRect asteroidRect = CGRectMake([[asteroidViews objectAtIndex:i] center].x, 
                                         [[asteroidViews objectAtIndex:i] center].y, 
                                         [[asteroidViews objectAtIndex:i] size].width - ([[asteroidViews objectAtIndex:i] size].width / 3), 
                                         [[asteroidViews objectAtIndex:i] size].height - ([[asteroidViews objectAtIndex:i] size].height / 3));
         
        // Changing the center point of the head doesn't change to origin value of the head's frame
        // (it was initialised with (0, 0).
        CGRect headRect = CGRectMake(   headViewController.view.center.x, 
                                        headViewController.view.center.y, 
                                        headViewController.view.bounds.size.width - (headViewController.view.bounds.size.width / 3), 
                                        headViewController.view.bounds.size.height - (headViewController.view.bounds.size.height / 3));
        

        if(CGRectIntersectsRect(asteroidRect, headRect)){
            NSLog(@"IMPACT!");
            
            // Make head spin upon impact
            // TODO: Refine this. Maybe just make the head scale bigger/smaller?
            // Give a certain amount of lives. Decrement lives when hit by asteroid.
            // Use gif animation for explosion when run out of lives.
          
            // Animation
            [UIView animateWithDuration: [headSoundPlayer ouchAudioPlayer].duration
                                  delay: 0.0 
                                options: UIViewAnimationOptionCurveEaseInOut
                             animations: ^{
                                 // define animation
                                 headViewController.view.transform = CGAffineTransformConcat(headViewController.view.transform, CGAffineTransformMakeRotation(180 * M_PI / 180));
                             }
                             completion: NULL
             ];
            
            //play ouch sound
            [headSoundPlayer playOuchSound];
        }
    }
    
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
