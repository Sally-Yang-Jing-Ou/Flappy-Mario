//
//  OverDetection.h
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverDetection : NSObject
+ (void) detection:(NSInteger)marioTopY :(NSInteger)marioButtomY :(NSInteger)marioRight :(UIView*)back1 :(UIView*)back2 :(UIView*)b1pipe1 :(UIView*)b1pipe2 :(UIView*)b2pipe1 :(UIView*)b2pipe2;

@end
