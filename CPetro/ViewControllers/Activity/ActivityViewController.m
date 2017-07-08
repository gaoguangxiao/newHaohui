//
//  ActivityViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/24.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "ActivityViewController.h"

#import "BSButtonView.h"
@interface ActivityViewController ()<BSButtonViewDelegate>

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"新濠天地";
    
    CGFloat remainheight = SCREEN_HEIGHT - 64 - 145 - 55;
    
    BSButtonView *topViewEgg = [[BSButtonView alloc]initItemWithFram:CGRectMake(30, 145, SCREEN_WIDTH - 60, remainheight /2) andData:@[[UIImage imageNamed:@"ActivityEgg"]]];
    topViewEgg.delegate = self;
    topViewEgg.tag = 0;
    [self.view addSubview:topViewEgg];
    
    
    BSButtonView *topView = [[BSButtonView alloc]initItemWithFram:CGRectMake(25, CGRectGetMaxY(topViewEgg.frame) + 5, SCREEN_WIDTH - 50, remainheight/2) andData:@[[UIImage imageNamed:@"ActivityLuckPan"]]];
    topView.tag = 10;
    topView.delegate = self;
    [self.view addSubview:topView];
}
-(void)didActionBsbuttonview:(BSButtonView *)buttonView andINdex:(NSInteger)index{
    if (buttonView.tag == 0) {
        PushViewControllerName(@"EatEggViewController");
    }else{
        PushViewControllerName(@"LuckPanViewController");
    }
}
-(void)didActionBottomIndex:(NSInteger)index{
    
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
