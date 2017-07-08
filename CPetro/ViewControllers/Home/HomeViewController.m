//
//  ViewController.m

//
//  Created by ggx on 2017/3/7.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "HomeViewController.h"
#import "NoticeViewController.h"

#import "BSButtonView.h"
#import "MorePictureTwoView.h"
#import "MorePictureView.h"

#import "CL_WebView_VC.h"
#import "CommentAddControl.h"

#import "EntityAd.h"
#import "EntityUrl.h"
//#import "CGTableView+loadView2.h"
@interface HomeViewController ()<MorePictureTwoViewDelegate,MorePictureViewDelegate>
{
    NSMutableArray *_homeArray;
    NSArray*urlArray;
    NSMutableArray *sunhuanCount;
    MorePictureView *morePictureView;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"新濠天地";
    
    //加载公告
    [self loadNoticeData];
    
//    [self loadDataUrl];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserCate:) name:K_USERCHANGEASSISTANT object:nil];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"App_Add"] style:UIBarButtonItemStyleDone target:self action:@selector(showAddComment:)];
    _homeArray = [NSMutableArray new];
    
    
}
-(void)changeUserCate:(NSNotification *)sender{
    [self loadNoticeData];
    
//    [self loadDataUrl];
    
//    morePictureView.dataNotice = sunhuanCount;
}
#pragma mark -获取公告数据
-(void)loadNoticeData{
    [self showAnimated:YES title:@"加载数据。。。" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/notice/get"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            [sunhuanCount removeAllObjects];
            NSArray *arrayTemp = [EntityAd getObjecsFromDic:r.dataList];
            sunhuanCount =[NSMutableArray arrayWithArray:arrayTemp];
            while (sunhuanCount.count<10) {
                [sunhuanCount addObjectsFromArray:arrayTemp];
            }
            //布置界面
            [self createNoticeUi:sunhuanCount];
        }else{
            [self createNoticeUi:@[]];
        }
    }];
}
-(void)createNoticeUi:(NSArray *)notice{
    BSButtonView *topView = [[BSButtonView alloc]initItemWithFram:CGRectMake(0, 0, 200, 50) andData:@[[UIImage imageNamed:@"HomeLogo"]]];
    topView.center = CGPointMake(SCREEN_WIDTH/2,topView.center.y);
    topView.leftBtn.userInteractionEnabled = NO;
    [self.view addSubview:topView];
    //整个高度比例
//    150/667 = 0.22 - 167
//0.75 0.52 0.23
    MorePictureTwoView *morePictureTwoView = [[MorePictureTwoView alloc]initItemWithFram:CGRectMake(0,CGRectGetMaxY(topView.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT*0.25)
                                                                                 andData:
                                              @[[UIImage imageNamed:@"HomeEatEgg"],[UIImage imageNamed:@"HomeLuckPan"]]andRow:0];
    morePictureTwoView.delegate = self;
    [self.view addSubview:morePictureTwoView];


    morePictureView = [[MorePictureView alloc]initMorePictureItemWithFram:
                                        CGRectMake(0, CGRectGetMaxY(morePictureTwoView.frame), SCREEN_WIDTH, SCREEN_HEIGHT * 0.5)
                                                                                   andData:
                                        @[@[[UIImage imageNamed:@"HomeActivity"],
                                            [UIImage imageNamed:@"HomeLineCheck"]],
                                          @[[UIImage imageNamed:@"HomeAboutOur"],
                                            [UIImage imageNamed:@"HomeSimpleActivity"]]]];
    morePictureView.dataNotice = sunhuanCount;
    morePictureView.delegate  =self;
    [self.view addSubview:morePictureView];
}
#pragma mark - MorePictureViewDelegate代理
-(void)didMorePictureViewBtn:(NSInteger)tagBtn{
   
 if (tagBtn == 1){
        PushViewControllerName(@"LineCheckViewController");
    }else if (tagBtn == 10){
        PushViewControllerName(@"AboutOurViewController");
    }else{
        
       __block NSString *hddUrl;
      __block  NSString *yhhd;
            [urlArray enumerateObjectsUsingBlock:^(EntityUrl*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.type isEqualToString:@"hddt"]) {
                    hddUrl = obj.url;
                }else if([obj.type isEqualToString:@"yhhd"]){
                    yhhd = obj.url;
                    
                }
            }];
        if (tagBtn == 0) {
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
       
    }
    //NSLog(@"下面的代理 = %ld",tagBtn);
    
}
-(void)clickedByHomeAtIndex:(NSInteger)index data:(EntityAd *)data{
    if (data.zhaiyao.length > 0) {
        NoticeViewController *Vc = CreateViewController(@"NoticeViewController");
        Vc.dataLine = sunhuanCount;
        [self.navigationController pushViewController:Vc animated:YES];
    }
}
-(void)didMorePictureTwoViewBtnItem:(NSInteger)tagBtn{
//    NSLog(@"上面的代理%ld",tagBtn);
    if (tagBtn == 0) {
        PushViewControllerName(@"EatEggViewController");
    }else{
        PushViewControllerName(@"LuckPanViewController");
    }
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
-(void)didActionBottomIndex:(NSInteger)index{
    
}
-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
