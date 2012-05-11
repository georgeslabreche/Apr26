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
        
        //UIView *mainView =  [[UIView alloc]init];
        //self.view = mainView;
        
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
    
    
    views = [NSArray arrayWithObjects:
             menuViewController.view,
             spaceViewController.view,
             nil
             ];
    
    [self.view addSubview: menuViewController.view];
    
    // add single tap gesture
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                         initWithTarget: self action: @selector(swipe:)
                                         ];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: singleTapGestureRecognizer];
}

- (void) swipe: (UISwipeGestureRecognizer *) recognizer {
    NSLog(@"Switch view.");

    [UIView transitionFromView: [views objectAtIndex: 0]
                        toView: [views objectAtIndex: 1]
                      duration: 1
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    completion: NULL
    ];
    
    
        
    if(singleTapGestureRecognizer != nil){
        [self.view removeGestureRecognizer:singleTapGestureRecognizer];
    }
    
    [spaceViewController startGame];
    
    
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
