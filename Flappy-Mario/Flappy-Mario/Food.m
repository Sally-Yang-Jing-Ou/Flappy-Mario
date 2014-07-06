//
//  Food.m
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//
#import "Food.h"

@implementation Food

+ (NSInteger) foodScore:(CGRect)rect1 :(CGRect)rect2 :(UIView*)b1pipe1 :(UIView*)b1pipe2 :(UIView*)food11 :(UIView*)food12 :(UIView*)food21 :(UIView*)food22 :(UIView*)straw1 :(UIView*)straw2 :(NSInteger)score :(UILabel*)scoreLabel :(NSInteger)marioTopY{
    if (rect1.origin.x == 58 && marioTopY >= (b1pipe1.frame.origin.y + 319 + 20)){
        food11.hidden = YES;
        score += 1;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    else if (rect1.origin.x  == -102){
        if (b1pipe2.hidden == YES){
            return score;
        }
        food12.hidden = YES;
        score += 1;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    else if (rect2.origin.x == 58){
        food21.hidden = YES;
        score += 1;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    else if (rect2.origin.x == -102){
        food22.hidden = YES;
        score += 1;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    
    else if (rect2.origin.x == -32 && (straw2.frame.origin.y - 28 <= marioTopY && straw2.frame.origin.y + 34 >= marioTopY)){
        straw2.hidden = YES;
        score +=2;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    
    else if (rect1.origin.x == -32 && (straw1.frame.origin.y - 28 <= marioTopY && straw1.frame.origin.y + 34 >= marioTopY)){
        if (straw1.hidden == YES){
            return score;
        }
        straw1.hidden = YES;
        score +=2;
        scoreLabel.text = [NSString stringWithFormat:@"score: %d",score];
    }
    return score;
}
@end
