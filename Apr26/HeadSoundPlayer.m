//
//  HeadSoundPlayer.m
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import "HeadSoundPlayer.h"

@implementation HeadSoundPlayer

@synthesize moveAudioPlayer;
@synthesize ouchAudioPlayer;

// make singleton
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
        moveAudioPlayer = [self buildPlayerWithResource:@"move" ofType:@"wav" inDirectory: @"sounds"];
        spinAudioPlayer = [self buildPlayerWithResource:@"spin" ofType:@"wav" inDirectory: @"sounds"];
        shrinkAudioPlayer = [self buildPlayerWithResource:@"shrink" ofType:@"wav" inDirectory: @"sounds"];
        expandAudioPlayer = [self buildPlayerWithResource:@"expand" ofType:@"wav" inDirectory: @"sounds"];
        rotateAudioPlayer = [self buildPlayerWithResource:@"rotate" ofType:@"wav" inDirectory: @"sounds"];
        ouchAudioPlayer = [self buildPlayerWithResource:@"ouch" ofType:@"mp3" inDirectory: @"sounds"]; 
        
        audioPlayerArray = [NSArray arrayWithObjects:
                            moveAudioPlayer,
                            spinAudioPlayer,
                            shrinkAudioPlayer,
                            expandAudioPlayer,
                            rotateAudioPlayer,
                            ouchAudioPlayer,
                            nil];
    }
    
    return self;
}


-(void) playSpinSound{
    NSLog(@"Play spin sound");
    if([spinAudioPlayer isPlaying] == false){
    
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [spinAudioPlayer play];
    }
    
    
}

-(void) playMoveSound{
    NSLog(@"Play move sound");
    if([moveAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [moveAudioPlayer play];
    }
}

-(void) playShrinkSound{
    NSLog(@"Play shrink sound");
    if([shrinkAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [shrinkAudioPlayer play];
    }
}

-(void) playExpandSound{
    NSLog(@"Play expand sound");
    if([expandAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [expandAudioPlayer play];
    }
}

-(void) playRotateSound{
    NSLog(@"Play device rotate sound");
    if([rotateAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [rotateAudioPlayer play];
    }
}

-(void) playOuchSound{
    NSLog(@"Play device ouch sound");
    if([ouchAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        [ouchAudioPlayer play];
    }
}

-(void) stopAllPlayers{
    
    // Stop any other sound
    NSEnumerator *e = [audioPlayerArray objectEnumerator];
    AVAudioPlayer *audioPlayer;
    while (audioPlayer = [e nextObject]) {
        
        if([audioPlayer isPlaying]){
            [audioPlayer stop];
        }
    }
    
}

- (AVAudioPlayer *) buildPlayerWithResource:(NSString*)soundFilename ofType:(NSString*) type inDirectory:(NSString*) directoryName{
    
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
    player.volume = 2.0;
    player.numberOfLoops = 0;
    
    if (![player prepareToPlay]) {
        NSLog(@"could not prepare to play.");
        return nil;
    } 
    
    return player;
}



@end
