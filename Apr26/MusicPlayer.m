//
//  MusicPlayer.m
//  Apr26
//
//  Created by Georges Labreche on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicPlayer.h"
#import <AVFoundation/AVAudioPlayer.h>

@implementation MusicPlayer

// singleton
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
        gameIntroMusicPlayer = [self buildPlayerWithResource:@"intromusic" ofType:@"mp3" inDirectory: @"sounds"];
        gameMusicPlayer = [self buildPlayerWithResource:@"gamemusic" ofType:@"mp3" inDirectory: @"sounds"];

    }
    
    return self;
}


-(void) playIntroMusic{
    // Play sound
    [gameIntroMusicPlayer play];
    
}

// Music from: http://www.last.fm/music/Mahox/_/Electronic+Space
-(void) playGameMusic{

    // Stop game intro music
    [gameIntroMusicPlayer stop];
        
    // Play sound
    [gameMusicPlayer play];
}


//TODO: Pull up in Abstract class and use it in HeadSoundPlayer as well.
- (AVAudioPlayer *) buildPlayerWithResource:(NSString*)soundFilename ofType:(NSString*) type inDirectory:(NSString*) directoryName /*withVolume:(NSInteger) volume andNumberOfLoops:(NSInteger) numofLoops*/ {
    
    AVAudioPlayer *player;
    
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle == nil) {
        NSLog(@"could not get the main bundle.");
        return nil;
    }
    
    //The path is the filename.
    
    NSString *path = [bundle pathForResource: soundFilename ofType: type inDirectory:directoryName];
    if (path == nil) {
        NSLog(@"could not get the mp3 sound path.");
        return nil;
    }
    
    NSLog(@"path == \"%@\"", path);
    
    NSURL *url = [NSURL fileURLWithPath: path isDirectory: NO];
    NSLog(@"url == \"%@\"", url);
    
    NSError *error = nil;
    player = [[AVAudioPlayer alloc]
              initWithContentsOfURL: url error: &error];
    if (player == nil) {
        NSLog(@"error == %@", error);
        return nil;
    }
    
    // player properties
    player.volume = 1.0;
    player.numberOfLoops = 0;
    
    if (![player prepareToPlay]) {
        NSLog(@"could not prepare to play.");
        return nil;
    } 
    
    return player;
}


@end
