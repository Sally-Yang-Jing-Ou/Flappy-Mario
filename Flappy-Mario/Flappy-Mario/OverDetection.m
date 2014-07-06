//
//  OverDetection.m
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#import "OverDetection.h"
#import "MarioViewController.h"

@implementation OverDetection
+ (void) detection:(NSInteger)marioTopY :(NSInteger)marioButtomY :(NSInteger)marioRight :(UIView*)back1 :(UIView*)back2 :(UIView*)b1pipe1 :(UIView*)b1pipe2 :(UIView*)b2pipe1 :(UIView*)b2pipe2
{
    if (marioRight == back1.frame.origin.x && marioTopY >= 439 + b1pipe1.frame.origin.y)
    {
        if (b1pipe1.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    else  if(marioRight == back1.frame.origin.x && marioButtomY <= 319 + b1pipe1.frame.origin.y)
    {
        if (b1pipe1.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    
    else if (marioRight - 160 == back1.frame.origin.x && marioTopY >= 439 + b1pipe2.frame.origin.y)
    {
        if (b1pipe2.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    else  if(marioRight - 160 == back1.frame.origin.x && marioButtomY <= 319 + b1pipe2.frame.origin.y)
    {
        if (b1pipe2.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    
    else if (marioRight == back2.frame.origin.x && marioTopY >= 439 + b2pipe1.frame.origin.y)
    {
        [MarioViewController gameOver];
    }
    else  if(marioRight == back2.frame.origin.x && marioButtomY <= 319 + b2pipe1.frame.origin.y)
    {
        [MarioViewController gameOver];
    }
    
    else if (marioRight - 160 == back2.frame.origin.x && marioTopY >= 439 + b2pipe2.frame.origin.y)
    {
        [MarioViewController gameOver];
    }
    else  if(marioRight - 160 == back2.frame.origin.x && marioButtomY <= 319 + b2pipe2.frame.origin.y)
    {
        [MarioViewController gameOver];
    }
    
    //cross-sectional
    else if (marioRight > back1.frame.origin.x && back1.frame.origin.x >= marioRight - 86 && (marioTopY <= 319 + b1pipe1.frame.origin.y || marioButtomY >= 439 + b1pipe1.frame.origin.y))
    {
        if (b1pipe1.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    
    else if (marioRight - 160 > back1.frame.origin.x && back1.frame.origin.x >= marioRight - 246 && (marioTopY <= 319 + b1pipe2.frame.origin.y || marioButtomY >= 439 + b1pipe2.frame.origin.y))
    {
        if (b1pipe2.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    
    else if (marioRight > back2.frame.origin.x && back2.frame.origin.x >= marioRight - 86 && (marioTopY <= 319 + b2pipe1.frame.origin.y || marioButtomY >= 439 + b2pipe1.frame.origin.y))
    {
        if (b1pipe2.hidden == NO)
        {
            [MarioViewController gameOver];
        }
    }
    
    else if (marioRight - 160 > back2.frame.origin.x && back2.frame.origin.x >= marioRight - 246 && (marioTopY <= 319 + b2pipe2.frame.origin.y || marioButtomY >= 439 + b2pipe2.frame.origin.y))
    {
        [MarioViewController gameOver];
    }
    
    //ground
    else if (marioButtomY >= [[UIScreen mainScreen] bounds].size.height - 53)
    {
        [MarioViewController gameOver];
    }
}
@end
