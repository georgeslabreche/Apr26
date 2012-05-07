//
//  AsteroidViewController.m
//  Apr26
//
//  Created by Computerlab on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <stdlib.h>
#import "AsteroidViewController.h"
#import "AsteroidView.h"

@interface AsteroidViewController ()

@end

@implementation AsteroidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id) initWithSpaceViewSize:(CGSize) size{
    self = [self initWithNibName:nil bundle:nil];

    if(self){
        spaceViewSize = size;
        
        NSArray *trajectoriesFromLeft = [NSArray arrayWithObjects:
                                [NSNumber numberWithInt:FromLeftToUpperRight], 
                                [NSNumber numberWithInt:FromLeftToBottomRight], 
                                [NSNumber numberWithInt:FromLeftToRight], 
                                nil];
        
        NSArray *trajectoriesFromRight = [NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:FromRightToUpperLeft], 
                                 [NSNumber numberWithInt:FromRightToBottomLeft], 
                                 [NSNumber numberWithInt:FromRightToLeft], 
                                 nil];
        
        NSArray *trajectoriesFromAbove = [NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:FromAboveToBellowLeft], 
                                 [NSNumber numberWithInt:FromAboveToBellowRight], 
                                 [NSNumber numberWithInt:FromAboveToBellow], 
                                 nil];
        
        NSArray *trajectoriesFromBellow = [NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:FromBellowToAboveLeft], 
                                 [NSNumber numberWithInt:FromBellowToAboveRight], 
                                 [NSNumber numberWithInt:FromBellowToAbove], 
                                 nil];
        
        trajectories = [NSArray arrayWithObjects:
                        trajectoriesFromLeft,
                        trajectoriesFromRight,
                        trajectoriesFromAbove,
                        trajectoriesFromBellow,
                        nil];
    }
    return self;
}


// Get the start point coordinate for the asteroid's trajectory
- (CGPoint) getAsteroidStartPointForAsteroidSize:(CGSize) asteroidSize comingFrom: (NSInteger) asteroidOriginIndex{
    
    CGFloat x1 = 0;
    CGFloat y1 = 0;
    
    if(asteroidOriginIndex == FromLeft){
        NSLog(@"Asteroid coming from the left.");
        x1 = 0 - asteroidSize.width / 2;
        y1 = getRandomFloat(asteroidSize.height, spaceViewSize.height - asteroidSize.height);
        
    }
    
    else if(asteroidOriginIndex == FromRight){
        NSLog(@"Asteroid coming from the right.");
        x1 = spaceViewSize.width + asteroidSize.width / 2;
        y1 = getRandomFloat(asteroidSize.height, spaceViewSize.height - asteroidSize.height);
        
    }
    
    else if(asteroidOriginIndex == FromAbove){
        NSLog(@"Asteroid coming from above.");
        x1 = getRandomFloat(asteroidSize.width, spaceViewSize.width - asteroidSize.width);
        y1 = 0 - asteroidSize.height / 2;
        
    }
    
    else if(asteroidOriginIndex == FromBellow){
        NSLog(@"Asteroid coming from bellow.");
        x1 = getRandomFloat(asteroidSize.width, spaceViewSize.width - asteroidSize.width);
        y1 = spaceViewSize.height + asteroidSize.height / 2;
    }

    return CGPointMake(x1, y1);
}

