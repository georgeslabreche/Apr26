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


- (id) init{
    self = [super init];
    
    if(self){
        moveAudioPlayer = [self buildPlayerWithMp3Resource:@"move" inDirectory: @"sounds"];
        spinAudioPlayer = [self buildPlayerWithMp3Resource:@"spin" inDirectory: @"sounds"];
        shrinkAudioPlayer = [self buildPlayerWithMp3Resource:@"shrink" inDirectory: @"sounds"];
        expandAudioPlayer = [self buildPlayerWithMp3Resource:@"expand" inDirectory: @"sounds"];
        rotateAudioPlayer = [self buildPlayerWithMp3Resource:@"rotate" inDirectory: @"sounds"];
        
        audioPlayerArray = [NSArray arrayWithObjects:
                            moveAudioPlayer,
                            spinAudioPlayer,
                            shrinkAudioPlayer,
                            expandAudioPlayer,
                            rotateAudioPlayer,
                            nil];
    }
    
    return self;
}


-(void) playSpinSound{
    NSLog(@"Play spin sound");
    if([spinAudioPlayer isPlaying] == false){
    
        // Stop any other sound
        NSEnumerator *e = [audioPlayerArray objectEnumerator];
        AVAudioPlayer *audioPlayer;
        while (audioPlayer = [e nextObject]) {
            [audioPlayer stop];
        }
        
        [spinAudioPlayer play];
    }
    
    
}

-(void) playMoveSound{
    NSLog(@"Play move sound");
    if([moveAudioPlayer isPlaying] == false){
        
         // Stop any other sound
        NSEnumerator *e = [audioPlayerArray objectEnumerator];
        AVAudioPlayer *audioPlayer;
        while (audioPlayer = [e nextObject]) {
            [audioPlayer stop];
        }
        
        [moveAudioPlayer play];
    }
}

-(void) playShrinkSound{
    NSLog(@"Play shrink sound");
    if([shrinkAudioPlayer isPlaying] == false){
        
         // Stop any other sound
        NSEnumerator *e = [audioPlayerArray objectEnumerator];
        AVAudioPlayer *audioPlayer;
        while (audioPlayer = [e nextObject]) {
            [audioPlayer stop];
        }
        
        [shrinkAudioPlayer play];
    }
}

-(void) playExpandSound{
    NSLog(@"Play expand sound");
    if([expandAudioPlayer isPlaying] == false){
        
         // Stop any other sound
        NSEnumerator *e = [audioPlayerArray objectEnumerator];
        AVAudioPlayer *audioPlayer;
        while (audioPlayer = [e nextObject]) {
            [audioPlayer stop];
        }
        
        [expandAudioPlayer play];
    }
}

-(void) playRotateSound{
    NSLog(@"Play device rotate sound");
    if([rotateAudioPlayer isPlaying] == false){
        
        // Stop any other sound
        NSEnumerator *e = [audioPlayerArray objectEnumerator];
        AVAudioPlayer *audioPlayer;
        while (audioPlayer = [e nextObject]) {
            [audioPlayer stop];
        }
        
        [rotateAudioPlayer play];
    }
}


- (AVAudioPlayer *) buildPlayerWithMp3Resource:(NSString*)soundFilename inDirectory:(NSString*) directoryName{
    
    AVAudioPlayer *player;
    
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle == nil) {
        NSLog(@"could not get the main bundle.");
        return nil;
    }
    
    //The path is the filename.
    
    NSString *path = [bundle pathForResource: soundFilename ofType: @"wav" inDirectory:directoryName];
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
