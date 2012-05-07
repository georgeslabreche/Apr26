//
//  HeadViewController.h
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "HeadSoundPlayer.h"

@interface HeadViewController : UIViewController{
    CGSize spaceViewSize;
    
    UIDevice *device;
    HeadView *headView;
    CGFloat previousPinchScale;
    
    HeadSoundPlayer *headSoundPlayer;
}

- (id) initWithSpaceViewSize:(CGSize) size;

@end
