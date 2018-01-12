//
//  UIViewController+TamNavigationExtension.h
//  NavDemo
//
//  Created by xin chen on 2018/1/11.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamNavigationController.h"

@interface UIViewController (TamNavigationExtension)

@property(nonatomic,assign)BOOL tam_fullScreenPopGestureEnabled;

@property(nonatomic,weak)TamNavigationController *tam_navigationController;


@end
