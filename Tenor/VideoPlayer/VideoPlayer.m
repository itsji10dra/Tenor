//
//  VideoPlayerManager.m
//  Tenor
//
//  Created by Jitendra on 28/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoPlayer

+(AVPlayerViewController *)playVideoWithURL:(NSURL *)url {
    
    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    [playerVC setPlayer:player];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [[window rootViewController] presentViewController:playerVC animated:YES completion:^{
        [player play];
    }];
    
    return playerVC;
}
    
@end
