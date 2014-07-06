//
//  MarioViewController.m
//  Flappy-Mario
//
//  Created by Sally Ouyang on 2014-07-05.
//  Copyright (c) 2014 Sally Ouyang. All rights reserved.
//
#import "Score.h"
#import "MarioViewController.h"
#import "Over.h"
#import "OverDetection.h"
#import "Food.h"


const float timeLongest = 50;
const float accer = 0.05;
const float maxVelocity = 2.5;
//const float AllLength = 692;

typedef enum {
    
    StopGame,
    StartGame,
    GameOver
    
} GameState;

@interface MarioViewController ()
{
    NSTimer *timer;
    UIImageView *marioBody;
    UIView *marioFrame;
    float maxJumpTime;
    
    //background
    UIView *back1;
    UIView *back2;
    
    //pipes setup
    UIView *b1pipe1;
    UIView *b1pipe2;
    UIView *b2pipe1;
    UIView *b2pipe2;
    
    //food=apple
    UIView *food11;
    UIView *food12;
    UIView *food21;
    UIView *food22;
    
    //strawberries
    UIView *straw2;
    UIView *straw1;
    
    float marioRight;
    float marioButtomY;
    float marioTopY;
}

@end

@implementation MarioViewController

static bool startNow;
static GameState gameState;
static UIView *mainBack;
static NSInteger score;
static UILabel *scoreLabel;

- (void)dealloc
{
    [timer invalidate];
    mainBack = nil;
    b1pipe1 = nil;
    b1pipe2 = nil;
    b2pipe1 = nil;
    b2pipe2 = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getReady];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.008
                                             target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - do not rotate
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void) update
{
    if (startNow == YES && gameState == StartGame)
    {
        [self updateMario];
        [self updateBg];
        [self createPipes];
        [self setFood];
        [self safeOrDie];
    }
}

#pragma mark - initiate
- (void) getReady
{
    //initiate main background
    mainBack = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainBack];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTap)];
    [self.view addGestureRecognizer:tapGesture];
    
    //obstacles
    back1 = [[UIView alloc] initWithFrame:self.view.bounds];
    back2 = [[UIView alloc] initWithFrame:CGRectMake(320, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [mainBack addSubview:back1];
    [mainBack addSubview:back2];
    
    //background added
    UIImageView *background1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    background1.image = [UIImage imageNamed:@"background1"];
    [back1 addSubview:background1];
    UIImageView *background2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    background2.image = [UIImage imageNamed:@"background2"];
    [back2 addSubview:background2];
    UIImageView *food = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 32)];
    food.image = [UIImage imageNamed:@"apple"];
    [back1 addSubview:food];
    [back2 addSubview:food];
    
    food11 = [self addFoodatX:9];
    food12 = [self addFoodatX:9];
    food21 = [self addFoodatX:9];
    food22 = [self addFoodatX:9];
    
    //pipes
    b1pipe1 = [self pipesAtX:0];
    [b1pipe1 addSubview:food11];
    [back1 addSubview:b1pipe1];
    b1pipe1.hidden = YES;
    b2pipe1 = [self pipesAtX:0];
    [b2pipe1 addSubview:food21];
    [back2 addSubview:b2pipe1];
    
    b1pipe2 = [self pipesAtX:160];
    [b1pipe2 addSubview:food12];
    [back1 addSubview:b1pipe2];
    b1pipe2.hidden = YES;
    b2pipe2 = [self pipesAtX:160];
    [b2pipe2 addSubview:food22];
    [back2 addSubview:b2pipe2];
    
    //strawberries
    straw1=[self addAppleAtX:90];
    straw2=[self addAppleAtX:90];
    [back2 addSubview:straw2];
    [back1 addSubview:straw1];
    straw1.hidden = YES;
    
    //the ground
    UIImageView *buttomImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 53, 320, 53)];
    buttomImg1.image = [UIImage imageNamed:@"ground"];
    [back1 addSubview:buttomImg1];
    UIImageView *buttomImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 53, 320, 53)];
    buttomImg2.image = [UIImage imageNamed:@"ground"];
    [back2 addSubview:buttomImg2];
    
    //mario frame
    marioFrame = [[UIView alloc] initWithFrame:CGRectMake(60, [[UIScreen mainScreen] bounds].size.height/2 + 80, 40, 28)];
    [mainBack addSubview:marioFrame];
    
    //get the mario ready
    marioBody = [[UIImageView alloc] init];
    marioBody.frame = CGRectMake(0, 0, 40, 26);
    marioBody.image = [UIImage imageNamed:@"mario"];
    [marioFrame addSubview:marioBody];
    
    //score counts
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(-80, 40, 300, 30)];
    scoreLabel.textAlignment = NSTextAlignmentRight;
    scoreLabel.textColor=[UIColor colorWithRed:(188/255.f) green:149 blue:170 alpha:1.0];
    scoreLabel.font = [UIFont boldSystemFontOfSize:30];
    [mainBack addSubview:scoreLabel];
    scoreLabel.text = @"score: 0";
}

