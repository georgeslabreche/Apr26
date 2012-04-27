//
//  AsteroidViewController.m
//  Apr26
//
//  Created by Computerlab on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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


- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
   
    // Create head view and set it as the view of this controller.
    UIImage *asteroidImage = [UIImage imageNamed:@"images/asteroids/asteroid-01.png"];
    

    //CGRect mainScreenBounds = [[UIScreen mainScreen]bounds];
    
    // X1 is either 
    // On the left of the viewable screen: (0 - (image.width / 2))
    // On the right of the viewable screen: (bounds.width + (image.width / 2))
    
    // For either of those X1s, the Y1 can be a random value between:
    // [(0 - image.height / 2) ; (bounds.height + image.height / 2)]
    
    // If the X1 is on the left of the view screen, then X2 can be
    // any value between [0 ; (bounds.width + (image.width / 2))]
    //
    // If the X1 is on the right of the view screen, then X2 can be
    // any value between [(0 - image.width / 2) ; bounds.width]
    // 
    // If X2 is between 0 and bounds.width then Y2 can either be: 
    //      - (0 - image.height / 2)
    //      - (bounds.height + image.height / 2)
    //
    // If X2 is greater than bounds.width. then Y2 can be between:
    //      - [(0 - image.height / 2) ; (bounds.height + image.height / 2)]
    
    
    
    // Now do when X1 is between [0 ; bounds.width]
    
   

    
    CGPoint asteroidStartPoint = CGPointMake(50, 50);
    
    asteroidView = [[AsteroidView alloc] initWithImage:asteroidImage andCenter: asteroidStartPoint];
    self.view = asteroidView;
    /*
    [UIView animateWithDuration: 5.0
                          delay: 0.0 
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         // define animation 
                         self.view.center = CGPointMake(200, 300);
                     }
                     completion: NULL
     ]; */
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


@end
