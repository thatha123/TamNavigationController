//
//  ViewController.m
//  NavDemo
//
//  Created by xin chen on 2018/1/11.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamNavigationController.h"
#import "UIViewController+TamNavigationExtension.h"
#import "TamScreenNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1.0];
    [self setupUI];
//    TamScreenNavigationController *nav = (TamScreenNavigationController *)self.navigationController;
//    nav.isCanFullScreenScroll = NO;
}

-(void)setupUI
{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

-(void)pushAction:(UIButton *)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
