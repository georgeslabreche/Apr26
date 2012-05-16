//
//  HeadSoundPlayer.m
//  Apr26
//
//  Created by Georges Labreche on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadSoundPlayer.h"

@implementation HeadSoundPlayer

@synthesize moveAudioPlayer;
@synthesize ouchAudioPlayer;



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
        // Init players
        moveAudioPlayer = [super buildPlayerWithResource:@"move" ofType:@"wav" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0];
        
        spinAudioPlayer = [super buildPlayerWithResource:@"spin" ofType:@"wav" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0];
        
        shrinkAudioPlayer = [super buildPlayerWithResource:@"shrink" ofType:@"wav" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0];
        
        expandAudioPlayer = [super buildPlayerWithResource:@"expand" ofType:@"wav" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0];
        
        rotateAudioPlayer = [super buildPlayerWithResource:@"rotate" ofType:@"wav" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0];
        
        ouchAudioPlayer = [super buildPlayerWithResource:@"ouch" ofType:@"mp3" inDirectory: @"sounds" withVolume:2.0  andNumberOfLoops:0]; 
        
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
    if([spinAudioPlayer isPlaying] == false){
    
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
         NSLog(@"Play spin sound");
        [spinAudioPlayer play];
    }
    
    
}

-(void) playMoveSound{
    if([moveAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        NSLog(@"Play move sound");
        [moveAudioPlayer play];
    }
}

-(void) playShrinkSound{
    if([shrinkAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        NSLog(@"Play shrink sound");
        [shrinkAudioPlayer play];
    }
}

-(void) playExpandSound{
    if([expandAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        NSLog(@"Play expand sound");
        [expandAudioPlayer play];
    }
}

-(void) playRotateSound{
    if([rotateAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        NSLog(@"Play device rotate sound");
        [rotateAudioPlayer play];
    }
}

-(void) playOuchSound{
    if([ouchAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        [self stopAllPlayers];
        
        // Play sound
        NSLog(@"Play device ouch sound");
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



@end
