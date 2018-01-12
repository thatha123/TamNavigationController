//
//  TamNavAnimatedPop.m
//  LotteryApp
//
//  Created by xin chen on 2018/1/3.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamNavAnimatedPop.h"
#import "UIViewController+TamAnimationTransitioningSnapshot.h"

@implementation TamNavAnimatedPop

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //效果1
//    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//
//    [fromVc.view addSubview:fromVc.snapshot];
//    fromVc.navigationController.navigationBar.hidden = YES;
//    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
//
//    toVc.view.hidden = YES;
//    toVc.snapshot.alpha = 0.5;
//    toVc.snapshot.transform = CGAffineTransformMakeTranslation(-bounds.size.width/2, 0.0);
//
//    [[transitionContext containerView] addSubview:toVc.view];
//    [[transitionContext containerView] addSubview:toVc.snapshot];
//    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
//
//    [UIView animateWithDuration:duration
//                     animations:^{
//                         fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
//                         toVc.snapshot.alpha = 1.0;
//                         toVc.snapshot.transform = CGAffineTransformIdentity;
//                     }
//                     completion:^(BOOL finished) {
//
//                         toVc.navigationController.navigationBar.hidden = NO;
//                         toVc.view.hidden = NO;
//
//                         [fromVc.snapshot removeFromSuperview];
//                         [toVc.snapshot removeFromSuperview];
//                         fromVc.snapshot = nil;
//
//                         if (![transitionContext transitionWasCancelled]) {
//                             toVc.snapshot = nil;
//                         }
//
//                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                     }];
    //效果2
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
    
    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.3;
    toVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
    
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
                         toVc.snapshot.alpha = 1.0;
                         toVc.snapshot.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                         toVc.navigationController.navigationBar.hidden = NO;
                         toVc.view.hidden = NO;
                         
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         fromVc.snapshot = nil;
                         
                         // Reset toViewController's `snapshot` to nil
                         if (![transitionContext transitionWasCancelled]) {
                             toVc.snapshot = nil;
                         }
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
}

@end
