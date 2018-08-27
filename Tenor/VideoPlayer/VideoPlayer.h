//
//  VideoPlayer.h
//  Tenor
//
//  Created by Jitendra on 28/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <Foundation/Foundation.h>

@interface VideoPlayer : NSObject

+(nonnull AVPlayerViewController *)playVideoWithURL:(NSURL *_Nonnull)url;
    
@end
