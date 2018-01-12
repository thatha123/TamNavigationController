//
//  TamNavigationController.m
//  NavDemo
//
//  Created by xin chen on 2018/1/11.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamNavigationController.h"
#import "UIViewController+TamNavigationExtension.h"
#define TamDefaultBackImageName @"backImage"

#pragma mark - TamWrapNavigationController
@interface TamWrapNavigationController : UINavigationController

@end

@implementation TamWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    TamNavigationController *tam_navigationController = viewController.tam_navigationController;
    NSInteger index = [tam_navigationController.tam_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:tam_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.tam_navigationController = (TamNavigationController *)self.navigationController;
    viewController.tam_fullScreenPopGestureEnabled = viewController.tam_navigationController.fullScreenPopGestureEnabled;
    
    UIImage *backButtonImage = viewController.tam_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:TamDefaultBackImageName];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    [self.navigationController pushViewController:[TamWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.tam_navigationController=nil;
}

@end

#pragma mark - TamWrapViewController

static NSValue *tam_tabBarRectValue;

@implementation TamWrapViewController

+ (TamWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    TamWrapNavigationController *wrapNavController = [[TamWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    TamWrapViewController *wrapViewController = [[TamWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !tam_tabBarRectValue) {
        tam_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && tam_tabBarRectValue) {
        self.tabBarController.tabBar.frame = tam_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)tam_fullScreenPopGestureEnabled {
    return [self rootViewController].tam_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    TamWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end
#pragma mark - TamNavigationController
@interface TamNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIPanGestureRecognizer *popPanGesture;

@property(nonatomic,strong)id popGestureDelegate;

@end

@implementation TamNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.tam_navigationController = self;
        self.viewControllers = @[[TamWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.tam_navigationController = self;
        self.viewControllers = @[[TamWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.tam_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)tam_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (TamWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}


@end
