//
//  ViewController1.m
//  iOS-OC
//
//  Created by 石富才 on 2020/11/1.
//  Copyright © 2020 石富才. All rights reserved.
//

#import "ViewController1.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    //fd_prefersNavigationBarHidden
    //fd_interactivePopMaxAllowedInitialDistanceToLeftEdge
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = NO;
//    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = @(200);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *vc = UIViewController.new;
    vc.view.backgroundColor = UIColor.blueColor;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
