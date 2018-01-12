//
//  TamPercentDrivenInteractiveTransition.m
//  LotteryApp
//
//  Created by xin chen on 2018/1/3.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamPercentDrivenInteractiveTransition.h"

@interface TamPercentDrivenInteractiveTransition()

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@end

@implementation TamPercentDrivenInteractiveTransition

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //此句话的重要性
    [super startInteractiveTransition:transitionContext];
}

-(instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self == [super init]) {
        _gestureRecognizer = gestureRecognizer;
        
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    if (translation.x < 0) {
        translation.x = 0;
    }
    CGFloat scale = 1 - fabs(translation.x / [UIScreen mainScreen].bounds.size.width);
    scale = scale < 0 ? 0 : scale;
    return scale;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat scale = 1 - [self percentForGesture:gestureRecognizer];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            //没用
            break;
        case UIGestureRecognizerStateChanged:
            
            [self updateInteractiveTransition:scale];
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (scale < 0.2f){
                
                [self cancelInteractiveTransition];
            }
            else{
                [self finishInteractiveTransition];
            }
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}

@end
