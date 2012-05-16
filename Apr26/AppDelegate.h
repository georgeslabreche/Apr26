//
//  AppDelegate.h
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    MainViewController *mainViewController;
}

@property (strong, nonatomic) UIWindow *window;

- (void) transitionToGameView;
- (void) transitionToIntroView;

@end
