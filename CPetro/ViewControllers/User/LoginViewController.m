//
//  LoginViewController.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LoginViewController.h"

#import "LRInputView.h"
#import "BSButtonView.h"

#import "KeychainItemWrapper.h"
//#import "CGBarButtonItem.h"
@interface LoginViewController ()<BSButtonViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"绑定账户";
    
    LRInputView *lrMoreInputView = [[LRInputView alloc]initTextWithFrame:CGRectMake(0,134, SCREEN_WIDTH, 50) andlabelName:@"会员账号"];
    [self.view addSubview:lrMoreInputView];
    
    LRInputView *lrMoreInputRep = [[LRInputView alloc]initTextWithFrame:CGRectMake(0,CGRectGetMaxY(lrMoreInputView.frame) + 10, SCREEN_WIDTH, 50) andlabelName:@"确认账号"];
    lrMoreInputRep.tag = 10;
    [self.view addSubview:lrMoreInputRep];
    
    BSButtonView *bsButtonView = [[BSButtonView alloc]initItemWithFram:CGRectMake(0, CGRectGetMaxY(lrMoreInputRep.frame)+ 15, SCREEN_WIDTH, 40) andData:@[[UIImage imageNamed:@"UserBandACcount"]]];
    bsButtonView.delegate = self;
    [self.view addSubview:bsButtonView];
}
#pragma mark - 登陆
-(void)didActionBottomIndex:(NSInteger)index{
    NSString *accountNumber;
    NSString *repeatAccountNumber;
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[LRInputView class]]) {
//            LRInputView *moreView = (LRInputView *)subView;
//            for (UIView *subViewSecond in moreView.subviews) {
//                if ([subViewSecond isKindOfClass:[LRInputView class]]) {
                    LRInputView *lrInputView = (LRInputView *)subView;
                    if (lrInputView.tag == 0) {
                        NSLog(@"登陆   ==  %@",lrInputView.inputText.text);//
                        accountNumber  = lrInputView.inputText.text;
                    }else if (lrInputView.tag == 10){
                        NSLog(@"确认账号== %@",lrInputView.inputText.text);//
                        repeatAccountNumber = lrInputView.inputText.text;
                    }else if (lrInputView.tag == 2){
//                        NSLog(@"填入的参数 2==%@--提示文字 == %@",lrInputView.inputText.text,lrInputView.tipName.text);//
                    }
//                }
//            }
        }
    }

    if (accountNumber.length == 0) {
         [self.view makeToast:@"填入账户" duration:1.0f position:@"center"];
        return;
    }

    if (![accountNumber isEqualToString:repeatAccountNumber]) {
         [self.view makeToast:@"账户不一样" duration:1.0f position:@"center"];
        return;
    }
    //客户端绑定码，
//    http://127.0.0.1:8888/api/member/bind/
//    http://103.226.152.162:7777/api/member/bind?clientId=1&clientType=2&memberName=test1
    
    //重置用户
//    http://103.226.152.162:7777/api/member/resetTestUser?memberName=test4&resetType=1&point=10000
    
//    http://103.226.152.162:7777/api/member/resetTestUser?memberName=test2&resetType=1&point=10000
    //登录用户
//    http://103.226.152.162:7777/api/member/bind?memberName=test1&clientId=0EBF04D9-ED1B-4AE0-B7A3-49308765EFC4&clientType=2&

    //9340773321
//    CGDataResult *resetAcccpunt
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"comzrgginkey" accessGroup:nil];// 1
    NSString *imkey = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    
    if (!imkey || imkey.length==0) {
        NSString *randomkey = [NSString stringWithFormat:@"%u%u%u%u%u%u%u%u%u%u",arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10];
        [keychain setObject:randomkey forKey:(__bridge id)(kSecAttrAccount)];// 2
        
    }
    imkey = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    
    [self showAnimated:YES title:@"正在登陆" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":imkey,@"memberName":accountNumber,@"clientType":@"2"} andBymethodName:@"api/member/bind"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if (b) {
            //保存用户信息
            [CustomUtil saveUserInfo:(EntityUser *)[EntityUser getObjectFromDic:r.dataList]];
            
            [CustomUtil saveAcessToken:[CustomUtil getUserInfo].clientId];
            
            //绑定成功 对首页进行刷新处理
            [[NSNotificationCenter defaultCenter]postNotificationName:K_USERCHANGEASSISTANT object:@(YES)];

//            EntityUser *user = [CustomUtil getUserInfo];
            //返回控制器
            if (self.accountBandSuccess) {
                self.accountBandSuccess();
            }
            POP;
        }
        
    }];
}
-(void)forgetPassWordAction{
    PushViewControllerName(@"ForgetPwdViewController");
}
-(void)loginToService{
    
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
