//
//  TamNavigationController.h
//  NavDemo
//
//  Created by xin chen on 2018/1/11.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark -TamWrapViewController
@interface TamWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (TamWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end
#pragma mark -TamNavigationController
@interface TamNavigationController : UINavigationController

@property(nonatomic,strong)UIImage *backButtonImage;
//发现没用
@property(nonatomic,assign)BOOL fullScreenPopGestureEnabled;

@property(nonatomic,copy,readonly)NSArray *tam_viewControllers;


@end