- (void) screenTap
{
    maxJumpTime = timeLongest;
    
    if (startNow == NO)
    {
        startNow = YES;
        gameState = StartGame;
        
        for (UIView *tmpView in self.view.subviews)
        {
            [tmpView removeFromSuperview];
        }
        
        [self getReady];
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    marioBody.transform = CGAffineTransformRotate(transform,  -30 * M_PI / 180 );
}

- (void) createPipes
{
    NSInteger tmpY = rand()%120;
    if (back1.frame.origin.x == -53)
    {
        CGRect rect = b1pipe1.frame;
        rect.origin.y = tmpY - 120;
        b1pipe1.frame = rect;
        if (b1pipe1.hidden == YES)
        {
            b1pipe1.hidden = NO;
        }
        
        if (food11.hidden == YES)
        {
            food11.hidden = NO;
        }
    }
    else if (back1.frame.origin.x == -213)
    {
        CGRect rect = b1pipe2.frame;
        rect.origin.y = tmpY - 120;
        b1pipe2.frame = rect;
        if (b1pipe2.hidden == YES)
        {
            b1pipe2.hidden = NO;
        }
        if (food12.hidden == YES)
        {
            food12.hidden = NO;
        }
    }
    else if (back2.frame.origin.x == -53)
    {
        CGRect rect = b2pipe1.frame;
        rect.origin.y = tmpY - 120;
        b2pipe1.frame = rect;
        if (food21.hidden == YES)
        {
            food21.hidden = NO;
        }
    }
    else if (back2.frame.origin.x == -213)
    {
        CGRect rect = b2pipe2.frame;
        rect.origin.y = tmpY - 120;
        b2pipe2.frame = rect;
        if (food22.hidden == YES)
        {
            food22.hidden = NO;
        }
    }
}

- (void) setFood
{
    NSInteger randomY = 120 + rand()%100;
    if (back2.frame.origin.x == -145)
    {
        CGRect copy = straw2.frame;
        copy.origin.y = randomY;
        straw2.frame = copy;
        if (straw2.hidden == YES)
        {
            straw2.hidden = NO;
        }
    }
    
    else if (back1.frame.origin.x == -145)
    {
        CGRect copy = straw1.frame;
        copy.origin.y = randomY;
        straw1.frame = copy;
        if (straw1.hidden == YES)
        {
            straw1.hidden = NO;
        }
        
    }
}

#pragma mark - safe or not
- (void) safeOrDie
{
    marioRight = marioFrame.frame.origin.x + 34;
    marioButtomY = marioFrame.frame.origin.y + 24;
    marioTopY = marioFrame.frame.origin.y;
    [OverDetection detection:marioTopY :marioButtomY :marioRight :back1 :back2 :b1pipe1 :b1pipe2 :b2pipe1 :b2pipe2];
}

+ (void) gameOver
{
    startNow = NO;
    gameState = GameOver;
    [Over over:mainBack :scoreLabel :score];
    score = 0;
}

#pragma mark - up date Mario's position
- (void) updateMario
{
    maxJumpTime --;
    CGRect rect = marioFrame.frame;
    if (maxJumpTime >= 0)
    {
        rect.origin.y = rect.origin.y - (maxVelocity - (timeLongest - maxJumpTime)*accer);
    }
    else
    {
        CGAffineTransform transform = CGAffineTransformIdentity;
        marioBody.transform = CGAffineTransformRotate(transform,  30 * M_PI / 180 );
        rect.origin.y = rect.origin.y - (maxJumpTime*accer);
    }
    marioFrame.frame = rect;
}

- (void) updateBg
{
    CGRect rect1 = back1.frame;
    CGRect rect2 = back2.frame;
    
    marioRight = marioFrame.frame.origin.x + 34;
    marioButtomY = marioFrame.frame.origin.y + 24;
    marioTopY = marioFrame.frame.origin.y;
    
    if (rect1.origin.x <= -320)
    {
        rect1.origin.x = 320;
    }
    
    else if (rect2.origin.x <= -320)
    {
        rect2.origin.x = 320;
    }
    
    rect1.origin.x = rect1.origin.x - 1;
    rect2.origin.x = rect2.origin.x - 1;
    
    back1.frame = rect1;
    back2.frame = rect2;
    score = [Food foodScore:rect1 :rect2 :b1pipe1 :b1pipe2 :food11 :food12 :food21 :food22 :straw1 :straw2 :score :scoreLabel :marioTopY];
    [Score registerScore:score];
}

#pragma mark - set up obstacles and food
- (UIView *) pipesAtX:(float) originX
{
    NSInteger tmpY = rand()%120;
    UIView *pipeFrame = [[UIView alloc] initWithFrame:CGRectMake(originX, tmpY - 120, 52, 758)];
    
    UIImageView *topPipe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 319)];
    topPipe.image = [UIImage imageNamed:@"up"];
    [pipeFrame addSubview:topPipe];
    UIImageView *buttomPipe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 439, 52, 319)];
    buttomPipe.image = [UIImage imageNamed:@"down"];
    [pipeFrame addSubview:buttomPipe];
    return pipeFrame;
}

- (UIView *) addFoodatX:(float) originX
{
    UIView *foodView =[[UIView alloc] initWithFrame:CGRectMake(originX, 358, 50, 50)];
    UIImageView *food = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 32)];
    food.image = [UIImage imageNamed:@"apple"];
    [foodView addSubview:food];
    return foodView;
}

- (UIView *) addAppleAtX:(float) originX
{
    NSInteger randomY = 140 + (rand() % 200);
    UIView *appleV = [[UIView alloc] initWithFrame:CGRectMake(originX, randomY, 40, 40)];
    UIImageView *apple = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 32)];
    apple.image = [UIImage imageNamed:@"straw"];
    [appleV addSubview:apple];
    return appleV;
}

@end