//
//  HeadView.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView


// Init with the image of a head
- (id)initWithImage:(UIImage *)image{
    
    CGRect headViewFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    self = [super initWithFrame:headViewFrame];
    
    if(self){
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:headViewFrame];
        // Enabled detection of gestures and touches.
        headImageView.userInteractionEnabled = YES;
        
        // Set head image for the image view
        headImageView.image = image;
        
        [self addSubview:headImageView];
    }
    
    return self;
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
