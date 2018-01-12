//
//  TamNavigationControllerDelegate.m
//  LotteryApp
//
//  Created by xin chen on 2018/1/3.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamNavigationControllerDelegate.h"
#import "TamPercentDrivenInteractiveTransition.h"
#import "TamNavAnimatedPop.h"
#import "TamNavAnimatedPush.h"

@interface TamNavigationControllerDelegate()

@property(nonatomic,strong)TamPercentDrivenInteractiveTransition *percentInteractive;
@property(nonatomic,strong)TamNavAnimatedPop *navAnimatedPop;
@property(nonatomic,strong)TamNavAnimatedPush *navAnimatedPush;

@end

@implementation TamNavigationControllerDelegate

-(TamPercentDrivenInteractiveTransition *)percentInteractive
{
    if (!_percentInteractive) {
        _percentInteractive = [[TamPercentDrivenInteractiveTransition alloc]initWithGestureRecognizer:self.gestureRecognizer];
    }
    return _percentInteractive;
}

-(TamNavAnimatedPop *)navAnimatedPop
{
    if (!_navAnimatedPop) {
        _navAnimatedPop = [[TamNavAnimatedPop alloc]init];
    }
    return _navAnimatedPop;
}

-(TamNavAnimatedPush *)navAnimatedPush
{
    if (!_navAnimatedPush) {
        _navAnimatedPush = [[TamNavAnimatedPush alloc]init];
    }
    return _navAnimatedPush;
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (self.gestureRecognizer) {
        return self.percentInteractive;
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        return self.navAnimatedPop;
    }
    
    if (operation == UINavigationControllerOperationPush) {
        return self.navAnimatedPush;
    }
    
    return nil;
}

-(void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    _gestureRecognizer = gestureRecognizer;
}



@end
