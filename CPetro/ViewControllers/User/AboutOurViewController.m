//
//  AboutOurViewController.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "AboutOurViewController.h"

#import "CGTableView+loadView2.h"
#import "ChartMessage.h"
#import "ChartCellFrame.h"
#import "ChartCell.h"
@interface AboutOurViewController ()<UITextViewDelegate>
{
    __weak IBOutlet UILabel *_tipLable;
    __weak IBOutlet CGTableView_loadView2 *_tableView;
    __weak IBOutlet UITextView *_textView;
    
}
@property (readwrite, nonatomic, strong) NSTimer *activationDelayTimer;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@end

static NSString *const cellIdentifier=@"chatCell";
@implementation AboutOurViewController
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.activationDelayTimer invalidate];//销毁
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"联系我们";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _tableView.isHeader = NO;
    _tableView.isFooter = NO;
    

    [self startActivationDelayTimer];
//        [self.tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];

    
    //加载客服回复
    [self loadKefuAnreply];
}
- (void)startActivationDelayTimer {
  self.activationDelayTimer = [NSTimer
                               timerWithTimeInterval:5 target:self selector:@selector(activationDelayTimerFiredNewMeseage) userInfo:nil repeats:YES];
  [[NSRunLoop mainRunLoop] addTimer:self.activationDelayTimer forMode:NSRunLoopCommonModes];
}
- (void)activationDelayTimerFiredNewMeseage{
    [self judgeNewMessage];
}
//键盘弹出响应
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

//键盘收起响应
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
-(void)textViewDidChange:(UITextView *)textView{
    _tipLable.hidden = textView.text.length>0;
}
#pragma mark - 发送聊天
- (IBAction)SendMassage:(id)sender {
    if (_textView.text.length > 0) {
        
    }else{
         [self.view makeToast:@"请输入内容" duration:1.0f position:@"center"];
        return;
    }
    //显示自己的问题
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
//    chartMessage.icon=@"icon01.png";
    chartMessage.messageType= @"1";
    chartMessage.content= _textView.text;
    cellFrame.chartMessage=chartMessage;
    
    [self.cellFrames addObject:cellFrame];
    [_tableView reloadData];
    
    //滚动到当前行
    [self tableViewScrollCurrentIndexPath];
    
    _textView.text = @"";//
    //利用用户问题, 查询结果
    
    //API请求格式。 具体格式见图灵官网
    //6c2cfaf7a7f088e843b550b0c5b89c26 替换成你申请的key即可
    
    //NSUTF8StringEncoding编码。 避免中文错误
    [self showAnimated:YES title:@"" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"content":_textView.text} andBymethodName:@"api/memberMsg/add"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            [self loadKefuAnreply];
        }
    }];

}
-(void)judgeNewMessage{
    //判断是否有新的消息
    NSLog(@"来了新消息");
    
//    [self testNew];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGDataResult *h  = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/memberMsg/hasMsg"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (h.status.boolValue) {
                if ([h.dataList[@"hasMsg"] isEqualToString:@"1"]) {
                     [self loadKefuAnreply];//加载
                }
            }
        });
    });

}
-(void)testNew{
    [_textView resignFirstResponder];
    
    //显示回答内容
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage= (ChartMessage *)[ChartMessage getObjectFromDic:@{@"createTime":@"2017-03-07 05:58:19",@"content":@"新消息",@"memberName":@"TEST1",@"msgType":@"2"}];
    
 
    cellFrame.chartMessage=chartMessage;
    
    [self.cellFrames addObject:cellFrame];
    [_tableView reloadData];
    
    //滚动到当前行
    [self tableViewScrollCurrentIndexPath];

}
#pragma mark -有新消息就加载
-(void)loadKefuAnreply{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGDataResult *r = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/memberMsg/get"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (r.status.boolValue) {
                 [self initwithData:r.dataList];
            }
        });
    });

}
//加载数组形式
-(void)initwithData:(NSArray *)listData{
    
    
    if (listData.count == self.cellFrames.count) {//说明没有新的消息
        return;
    }
    
    self.cellFrames=[NSMutableArray array];

    for(NSDictionary *dict in listData){
        //
        ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
        //数据模型
        ChartMessage *chartMessage= (ChartMessage *)[ChartMessage getObjectFromDic:dict];
        cellFrame.chartMessage=chartMessage;//模型传给Frame
        
        [self.cellFrames addObject:cellFrame];
    }
    

    [_tableView reloadData];
    [self tableViewScrollCurrentIndexPath];
    
}

#pragma mark - 聊天列表
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ChartCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.cellFrame=self.cellFrames[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}

-(void)tableViewScrollCurrentIndexPath{
    if (self.cellFrames.count > 0) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellFrames.count-1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
   
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
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