// Get the end point coordinates for the asteroid's trajectory.
- (CGPoint) getAsteroidEndPointForAsteroidSize:(CGSize) asteroidSize comingFrom: (NSInteger) asteroidOriginIndex{

    CGFloat x2 = 0;
    CGFloat y2 = 0;
    
    NSInteger randomTrajectoryIndex = [self getRandomTrajectoryIndexForAsteroidComingFrom: asteroidOriginIndex];
  
    // I. ASTEROID COMES FROM THE LEFT OR THE RIGHT.
	//
	// X1 can either be:
    // On the left of the viewable screen: (0 - (image.width / 2))
    // On the right of the viewable screen: (bounds.width + (image.width / 2))
    //
	// If X1 is on the left or the the right of the viewable screen, the Y1 can 
	// be a random value in the following range:
    // [image.height ; (bounds.height - image.height]
	//
	// I. a. THE ASTEROID COMES FROM THE LEFT.
	//
	// We have 3 possible trajectories when the asteroid is starting on the left:
	//	1) From Left to Upper-Right.
	// 	2) From Left to Bottom-Right.
	//	3) From Left to Right.
	// 
	// The probability of each trajectories occuring should be equal:
	//
	// 		- 	For any value of X2 in the [bounds.width / 2; bounds.width] range, the trajectory can 
	//			either be From Left to Upper-Right or From Left to Bottom-Right.
	//			Hence the probability of X2 being in the [bounds.width / 2; bounds.width] range should
	//			then be 2/3.
	//
	//		- 	For a value of X2 equal to (bounds.width + (image.width / 2)), the trajectory 
	//			can only be from Left to Right.
	//			Hence the probability of X2 being equal to (bounds.width + (image.width / 2)) should 
	//			then be 1/3.
	//
	//
    // If X2 is in the [bounds.width / 2; bounds.width] range, then Y2 can have a value so that
	// The asteroid's trajectory is: 
    //      - From Left to Upper-Right: (0 - image.height / 2)
    //      - From Left to Bottom-Right: (bounds.height + image.height / 2)
    //
    // If X2 is equal to (bounds.width + (image.width / 2)), then Y2 can have a value so that
	// The asteroid's trajectory is from Left To Right: 
    //      [(0 - image.height / 2) ; (bounds.height + image.height / 2)]
	//
    if(randomTrajectoryIndex == FromLeftToUpperRight){
        NSLog(@"Asteroid Trajecory: Left -> Upper Right");
        
        x2 = getRandomFloat(spaceViewSize.width / 2, spaceViewSize.width);
        y2 = 0 - asteroidSize.height / 2;
    }
    
    else if(randomTrajectoryIndex == FromLeftToBottomRight){
        NSLog(@"Asteroid Trajecory: Left -> Bottom Right");
        
        x2 = getRandomFloat(spaceViewSize.width / 2, spaceViewSize.width);
        y2 = spaceViewSize.height + asteroidSize.height / 2;
    }
    
    else if(randomTrajectoryIndex == FromLeftToRight){
        NSLog(@"Asteroid Trajecory: Left -> Right");
        
        x2 = spaceViewSize.width + asteroidSize.width / 2;
        y2 = getRandomFloat(0 - asteroidSize.height / 2, spaceViewSize.height + asteroidSize.height / 2);
     
    }
    
    // I. b. THE ASTEROID COMES FROM THE RIGHT
	//
	// We have 3 possible trajectories when the asteroid is starting on the right:
	//	1) From Right to Upper-Left.
	// 	2) From Right to Bottom-Left.
	//	3) From Right to Left.
	// 
	// The probability of each trajectories occuring should be equal:
	//
	// 		- 	For any value of X2 in the [0; bounds.width / 2] range, the trajectory can 
	//			either be From Right to Upper-Left or From Right to Bottom-Left.
	//			Hence the probability of X2 being in the [0; bounds.width / 2] range should
	//			then be 2/3.
	//
	//		- 	For a value of X2 equal to (0 - (image.width / 2)), the trajectory 
	//			can only be from Right to Left.
	//			Hence the probability of X2 being equal to (0 - (image.width / 2)) should 
	//			then be 1/3.
	//
	// NOTE: The rules for calculating Y2 are the same as scenario  I. b.
	//
	// If X2 is in the [0; bounds.width / 2] range, then Y2 can have a value so that
	// The asteroid's trajectory is: 
    //      - From Right to Upper-Left: (0 - image.height / 2)
    //      - From Right to Bottom-Left: (bounds.height + image.height / 2)
	//
	// If X2 is equal to (0 - (image.width / 2)), then Y2 can have a value so that
	// The asteroid's trajectory is from Right To Left: 
    //      [(0 - image.height / 2) ; (bounds.height + image.height / 2)]
    //
    else if(randomTrajectoryIndex == FromRightToUpperLeft){
        NSLog(@"Asteroid Trajecory: Right -> Upper Left");
        
        x2 = getRandomFloat(0, spaceViewSize.width / 2);
        y2 = 0 - asteroidSize.height / 2;
    }
    
    else if(randomTrajectoryIndex == FromRightToBottomLeft){
        NSLog(@"Asteroid Trajecory: Right -> Borrom Left");
        
        x2 = getRandomFloat(0, spaceViewSize.width / 2);
        y2 = spaceViewSize.height + asteroidSize.height / 2;
    }
    
    else if(randomTrajectoryIndex == FromRightToLeft){
        NSLog(@"Asteroid Trajecory: Right -> Left");
        
        x2 = 0 - asteroidSize.width / 2;
        y2 = getRandomFloat(0 - asteroidSize.height / 2, spaceViewSize.height + asteroidSize.height / 2);
    }
    
    // II. ASTEROID COMES FROM ABOVE OR BELLOW.
	//
	// NOTE: Use the the same logic as I.a and I.b but invert setting of values between X and Y
	// and use of height and width.
	//
	// Y1 can either be:
    // Above the viewable screen: (0 - (image.height / 2))
    // Below the of the viewable screen: (bounds.height + (image.height / 2))
	//
	// If Y1 is above or below of the viewable screen, then X1 can 
	// be a random value in the following range:
    // [image.width ; (bounds.width - image.width]
	//
	// II. a. THE ASTEROID COMES FROM ABOVE.
	//
	// We have 3 possible trajectories when the asteroid is starting from above
	//	1) From Above to Bottom-Left.
	// 	2) From Above to Bottom-Right.
	//	3) From Above to Bottom.
	//
	// The probability of each trajectories occuring should be equal:
	//
	// 		- 	For any value of Y2 in the [bounds.height / 2; bounds.height] range, the trajectory can 
	//			either be From Above to Bottom-Left or From Above to Bottom-Right.
	//			Hence the probability of Y2 being in the [bounds.height / 2; bounds.height] range should
	//			then be 2/3.
	//
	//		- 	For a value of Y2 equal to (bounds.height + (image.height / 2)), the trajectory 
	//			can only be From Above to Bottom.
	//			Hence the probability of Y2 being equal to (bounds.height + (image.height / 2)) should 
	//			then be 1/3.
	//
	// If Y2 is in the [bounds.height / 2; bounds.height] range, then X2 can have a value so that
	// The asteroid's trajectory is: 
    //      - From Above to Bottom-Left: (0 - image.width / 2)
    //      - From Above to Bottom-Right: (bounds.width + image.width / 2)
    //
    // If Y2 is equal to (bounds.height + (image.height / 2)), then X2 can have a value so that
	// The asteroid's trajectory is From Above to Bottom. 
    //      [(0 - image.width / 2) ; (bounds.width + image.width / 2)]
    //
    else if(randomTrajectoryIndex == FromAboveToBellowLeft){
        NSLog(@"Asteroid Trajecory: Above -> Bellow Left");
        y2 = getRandomFloat(spaceViewSize.height / 2, spaceViewSize.height);
        x2 = 0 - asteroidSize.width / 2;
    }
    
    else if(randomTrajectoryIndex == FromAboveToBellowRight){
        NSLog(@"Asteroid Trajecory: Above -> Bellow Right");
        y2 = getRandomFloat(spaceViewSize.height / 2, spaceViewSize.height);
        x2 = spaceViewSize.width + asteroidSize.width / 2;
        
    }
    
    else if(randomTrajectoryIndex == FromAboveToBellow){
        NSLog(@"Asteroid Trajecory: Above -> Bellow");
        y2 = spaceViewSize.height + asteroidSize.height / 2;
        x2 = getRandomFloat(0 - asteroidSize.width / 2, spaceViewSize.width + asteroidSize.width / 2);    
    }
    
    //
	// II. b. THE ASTEROID COMES FROM ABOVE.
	//
	// We needn't detail this last case, the logic is predictable enough at this point.
    //
    else if(randomTrajectoryIndex == FromBellowToAboveLeft){
        NSLog(@"Asteroid Trajecory: Bellow -> Above Left");
        
        y2 = getRandomFloat(0, spaceViewSize.height / 2);
        x2 = 0 - asteroidSize.width / 2;
    }
    
    else if(randomTrajectoryIndex == FromBellowToAboveRight){
        NSLog(@"Asteroid Trajecory: Bellow -> Above Right");
        
        y2 = getRandomFloat(0, spaceViewSize.height / 2);
        x2 = spaceViewSize.width + asteroidSize.width / 2;
    }
    
    else if(randomTrajectoryIndex == FromBellowToAbove){
        NSLog(@"Asteroid Trajecory: Bellow -> Above");
        
        y2 = 0 - asteroidSize.height / 2;
        x2 = getRandomFloat(0 - asteroidSize.width / 2, spaceViewSize.width + asteroidSize.width / 2);
        
    }

    // Return end point
    return CGPointMake(x2, y2);
}

