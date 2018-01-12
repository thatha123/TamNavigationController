//
//  UIViewController+TamNavigationExtension.m
//  NavDemo
//
//  Created by xin chen on 2018/1/11.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "UIViewController+TamNavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (TamNavigationExtension)

- (BOOL)tam_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setTam_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(tam_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (TamNavigationController *)tam_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTam_navigationController:(TamNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(tam_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}


@end
