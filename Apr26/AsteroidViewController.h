//
//  AsteroidViewController.h
//  Apr26
//
//  Created by Computerlab on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsteroidView.h"

@interface AsteroidViewController : UIViewController{
    AsteroidView *asteroidView;
    CGSize spaceViewSize;
    
    enum {
        FromLeft,
        FromRight,
        FromAbove,
        FromBellow
    } AsteroidOriginArea;
    
    enum {
        FromLeftToUpperRight,
        FromLeftToBottomRight,
        FromLeftToRight,
        
        FromRightToUpperLeft,
        FromRightToBottomLeft,
        FromRightToLeft,
        
        FromAboveToBellowLeft,
        FromAboveToBellowRight,
        FromAboveToBellow,
        
        FromBellowToAboveLeft,
        FromBellowToAboveRight,
        FromBellowToAbove
        
    } TrajectoryOfAsteroid;
    
    NSArray *trajectories;
}

- (id) initWithSpaceViewSize:(CGSize) size;

@end
