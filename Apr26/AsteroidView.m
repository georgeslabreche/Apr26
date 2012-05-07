//
//  AsteroidView.m
//  Apr26
//
//  Created by Computerlab on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AsteroidView.h"


@implementation AsteroidView

// Init with the image of a head
- (id)initWithImage:(UIImage *)image andCenter:(CGPoint) centerPoint{
    
    
    
    CGRect asteroidImageViewFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    self = [super initWithFrame:asteroidImageViewFrame];
    
    if(self){
        
        UIImageView *asteroidImageView = [[UIImageView alloc]initWithFrame:asteroidImageViewFrame];
        
        // Set asteroid image for the image view
        asteroidImageView.image = image;
        
        // Place it where we want it to be in space
        self.center = centerPoint;
        self.backgroundColor = [UIColor yellowColor];
        
        // Add it to space
        [self addSubview:asteroidImageView];
        
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
