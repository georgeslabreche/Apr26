//
//  MusicPlayer.m
//  Apr26
//
//  Created by Georges Labreche on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicPlayer.h"

@implementation MusicPlayer


// Make this class a singleton
+ (id) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


- (id) init{
    self = [super init];
    
    if(self){
        gameIntroMusicPlayer = [super buildPlayerWithResource:@"intromusic" ofType:@"mp3" inDirectory: @"sounds" withVolume:1.0  andNumberOfLoops:-1];
        gameMusicPlayer = [super buildPlayerWithResource:@"gamemusic" ofType:@"mp3" inDirectory: @"sounds" withVolume:1.0  andNumberOfLoops:-1];

    }
    
    return self;
}


// http://www.last.fm/music/dezecrator/_/Intro-electro
-(void) playIntroMusic{
    // Stop game music
    if([gameMusicPlayer isPlaying]){
        [gameMusicPlayer stop];
    }
    
    // Play sound
    [gameIntroMusicPlayer play];
    
}

// Music from: http://www.last.fm/music/Mahox/_/Electronic+Space
-(void) playGameMusic{

    // Stop game intro music
    if([gameIntroMusicPlayer isPlaying]){
        [gameIntroMusicPlayer stop];
    }
    
    // Play sound
    [gameMusicPlayer play];
}





@end
