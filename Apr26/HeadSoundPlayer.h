//
//  HeadSoundPlayer.h
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "AudioPlayer.h"

@interface HeadSoundPlayer : AudioPlayer{
    
    // Using AVAudioPlayer is too much for these sound bits that are lesser than 30 seconds
    // but we are just experimenting here and it's the easiest way to control sound (pause, stop, play methods etc)
    AVAudioPlayer *moveAudioPlayer;
    AVAudioPlayer *spinAudioPlayer;
    AVAudioPlayer *shrinkAudioPlayer;
    AVAudioPlayer *expandAudioPlayer;
    AVAudioPlayer *rotateAudioPlayer;
    AVAudioPlayer *ouchAudioPlayer;
    
    NSArray *audioPlayerArray;
    
}

// Expose these so that we can get the duration value
// And use that as animation duration for the animation
// Associated with the sound.
@property AVAudioPlayer* moveAudioPlayer;
@property AVAudioPlayer* ouchAudioPlayer;

// Singleton access
+ (id) sharedInstance;

-(void) playSpinSound;
-(void) playMoveSound;
-(void) playShrinkSound;
-(void) playExpandSound;
-(void) playRotateSound;
-(void) playOuchSound;

@end
