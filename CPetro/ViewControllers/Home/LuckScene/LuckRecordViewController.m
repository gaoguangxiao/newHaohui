//
//  WinterRecordViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/28.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LuckRecordViewController.h"

#import "CGTableView+loadView2.h"
#import "EntityMessager.h"
#import "OnceTitleCell.h"
@interface LuckRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet CGTableView_loadView2 *_tableView;
    __weak IBOutlet UILabel *_userName;
    
}
@property(nonatomic,strong)NSMutableArray *baseData;
@end

@implementation LuckRecordViewController
-(NSMutableArray *)baseData{
    if (!_baseData) {
        _baseData = [NSMutableArray new];
    }
    return _baseData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"中奖明细";
    
    _tableView.isFooter= NO;
    NSString *allString =  [NSString stringWithFormat:@"会员账号：%@",[CustomUtil getUserInfo].memberName != nil?[CustomUtil getUserInfo].memberName:@""];
    _userName.attributedText = [allString containsString:[CustomUtil getUserInfo].memberName != nil?[CustomUtil getUserInfo].memberName:@"" andkeyColor:K_RGBColor(244, 252, 50)];
}
-(void)refreshView{
    
   

    CGDataResult *h = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/draw/memberLuckyDetail"];
    if (h.status.boolValue&&[h.dataList count]>0) {
        
        NSArray *t = [EntityMessager getObjecsFromDic:h.dataList];
         [self.baseData removeAllObjects];
        [self.baseData addObjectsFromArray:t];

    }

    
}
-(void)loadMore{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.baseData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdenti = @"OnceTitleCell";
    OnceTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenti];
    if (!cell) {
        cell = [[OnceTitleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdenti];
    }
    NSString *allString = [NSString stringWithFormat:@"%@ 获得 %@",[self.baseData[indexPath.row] createTime],[self.baseData[indexPath.row]titleText]];
    cell.titleText.textColor = K_NavigationTitleColor;
    cell.titleText.attributedText = [allString containsString:[self.baseData[indexPath.row]titleText] andkeyColor:K_RGBColor(244, 252, 50)];
    return cell;
    
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
