//
//  EatEggViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "EatEggViewController.h"

//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>//导入

#import "PrizeView.h"
@interface EatEggViewController ()<PrizeViewDelegate,CAAnimationDelegate>
{
    __weak IBOutlet UIImageView *_EggImageView;
    NSString *drawTimes;//记录剩余抽奖次数
}
@property (nonatomic,strong) AVAudioPlayer *avAudioPlayer;;//音乐播放器
@end

@implementation EatEggViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.avAudioPlayer play];//出现播放
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"砸金蛋";
    
    [self EggPlayAudio];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hitEgg:)];
    [_EggImageView addGestureRecognizer:tap];
    
    //
    [self loaddrawTimesCount];
}
#pragma mark - 加载抽奖次数
-(void)loaddrawTimesCount{
//    http://103.226.152.162:7777/api/member/drawTimes?clientId=9594013671
//    api/member/drawTime
    
    [self showAnimated:NO title:@"加载抽奖次数" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/drawTimes"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            drawTimes = r.dataList[@"drawTimes"];
        }
    }];
}
#pragma mark - 加载音效
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
#pragma mark -加载砸金蛋音效
-(void)eggHitAudio{
    //砸金蛋的声音
    [self EggResult:@"EggHit"];
}
#pragma mark -加载结果音效
-(void)EggResult:(NSString *)musicName{
    NSString *hitstring = [[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *urlHit = [NSURL fileURLWithPath:hitstring];
    self.avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:urlHit error:nil];
    [self.avAudioPlayer play];
}
#pragma mark - 击打鸡蛋
- (void)hitEgg:(UITapGestureRecognizer *)sender {
    
    
    if ([drawTimes doubleValue] <=0) {
        [self.view makeToast:@"抽奖次数为0" duration:1.0f position:@"center"];
        return;
    }else{
        //更新抽奖次数
        [self loaddrawTimesCount];
    }
    
    //创建CAKeyframeAnimation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.duration = 1.5;
    animation.delegate = self;
    
    NSMutableArray<UIImage *> *imageArr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        // 获取图片的名称
        NSString *imageName = [NSString stringWithFormat:@"EggHit%d", i+1];
        // 创建UIImage对象
        UIImage *image = [UIImage imageNamed:imageName];
        // 加入数组
        CGImageRef cgimg = image.CGImage;
        [imageArr addObject:(__bridge UIImage *)cgimg];
//        [imageArr addObject:image];
    }
    animation.values = imageArr;
    
    [_EggImageView.layer addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self eggHitAudio];//加载砸金蛋音效
    });
   
}
#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
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
    
    _EggImageView.image = [UIImage imageNamed:@"EggHit1"];
    
    [self EggPlayAudio];
}


#pragma mark - 进入中奖公告、中奖明细
-(IBAction)selector:(UIButton  *)sender{
    [self.avAudioPlayer pause];
    
    if (sender.tag == 0)PushViewControllerName(@"WinterAnnounceViewController");
    else PushViewControllerName(@"WinterRecordViewController");
    
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
