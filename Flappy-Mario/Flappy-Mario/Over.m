//
//  Over.m
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//

#import "Over.h"
#import "Score.h"

@implementation Over
+ (void) over:(UIView*) mainBack :(UILabel *)scoreLabel :(NSInteger) score
{
    UILabel *best;
    UIImageView *over = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 318, 480)];
    over.image = [UIImage imageNamed:@"pinkCloud"];
    [mainBack addSubview:over];
    best = [[UILabel alloc] initWithFrame:CGRectMake(-25, 300, 300, 30)];
    best.textAlignment = NSTextAlignmentRight;
    best.textColor=[UIColor colorWithRed:(188/255.f) green:149 blue:170 alpha:1.0];
    best.font = [UIFont boldSystemFontOfSize:30];
    
    scoreLabel.frame = CGRectMake(-30, 140, 300, 30);
    scoreLabel.text = [NSString stringWithFormat:@"Current score: %ld",(long)score];
    [mainBack addSubview:scoreLabel];
    [mainBack addSubview:best];
    best.text = [NSString stringWithFormat:@"Best Score: %ld",(long)[Score bestScore]];
}
@end
