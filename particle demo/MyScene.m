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

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
          SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = CGPointMake(160, 100);
        sprite.size = CGSizeMake(100, 100);
        
        
        NSString *starsPath =
        [[NSBundle mainBundle] pathForResource:@"Stars" ofType:@"sks"];
        
        SKEmitterNode *stars = [NSKeyedUnarchiver unarchiveObjectWithFile:starsPath];
        
        stars.position = CGPointMake(160, 560);
        
        [self addChild:stars];
        [self addChild:sprite];
        
        NSString *exhaustPath =
        [[NSBundle mainBundle] pathForResource:@"Exhaust" ofType:@"sks"];
        
        SKEmitterNode *exhaust = [NSKeyedUnarchiver unarchiveObjectWithFile:exhaustPath];
        exhaust.position = CGPointMake(0, -50);
        
        [sprite addChild:exhaust];
        
        
        self.motionManager = [[CMMotionManager alloc] init];
        
        self.motionManager = [[CMMotionManager alloc] init];
        if ([self.motionManager isAccelerometerAvailable])
        {
            [self.motionManager setAccelerometerUpdateInterval:1/30];
            
            [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                
                NSLog(@"%f",accelerometerData.acceleration.x);
                
                sprite.position = CGPointMake(sprite.position.x + (accelerometerData.acceleration.x * 3), sprite.position.y);
                
                //self.physicsWorld.gravity =  CGVectorMake(accelerometerData.acceleration.x * 5, -5);
                
                
            }];
        }

        
        
        
       
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
