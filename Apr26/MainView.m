//
//  MainView.m
//  Apr26
//
//  Created by Georges Labreche on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "HeadView.h"

@implementation MainView

// default constructure just gives the same sound to every head
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        
        
        NSBundle *bundle = [NSBundle mainBundle];
        if (bundle == nil) {
            NSLog(@"could not get the main bundle.");
            
        }else{
            
            NSString *headImageFilePath = [bundle pathForResource: @"head" ofType: @"png" inDirectory:@"images"];
            UIImage *headImage = [UIImage imageWithContentsOfFile: headImageFilePath];
            
            CGFloat headOriginX = (self.bounds.size.width / 2) - (headImage.size.width / 2);
            CGFloat headOriginY = (self.bounds.size.height / 2) - (headImage.size.height / 2);
            CGRect headImageFrame = CGRectMake(headOriginX, headOriginY, headImage.size.width, headImage.size.height);
            
            HeadView *headView = [[HeadView alloc]initWithFrame:headImageFrame];
            headView.image = headImage;
            
            [self addSubview:headView];
            
            NSLog(@"Head view loaded: %@.", headImageFilePath);
        }
        
        
        
    }
    return self;
}




@end
