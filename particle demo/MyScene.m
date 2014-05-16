//
//  MyScene.m
//  particle demo
//
//  Created by Bradley Johnson on 5/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//
@import CoreMotion;
#import "MyScene.h"

@interface MyScene ()

@property (strong,nonatomic) CMMotionManager *motionManager;
@property (strong,nonatomic) SKSpriteNode *spaceShip;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
         self.spaceShip = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        self.spaceShip.position = CGPointMake(160, 100);
        self.spaceShip.size = CGSizeMake(100, 100);
        
        
        NSString *starsPath =
        [[NSBundle mainBundle] pathForResource:@"Stars" ofType:@"sks"];
        
        SKEmitterNode *stars = [NSKeyedUnarchiver unarchiveObjectWithFile:starsPath];
        
        stars.position = CGPointMake(160, 560);
        
        [self addChild:stars];
        [self addChild:self.spaceShip];
        
        NSString *exhaustPath =
        [[NSBundle mainBundle] pathForResource:@"Exhaust" ofType:@"sks"];
        
        SKEmitterNode *exhaust = [NSKeyedUnarchiver unarchiveObjectWithFile:exhaustPath];
        exhaust.position = CGPointMake(0, -50);
        
        [self.spaceShip addChild:exhaust];
        
        
        self.motionManager = [[CMMotionManager alloc] init];
        
        self.motionManager = [[CMMotionManager alloc] init];
        if ([self.motionManager isAccelerometerAvailable])
        {
            [self.motionManager setAccelerometerUpdateInterval:1/30];
            
            [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                
                NSLog(@"%f",accelerometerData.acceleration.x);
                
                self.spaceShip.position = CGPointMake(self.spaceShip.position.x + (accelerometerData.acceleration.x * 3), self.spaceShip.position.y);
                
                //self.physicsWorld.gravity =  CGVectorMake(accelerometerData.acceleration.x * 5, -5);
                
                
            }];
        }

        
        
        
       
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"laserbeam_blue"];
        
        sprite.position = CGPointMake(self.spaceShip.position.x, self.spaceShip.position.y + 50);
        
        
        
        SKAction *action = [SKAction moveTo:CGPointMake(sprite.position.x, 600) duration:1];
        
        [sprite runAction:action];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
