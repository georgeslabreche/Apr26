//
//  SpaceViewController.m
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SpaceViewController.h"
#import "AsteroidViewController.h"
#import "MusicPlayer.h"

@interface SpaceViewController ()

@end

@implementation SpaceViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)init{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        musicPlayer = [MusicPlayer sharedInstance];
        headSoundPlayer = [HeadSoundPlayer sharedInstance];
        lives = 3;
        survivalTimeTracker = 0;
    }
    
    return self;
}

// start the game
-(void) startGame{
    [self initSpaceView];
    [self initTimeTracker];
    [self initCollisionDetection];
}

// Got to game intro/menu view
- (void) endGame{
    // Stop collision detection
    [collisionDetectionTimer invalidate];
    
    // nil asteroid views array
    asteroidViews = nil;
    
    // nil headViewController
    headViewController = nil;
    
    // nil lives left label
    //livesLeftLabel = nil;
    
    // reset values for life and countdown
    lives = 3;
    survivalTimeTracker = 0;
    
    
    // Stop play music, start playing intro music
    [musicPlayer playIntroMusic];
    
    // Go back to game intro/menu view.
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    [delegate transitionToIntroView];
    
    
}

// Init the main view
- (void) initSpaceView{
    
    // Init our asteroid views array
    asteroidViews = [[NSMutableArray alloc] init];
    
    // Create and set the space view
    CGRect mainScreenBounds = [[UIScreen mainScreen]bounds];
    UIView *spaceView = [[UIView alloc]initWithFrame:mainScreenBounds];
    
    // BACKGROUND VIEW
    // Create the image view that will serve as a background.
    // We use an image view because image views automatically scale the the background image.
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:spaceView.frame];

    // Get background image
    UIImage *backgoundImage = [UIImage imageNamed:@"images/background.png"];
    
    // Set background image for the background image view
    backgroundImageView.image = backgoundImage;
    
    // Make the background image view a subview of the main view.
    [spaceView addSubview:backgroundImageView];
    
    // ASTEROID VIEWS
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
            [spaceView addSubview:asteroidViewController.view];
            
            // Keep track of the added asteroids views. Put in an array.
            [asteroidViews addObject:asteroidViewController.view];
        }
    }
    
    // HEAD VIEW
    // Init the head view controller.
    // Get the head view from that controller and make it a subview of the background image view
    headViewController = [[HeadViewController alloc] initWithSpaceViewSize:backgroundImageView.bounds.size]; 
    [spaceView addSubview:headViewController.view];
    
    // SURVIVAL TIME TRACKING VIEW
    CGRect timeSurvivedLabelRect = CGRectMake(0, 0, 100, 25);
    survivalTimeLabel = [[UILabel alloc]initWithFrame:timeSurvivedLabelRect];
    survivalTimeLabel.text = [[NSString alloc]initWithFormat:@" %u", survivalTimeTracker];
    survivalTimeLabel.backgroundColor = [UIColor clearColor];
    survivalTimeLabel.textColor = [UIColor colorWithRed:1 green:0.8 blue:0 alpha:1]; /*#ffcc00*/
    survivalTimeLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:18];
    
    // LIVES LEFT VIEW
    CGRect livesLeftLabelRect = CGRectMake(spaceView.bounds.size.width - 100, 0, 100, 25);
    livesLeftLabel = [[UILabel alloc]initWithFrame:livesLeftLabelRect];
    livesLeftLabel.text = [[NSString alloc]initWithFormat:@"Lives: %u", lives];
    livesLeftLabel.backgroundColor = [UIColor clearColor];
    livesLeftLabel.textColor = [UIColor colorWithRed:1 green:0.8 blue:0 alpha:1]; /*#ffcc00*/
    livesLeftLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:18];
    
    [spaceView addSubview:survivalTimeLabel];
    [spaceView addSubview:livesLeftLabel];
   
    
    // Set the main view to be the controller's view.
    self.view = spaceView;
}

-(void) initTimeTracker{
    
    // start tracking time
    timeTrackerTimer = [NSTimer scheduledTimerWithTimeInterval:1 
                                                        target:self 
                                                      selector:@selector(trackSurvivalTime) 
                                                      userInfo:nil 
                                                       repeats:YES];
}

-(void) initCollisionDetection{

    // start collision detection.
    collisionDetectionTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                               target:self 
                                                             selector:@selector(detectAsteroidImpact) 
                                                             userInfo:nil 
                                                              repeats:YES];
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
    
}
- (void) trackSurvivalTime{
    survivalTimeTracker++;
    
    if(survivalTimeTracker % 10 == 0){
        // Emphasize every time we cumulate 10 points
        survivalTimeLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:22];
    }else{
        survivalTimeLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:18];
    }
    survivalTimeLabel.text = [[NSString alloc]initWithFormat:@" %u", survivalTimeTracker];
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
   
      
            // Only count impact if it's not during the after effects of a previous impact.
            if(![headSoundPlayer.ouchAudioPlayer isPlaying]){
                NSLog(@"Aseteroid impact!");
                
                // decrement number of lives left and display
                if(lives > 0){
                    lives --;
                    livesLeftLabel.text = [[NSString alloc]initWithFormat:@"Lives: %u", lives];
                
    
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
                    
                
                
                }
                
                // dead
                if(lives == 0){
                    
                    //Game over!
                    // Animation
                    [UIView animateWithDuration: [headSoundPlayer ouchAudioPlayer].duration
                                          delay: 0.0 
                                        options: UIViewAnimationOptionCurveEaseInOut
                                     animations: ^{
                                         // define animation
                                         headViewController.view.transform = CGAffineTransformConcat(headViewController.view.transform, CGAffineTransformMakeRotation(180 * M_PI / 180));
                                     }
                                     completion: ^(BOOL finished){ 
                                         [self endGame];
                                     }];  
                    
                }     
                 
            }
            
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
