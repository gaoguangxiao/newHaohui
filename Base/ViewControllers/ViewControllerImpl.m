//
//  ViewControllerImpl.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "ViewControllerImpl.h"

#import "CL_WebView_VC.h"
#import "CommentAddControl.h"
#import "EntityUrl.h"
@interface ViewControllerImpl ()
{
    NSArray*urlArray;
}
@end

@implementation ViewControllerImpl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = PROJECT_NAME;//
    
    [self.view addSubview:self.backImageView];
    self.backImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view insertSubview:self.backImageView atIndex:0];
    
    
    
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.titleView = self.imageTitle;
        self.imageTitle.frame = CGRectMake(0, 0, 80, 25);
        self.imageTitle.center = CGPointMake((SCREEN_WIDTH)/2, 32);

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"App_Add"] style:UIBarButtonItemStyleDone target:self action:@selector(showAddComment:)];
        
            [self loadDataUrl];
    }
    
    
    if (self.navigationController&&self.navigationController.viewControllers.count>1) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 50, 30)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"App_Back"] forState:0];
        [btn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    
    
}
-(void)setNavigationItemTitle:(NSString *)navigationItemTitle{
    self.navigationItem.title = navigationItemTitle;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self Init];
    }
    return self;
}
-(UIImageView *)imageTitle{
    if (!_imageTitle) {
        _imageTitle = [UIImageView new];
        _imageTitle.image = [UIImage imageNamed:@"NacigationTitle"];
        _imageTitle.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageTitle;
}
-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"ActivityBack"];
    }
    return _backImageView;
}
-(void)Init{
    if (self.edgesForExtendedLayout) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
-(BOOL)hidesBottomBarWhenPushed{
    if ([self isKindOfClass:NSClassFromString(@"HomeViewController")]||
        [self isKindOfClass:NSClassFromString(@"ActivityViewController")]||
        [self isKindOfClass:NSClassFromString(@"UserCenterViewController")]) {
        return NO;
    }else{
        return YES;
    }
    
}
#pragma mark -网络数据
- (void)showAnimated:(BOOL)animated title:(NSString *)title whileExecutingBlock:(CGDataResult *(^)())block completionBlock:(void(^)(BOOL b,CGDataResult *r))completion{
    MBProgressHUD *hud;
    if (animated) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = title;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGDataResult *result = block();
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(result.status.boolValue,result);
            [hud hide:YES];
            if (result&&[result isKindOfClass:[CGDataResult class]]&&result.errorMsg.length>0) {
                NSString *msg = result.errorMsg;
                if(!result.status.boolValue) [self.view makeToast:msg duration:1.0 position:@"center"];;
            }
            
        });
    });
}
#pragma mark -获取网址、活动大厅/优惠活动
-(void)loadDataUrl{
    [self showAnimated:NO title:@"" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/viewUrl/get"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            urlArray = [EntityUrl getObjecsFromDic:r.dataList];
        }
    }];
}

#pragma mark - 右上角
-(void)showAddComment:(UIBarButtonItem *)item{
    item.enabled = NO;
    
    CommentAddControl *control = [[CommentAddControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    control.clickAction = ^(NSInteger index){
        if(index==0 || index== 1){
            __block NSString *hddUrl;
            __block  NSString *yhhd;
            [urlArray enumerateObjectsUsingBlock:^(EntityUrl*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.type isEqualToString:@"hddt"]) {
                    hddUrl = obj.url;
                }else if([obj.type isEqualToString:@"yhhd"]){
                    yhhd = obj.url;
                    
                }
            }];
            if (index == 1) {
                CL_WebView_VC *Vc = CreateViewController(@"CL_WebView_VC");
                Vc.navigationTitle = @"活动自助大厅";
                Vc.url = [NSURL URLWithString:hddUrl];
                PushViewController(Vc);
            }else{
                CL_WebView_VC *Vc = CreateViewController(@"CL_WebView_VC");
                Vc.navigationTitle = @"优惠活动";
                Vc.url = [NSURL URLWithString:yhhd];
                PushViewController(Vc);
            }
        }else if (index == 2){
            PushViewControllerName(@"LineCheckViewController");
        }else{
            PushViewControllerName(@"AboutOurViewController");
        }
        item.enabled = YES;
    };
    
    [self.view addSubview:control];
    
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
