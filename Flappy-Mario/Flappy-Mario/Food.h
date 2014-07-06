//
//  Food.h
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

+ (NSInteger) foodScore:(CGRect)rect1 :(CGRect)rect2 :(UIView*)pileImgView11 :(UIView*)pileImgView12 :(UIView*)food11 :(UIView*)food12 :(UIView*)food21 :(UIView*)food22 :(UIView*)straw1 :(UIView*)straw2 :(NSInteger)score :(UILabel*)scoreLabel :(NSInteger)birdUpY;

@end
