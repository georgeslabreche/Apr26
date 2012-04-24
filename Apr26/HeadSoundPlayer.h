//
//  HeadSoundPlayer.h
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface HeadSoundPlayer : NSObject{
    AVAudioPlayer *moveAudioPlayer;
    AVAudioPlayer *spinAudioPlayer;
    AVAudioPlayer *shrinkAudioPlayer;
    AVAudioPlayer *expandAudioPlayer;
    AVAudioPlayer *rotateAudioPlayer;
    
    NSArray *audioPlayerArray;
    
}

@property AVAudioPlayer* moveAudioPlayer;

-(void) playSpinSound;
-(void) playMoveSound;
-(void) playShrinkSound;
-(void) playExpandSound;
-(void) playRotateSound;

@end