// Get random trajectory path for the asteroid
- (NSInteger) getRandomTrajectoryIndexForAsteroidComingFrom: (NSInteger) asteroidOriginIndex{
    
    // Get the appropriate array of possible trajectories based on where the asteroid will be coming from
    NSArray *trajectoryArray = [trajectories objectAtIndex:asteroidOriginIndex];
    
    // For each start point, the asteroid has 3 families of possible trajectories.
    // The 3 families of possible trajectories are in the array we just retrieved.
    // Let's pick one at random
    
    NSInteger trajectoryIndex = arc4random() % 3; 
   
    NSNumber *randomTrajectoryIndex = [trajectoryArray objectAtIndex:trajectoryIndex];

    return randomTrajectoryIndex.integerValue;
}


- (void)loadView
{ 
    
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
   
    // Create asteroid.
    // Put it in random start point that is outside the visible space view
    UIImage *asteroidImage = [UIImage imageNamed:@"images/asteroids/asteroid-01.png"];
    
    // The asteroid can have 4 origins: left, right, above and bellow.
    NSInteger randomAsteroidOriginIndex = arc4random() % 4; 
 
    CGPoint startPoint = [self getAsteroidStartPointForAsteroidSize: asteroidImage.size 
                                                         comingFrom: randomAsteroidOriginIndex];
    
    asteroidView = [[AsteroidView alloc] initWithImage:asteroidImage andCenter: startPoint];
    self.view = asteroidView;
    
    // Get a random target end point for the asteroid:
    CGPoint endPoint = [self getAsteroidEndPointForAsteroidSize:asteroidImage.size 
                                                     comingFrom:randomAsteroidOriginIndex];
    
    
    NSLog(@"Launching Asteroid! (%f,%f) -> (%f,%f)", startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    
    
    // Launch the asteroid!
    
    [UIView animateWithDuration: 5.0
                          delay: 0.0 
                        options: UIViewAnimationCurveLinear
                     animations: ^{
                         // define animation 
                         self.view.center = endPoint;
                     }
                     completion: NULL
     ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // When asteroid view is loaded, launch it!
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

CGFloat getRandomFloat(CGFloat smallNumber, CGFloat bigNumber){
    CGFloat diff = bigNumber - smallNumber;
    return diff * rand() / RAND_MAX + smallNumber;
}

@end


