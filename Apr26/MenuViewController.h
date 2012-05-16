//
//  MenuViewController.h
//  Apr26
//
//  Created by Georges Labreche on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPlayer.h"

@interface MenuViewController : UIViewController{
    UITapGestureRecognizer *singleTapGestureRecognizer;
    MusicPlayer *musicPlayer;
}

@end
