//
//  MenuViewController.m
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) init{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self){
        
        // BACKGROUND VIEW
        // Create background image view. This view contains the game title/menu background image.
        UIImage *titleBackgound = [UIImage imageNamed:@"images/titlebackground.jpg"];
        UIImageView *titleBackgoundImageView = [[UIImageView alloc] initWithImage:titleBackgound];
        
        // TITLE VIEW
        // Create title view. This view contains the title image view of the game
        UIImage *titleImage = [UIImage imageNamed:@"images/title.png"];
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
        
        // Use simple math toe place the title where we want.
        // Center x and slight above center y.
        CGRect bounds = [[UIScreen mainScreen]bounds];
        CGFloat titleViewCoordinateY = bounds.size.height / 2 - titleImageView.bounds.size.height;
        CGFloat titleViewCoordinateX = (bounds.size.width - titleImageView.bounds.size.width) / 2;
        
        CGRect titleViewRect = CGRectMake(titleViewCoordinateX, titleViewCoordinateY, titleImageView.bounds.size.width, titleImageView.bounds.size.height);
        
       
        UIView *titleView = [[UIView alloc]initWithFrame:titleViewRect];
        [titleView addSubview:titleImageView];
        
        // STARRING MARK MERETZKY VIEW
        // Create the "Starring Mark Meretzky" view.
        
        // Place it under the title view.
        // Quick and dirty math for the placement
        CGFloat starringLabelCoordinateX = bounds.size.width / 6;
        CGFloat starringLabelCoordinateY = titleViewCoordinateY + titleViewRect.size.height + titleViewCoordinateY / 11;

        CGRect starringLabelRect = CGRectMake(starringLabelCoordinateX, starringLabelCoordinateY, titleImageView.bounds.size.width, 25);
        
        UILabel *starringLabel = [[UILabel alloc] initWithFrame:starringLabelRect];
        starringLabel.text = @"Starring Mark Meretzky!";
        starringLabel.backgroundColor = [UIColor clearColor];
        starringLabel.textColor = [UIColor colorWithRed:1 green:0.8 blue:0 alpha:1]; /*#ffcc00*/
        starringLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:18];
        
        
        // Create title view containter.
        // This view contains all of the views that form the game menu intro view.
        UIView *titleViewContainer = [[UIView alloc] init];
        
        [titleViewContainer addSubview:titleBackgoundImageView];
        [titleViewContainer addSubview:titleView];
        [titleViewContainer addSubview:starringLabel];                           
        
        self.view = titleViewContainer;
        
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

@end
