//
//  HJNavgationViewController.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "HJNavgationViewController.h"

#import "UINavigationBar+Awesome.h"


@interface HJNavgationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HJNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//左边标题修改白色
    
    [self.navigationBar lt_setbarStyle:UIBarStyleBlackTranslucent];
    
    [self.navigationBar lt_setTitleColor:[UIColor whiteColor]];
    
    [self.navigationBar lt_setBackgroundColor:K_NavigationBackColor];
    
    self.interactivePopGestureRecognizer.delegate  = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
