//
//  UserCenterViewController.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "UserCenterViewController.h"

#import "LoginViewController.h"

#import "LRMoreInputView.h"
#import "BSButtonView.h"
#import "EntityLevelDetail.h"//Vip等级信息
@interface UserCenterViewController ()<BSButtonViewDelegate>
{
    __weak IBOutlet UIView *_userInfoView;
    
    __weak IBOutlet UILabel *_betMoney;//累计有效投注
    __weak IBOutlet UILabel *_upgradeMoney;
    __weak IBOutlet UILabel *_luckyMoney;
    __weak IBOutlet UILabel *_compareMoney;
    
    
    __weak IBOutlet UILabel *_laTip;
    __weak IBOutlet UIView *_ControlView;
    
}
@end

@implementation UserCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([CustomUtil isUserLogin]) {
    
        [self getUserInfoMethod];
        
        [self getVipUserInfoMethod];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"我的";
//    NSLog(@"====%@",[CustomUtil getToken]);
    
    //用户未绑定情况情况
    if ([CustomUtil isUserLogin]) {//用户登录
        //判断是否绑定加载不同的view
    }
}

-(void)didActionBottomIndex:(NSInteger)index{
    LoginViewController *Vc = CreateViewController(@"LoginViewController");
    Vc.accountBandSuccess   = ^{
        //更新界面
        [self userLoginSuccess];
        //加载有效投注
        //
        //累计晋级彩金
    };
    PushViewController(Vc);
}
#pragma mark - 加载用户数据
-(void)getUserInfoMethod{
    [self showAnimated:YES title:@"获取用户信息" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/get"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if (b) {//
            [CustomUtil saveUserInfo:(EntityUser *)[EntityUser getObjectFromDic:r.dataList]];
            
            [CustomUtil saveAcessToken:[CustomUtil getUserInfo].clientId];
            
            [self userLoginSuccess];
        }else{
            //用户未绑定信息
            LRMoreInputView *inputView = [[LRMoreInputView alloc]initItemWithFram:CGRectMake(0, 110, SCREEN_WIDTH, 100) andData:@[@{@"assistantName":@"账户",@"assistantAccount":@"未绑定"},
                                                                                                                                  @{@"assistantName":@"等级",@"assistantAccount":@"未绑定"},
                                                                                                                                  @{@"assistantName":@"积分",@"assistantAccount":@"未绑定"}]];
            [self.view addSubview:inputView];
            
            
            BSButtonView *topView = [[BSButtonView alloc]initItemWithFram:CGRectMake(25, CGRectGetMaxY(inputView.frame) + 10, SCREEN_WIDTH - 50, 45) andData:@[[UIImage imageNamed:@"bandAccountBTn"]]];
            topView.tag = 10;
            topView.delegate = self;
            [self.view addSubview:topView];
        }
    }];
}
-(void)getVipUserInfoMethod{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGDataResult *r = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/levelDetail"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (r.status.boolValue) {
                [self userLoginStatusSuccessVipPointDataUpdate:(EntityLevelDetail *)[EntityLevelDetail getObjectFromDic:r.dataList]];
            }
        });
    });
    
}
#pragma mark - 用户登录成功
-(void)userLoginSuccess{
    _userInfoView.hidden = NO;
    _ControlView.hidden  = NO;
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[BSButtonView class]]) {
            [v removeFromSuperview];
        }
    }
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[LRMoreInputView class]]) {
            [v removeFromSuperview];
        }
    }
    
    [self userLoginStatusSuccess:[CustomUtil getUserInfo]];
    
}

#pragma mark - 更新用户账户界面数据
-(void)userLoginStatusSuccess:(EntityUser *)user{
    if (!user) return;
    LRMoreInputView *inputView = [[LRMoreInputView alloc]initItemWithFram:CGRectMake(0, 110, SCREEN_WIDTH, 120) andData:@[@{@"assistantName":@"账户",@"assistantAccount":user.memberName},
                                                                                                                          @{@"assistantName":@"等级",@"assistantAccount":user.point},
                                                                                                                          @{@"assistantName":@"积分",@"assistantAccount":user.levelName}]];
    [self.view addSubview:inputView];
    
    
    
    
}
-(void)userLoginStatusSuccessVipPointDataUpdate:(EntityLevelDetail *)levelDetail{
    _betMoney.text =  levelDetail.betMoney;
    
    _upgradeMoney.text =  levelDetail.upgradeMoney;
    
    _luckyMoney.text   = levelDetail.luckyMoney;
    _compareMoney.text = levelDetail.compareMoney;
    
    _laTip.text = [NSString stringWithFormat:@"您已经连续签到%@次",[CustomUtil getUserInfo].signTimes];
}
#pragma mark - 进入签到/商品兑换/积分
- (IBAction)DidActionBtn:(UIButton *)sender {
    if (sender.tag == 0){
        [self showAnimated:YES title:@"我要签到" whileExecutingBlock:^CGDataResult *{
            return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/sign"];
        } completionBlock:^(BOOL b, CGDataResult *r) {
            if (b) {
                [self getUserInfoMethod];
                
                [self.view makeToast:r.errorMsg duration:1.0f position:@"center"];
            }
        }];
        NSLog(@"我签到啦");
    }else if (sender.tag == 1)PushViewControllerName(@"ExchangeShopViewController");
    else PushViewControllerName(@"ApplyScoreViewController");
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
