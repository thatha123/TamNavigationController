//
//  TamScreenNavigationController.m
//  NavDemo
//
//  Created by xin chen on 2018/1/12.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamScreenNavigationController.h"
#import "TamNavigationControllerDelegate.h"

@interface TamScreenNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)TamNavigationControllerDelegate *navigationDelegate;

@end

@implementation TamScreenNavigationController

-(TamNavigationControllerDelegate *)navigationDelegate
{
    if (!_navigationDelegate) {
        _navigationDelegate = [[TamNavigationControllerDelegate alloc]init];
    }
    return _navigationDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self.navigationDelegate;
    self.isCanFullScreenScroll = YES;
    
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.delegate = self;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (!self.isCanFullScreenScroll) {
        return NO;
    }
    if (gestureRecognizer.view == self.view) {
        CGPoint translate = [gestureRecognizer translationInView:self.view];
        BOOL possible = translate.x >= 0 && fabs(translate.y) == 0;
        if (possible)
            return YES;
        else
            return NO;
        return YES;
    }
    return NO;
}
///此方法可以解决滑动的冲突，
///举个栗子：侧滑返回和UIScrollView的本身滑动冲突了。再举个栗子：tableviewCell身上自带的系统删除，筛选界面展开的左滑事件有冲突
///下面详细解释此方法:
///同一个view上如果作用了两个相同类型的手势，那么系统默认只会响应一个，why？因为系统是SB，系统还没有这么智能的知道你想怎么样，他不会知道手势冲突的时候让那个接受手势，剩下的就是程序员的工作了，我们可以在此方法中判断，机制的做出明确的处理，该方法返回YES时，意味着所有相同类型的手势辨认都会得到处理。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    for (id sub in otherGestureRecognizer.view.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {//返回按钮
            return NO;
        }
    }
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")]|| [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPagingSwipeGestureRecognizer")]) //
    {

        UIView *aView = otherGestureRecognizer.view;
        if ([aView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (UIScrollView *)aView;
            if (sv.contentOffset.x==0) {
                return YES;
            }
        }
        return NO;
    }

    return YES;
}

- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            //设置手势
            self.navigationDelegate.gestureRecognizer = gestureRecognizer;
            //返回
            [super popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged: {
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            self.navigationDelegate.gestureRecognizer = nil;
        }
    }
}

@end
