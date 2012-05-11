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
        
        UIImage *titleBackgound = [UIImage imageNamed:@"images/titlebackground.jpg"];
        UIImageView *titleBackgoundImageView = [[UIImageView alloc] initWithImage:titleBackgound];
        
        // Create title view
        UIImage *titleImage = [UIImage imageNamed:@"images/title.png"];
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
        
        //CGRect bounds = [[UIScreen mainScreen]bounds];
        //CGRect titleRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height); 
        UIView *titleView = [[UIView alloc]init];
        
        [titleView addSubview:titleBackgoundImageView];
        [titleView addSubview:titleImageView];
        
        self.view = titleView;
        
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
