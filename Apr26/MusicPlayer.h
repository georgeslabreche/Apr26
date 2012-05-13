//
//  MusicPlayer.h
//  Apr26
//
//  Created by Georges Labreche on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface MusicPlayer : NSObject{
    AVAudioPlayer *gameIntroMusicPlayer;
    AVAudioPlayer *gameMusicPlayer;
}

+ (id) sharedInstance;
-(void) playIntroMusic;
-(void) playGameMusic;

@end
