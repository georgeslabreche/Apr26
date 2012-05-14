//
//  AudioPlayer.h
//  Apr26
//
//  Created by Georges Labreche on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface AudioPlayer : NSObject

// Create player
- (AVAudioPlayer *) buildPlayerWithResource:(NSString*)soundFilename ofType:(NSString*) type inDirectory:(NSString*) directoryName withVolume:(float) volume andNumberOfLoops:(NSInteger) numofLoops;
@end
