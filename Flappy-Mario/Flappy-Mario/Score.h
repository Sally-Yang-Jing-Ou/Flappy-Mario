//
//  Score.h
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#define kBestScoreKey @"BestScore"
#import <Foundation/Foundation.h>

@interface Score : NSObject

+ (void) registerScore:(NSInteger)score;
+ (void) setBestScore:(NSInteger) bestScore;
+ (NSInteger) bestScore;

@end
