//
//  TamNavAnimatedPush.m
//  LotteryApp
//
//  Created by xin chen on 2018/1/3.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamNavAnimatedPush.h"
#import "UIViewController+TamAnimationTransitioningSnapshot.h"

@implementation TamNavAnimatedPush

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //效果1
//    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//
//    fromVc.view.hidden = YES;
//    [[transitionContext containerView] addSubview:fromVc.snapshot];
//    [[transitionContext containerView] addSubview:toVc.view];
//    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
//    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
//
//    [UIView animateWithDuration:duration
//                          delay:0
//         usingSpringWithDamping:1.0
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         fromVc.snapshot.alpha = 0.5;
//                         fromVc.snapshot.transform = CGAffineTransformMakeTranslation(-bounds.size.width/2, 0.0);
//                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
//                     }
//                     completion:^(BOOL finished) {
//                         fromVc.view.hidden = NO;
//                         [fromVc.snapshot removeFromSuperview];
//                         [toVc.snapshot removeFromSuperview];
//                         [transitionContext completeTransition:YES];
//                     }];
    //效果2
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    fromVc.view.hidden = YES;
    [[transitionContext containerView] addSubview:fromVc.snapshot];
    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.snapshot.alpha = 0.3;
                         fromVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.hidden = NO;
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];

}


- (void)animationEnded:(BOOL)transitionCompleted {
    
}

@end
