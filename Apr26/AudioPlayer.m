//
//  AudioPlayer.m
//  Apr26
//
//  Created by Georges Labreche on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

- (id) init{
    self = [super init];
    
    if(self){

    }
    
    return self;
}

- (AVAudioPlayer *) buildPlayerWithResource:(NSString*)soundFilename ofType:(NSString*) type inDirectory:(NSString*) directoryName withVolume:(float) volume andNumberOfLoops:(NSInteger) numofLoops {
    
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
    player.volume = volume;
    player.numberOfLoops = numofLoops;
    
    if (![player prepareToPlay]) {
        NSLog(@"could not prepare to play.");
        return nil;
    } 
    
    return player;
}
@end
