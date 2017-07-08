//
//  LuckPanViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LuckPanViewController.h"

#import <AVFoundation/AVFoundation.h>//导入

#import "PrizeView.h"
@interface LuckPanViewController ()<PrizeViewDelegate>
{
    __weak IBOutlet UIImageView *_rotateWheel;
    NSString *drawTimes;//记录剩余抽奖次数
    BOOL centerSelect;
    
}
@property (nonatomic,assign) NSInteger indexLuck;//决定那个生肖中奖
@property (nonatomic,strong) AVAudioPlayer *avAudioPlayer;;//音乐播放器
@end

@implementation LuckPanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.avAudioPlayer play];//出现播放
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"幸运大转盘";
    
    [self EggPlayAudio];
}
#pragma mark - 加载抽奖次数
-(NSString *)loaddrawTimesCount{
    //    http://103.226.152.162:7777/api/member/drawTimes?clientId=9594013671
    //    api/member/drawTime
    CGDataResult *h =[Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/drawTimes"];
    if (h.status.boolValue) {
        return  h.dataList[@"drawTimes"];
    }else{
        return @"0";
    }
    

}

#pragma mark -加载音乐播放
-(void)EggPlayAudio{
    //实现音乐
    //    NSError *error;
    NSString *string = [[NSBundle mainBundle] pathForResource:@"backMusic" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    self.avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.avAudioPlayer.numberOfLoops = 1;
    [self.avAudioPlayer play];
}

#pragma mark -加载结果音效
-(void)EggResult:(NSString *)musicName{
    NSString *hitstring = [[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *urlHit = [NSURL fileURLWithPath:hitstring];
    self.avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:urlHit error:nil];
    [self.avAudioPlayer play];
}

//开始转动 条件是：下注之后，倒计时结束
- (IBAction)PickNumber:(UIButton *)sender {
//    NSLog(@"%d",centerSelect);
    
    if (centerSelect) {
        return;
    }
    if ([[self loaddrawTimesCount] doubleValue] <=0) {
        [self.view makeToast:@"抽奖次数为0" duration:1.0f position:@"center"];
        return;
    }
    centerSelect = YES;
    [self startRotate];
}

-(void)startRotate{
    if (![_rotateWheel.layer animationForKey:@"Rotate"]) {
        CABasicAnimation* animation = [[CABasicAnimation alloc] init];
        
        animation.keyPath = @"transform.rotation";
        animation.toValue = @(2 * M_PI * 15 - M_PI * 2 / 12 * self.indexLuck + M_PI * 2 / 12 /2);//决定哪个生肖中奖 0永远指向上面
        animation.duration = 2;//转动的时间
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        [_rotateWheel.layer addAnimation:animation forKey:@"Rotate"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _rotateWheel.transform = CGAffineTransformMakeRotation([animation.toValue floatValue]);
            
            //清除图层
            [_rotateWheel.layer removeAnimationForKey:@"Rotate"];
            //游戏结束
            [self rotataionEnd];
            
        });
        
    }
}
-(void)rotataionEnd{
    
    centerSelect = NO;
    
    NSArray *resultArray = [[NSArray arrayWithArray:[self gainWinteResult]] firstObject];
    
    PrizeView *prizeView = [[PrizeView alloc]initItemWithFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andData:resultArray];
    prizeView.delegate = self;
    [[[UIApplication sharedApplication]keyWindow]addSubview:prizeView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self EggResult:@"BackWinter"];
    });

}
#pragma mark - 获取抽奖结果
-(NSArray *)gainWinteResult{
    NSArray *resultsArray;
    CGDataResult *h = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"code":@"xycj"} andBymethodName:@"api/draw/draw"];
    if (h.status.boolValue) {
        if ([h.dataList[@"awardNo"] isEqualToString:@"-1"]) {
            resultsArray = [NSArray arrayWithObjects:@[[UIImage imageNamed:@"EggResultFail"],@"差一点就中奖啦~"],nil];
        }else{
            resultsArray = [NSArray arrayWithObjects:@[[UIImage imageNamed:@"EggResultWinterImage"],h.dataList[@"awardName"]], nil];
            
        }
    }
    return resultsArray;
}
#pragma mark - PrizeViewDelegate
-(void)viewRemove{
    //重新
    [self resetEgg];
}
-(void)resetEgg{
    [self EggPlayAudio];
}


#pragma mark - 进入中奖公告、中奖明细
-(IBAction)selector:(UIButton  *)sender{
    [self.avAudioPlayer pause];
    if (sender.tag == 0)PushViewControllerName(@"LuckAnnounceViewController");
    else PushViewControllerName(@"LuckRecordViewController");
    
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
