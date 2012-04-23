//
//  HeadView.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        previousPinchScale = 0;
        [self initPinchGesture];

    }
    return self;
}

// init pinch gesture handler
- (void) initPinchGesture{
    NSLog(@"Initialise pinch gesture handler...");
    
    // Register pinch gesture recognizer
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget: self action: @selector(handlePinch:)
                                                 ];
    
    [self handlePinch: pinchRecognizer];
    [self addGestureRecognizer: pinchRecognizer];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    
    NSLog(@"Handle pinch.");
    
    if (recognizer.scale > previousPinchScale) {
        // Expand
        // Play expand sound
         NSLog(@"Head expand.");
    } else if (recognizer.scale < previousPinchScale) {
        // Shrink
        // Play shrink sound
        NSLog(@"Head shrink.");
    }
    
    // Animation
    [UIView animateWithDuration: 0.0 
                          delay: 0.0 
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         // define animation
                         self.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
                     }
                     completion: NULL
     ];
    
    previousPinchScale = recognizer.scale;
}

- (void)handleDeviceRotate{
    
    NSUInteger orientationId = [UIDevice currentDevice].orientation;
    NSLog(@"Rotated device: %i", orientationId);
    
    NSInteger rotationAngle = 0;
    
    if (UIDeviceOrientationPortrait == orientationId){
        rotationAngle = 0;
    }else if (UIDeviceOrientationPortraitUpsideDown == orientationId){
        rotationAngle = 180;
    }else if (UIDeviceOrientationLandscapeRight == orientationId){
        rotationAngle = -90;
    }else if (UIDeviceOrientationLandscapeLeft == orientationId){
        rotationAngle = 90;
    }
    
    // Animation
    [UIView animateWithDuration: 1.0
                          delay: 0.0 
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         // define animation
                         self.transform = CGAffineTransformMakeRotation(rotationAngle * M_PI / 180);
                     }
                     completion: NULL
     ];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
