//
//  GameOver.h
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameOver : NSObject
+ (void) over:(UIView*) playLayer :(UILabel *) scoreLabel :(NSInteger) score;
@end
