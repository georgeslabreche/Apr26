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
    
    
    
    CGRect asteroidViewFrame = CGRectMake(centerPoint.x, centerPoint.y, image.size.width, image.size.height);
    self = [super initWithFrame:asteroidViewFrame];
    
    if(self){
        
        UIImageView *asteroidImageView = [[UIImageView alloc]initWithFrame:asteroidViewFrame];
        
        // Set head image for the image view
        asteroidImageView.image = image;
        
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
