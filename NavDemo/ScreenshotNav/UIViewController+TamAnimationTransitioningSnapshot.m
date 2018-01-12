//
//  UIViewController+TamAnimationTransitioningSnapshot.m
//  NavDemo
//
//  Created by xin chen on 2018/1/12.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "UIViewController+TamAnimationTransitioningSnapshot.h"
#import <objc/runtime.h>

@implementation UIViewController (TamAnimationTransitioningSnapshot)

- (UIView *)snapshot {
    
    UIView *view = objc_getAssociatedObject(self, @"TamAnimationTransitioningSnapshot");
    if (!view) {
        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    
    return view;
}

- (void)setSnapshot:(UIView *)snapshot {
    
    objc_setAssociatedObject(self, @"TamAnimationTransitioningSnapshot", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
