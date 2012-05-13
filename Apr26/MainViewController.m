//
//  MainViewController.m
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "SpaceViewController.h"
#import "MusicPlayer.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        
        gameStarted = false;
        musicPlayer = [MusicPlayer sharedInstance];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Our views
    MenuViewController *menuViewController  = [[MenuViewController alloc]init];
    spaceViewController = [[SpaceViewController alloc]init];
    
    // Array of views
    views = [NSArray arrayWithObjects:
             menuViewController.view,
             spaceViewController.view,
             nil
             ];
    
    [self.view addSubview: menuViewController.view];
    
    // add single tap gesture
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                  initWithTarget: self action: @selector(transitionToGameView:)
                                  ];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: singleTapGestureRecognizer];
    
    [musicPlayer playIntroMusic];
    
}

- (void) transitionToGameView: (UISwipeGestureRecognizer *) recognizer {
    [UIView transitionFromView: [views objectAtIndex: 0]
                        toView: [views objectAtIndex: 1]
                      duration: 1
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    completion: NULL
     ];
    
    
    // Unregister the tap gesture, no longer required.
    if(singleTapGestureRecognizer != nil){
        [self.view removeGestureRecognizer:singleTapGestureRecognizer];
    }
    
    [spaceViewController startGame];
    [musicPlayer playGameMusic];
    
}

// Start the game.
//TODO: Once the game has started, this should pass the event to the controller
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!gameStarted){
        [UIView transitionFromView: [views objectAtIndex: 0]
                            toView: [views objectAtIndex: 1]
                          duration: 1
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        completion: NULL
         ];
    
        [spaceViewController startGame];
        
        gameStarted = true;
    }else{
        // If game has started, defer the touch event to the game view
        // We can't do something like this:
        //[spaceViewController touchesBegan:touches withEvent:event];
    }
    
}
*/


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
