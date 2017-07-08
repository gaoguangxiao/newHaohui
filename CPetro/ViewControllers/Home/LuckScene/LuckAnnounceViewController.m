//
//  WinterAnnounceViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/28.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LuckAnnounceViewController.h"

#import "CGTableView+loadView2.h"
#import "EntityMessager.h"
#import "OnceTitleCell.h"
@interface LuckAnnounceViewController ()
{
    __weak IBOutlet CGTableView_loadView2 *_tableView;
   
    
}
@property(nonatomic,strong)NSMutableArray *baseData;
@end

@implementation LuckAnnounceViewController
-(NSMutableArray *)baseData{
    if (!_baseData) {
        _baseData = [NSMutableArray new];
    }
    return _baseData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"中奖公告";
    
    _tableView.isFooter = NO;
}
-(void)refreshView{
    
    
//    获取会员已中奖记录（最近20条）
    CGDataResult *h = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"code":@"xycj"} andBymethodName:@"api/draw/luckyDetail"];
    if (h.status.boolValue&&[h.dataList count]>0) {
        [self.baseData removeAllObjects];
        NSArray *t = [EntityMessager getObjecsFromDic:h.dataList];
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
    NSString *allString = [NSString stringWithFormat:@"恭喜 %@ 获得 %@",[self.baseData[indexPath.row] memberName],[self.baseData[indexPath.row]awardName]];
    cell.titleText.textColor = K_NavigationTitleColor;
     cell.titleText.attributedText = [allString containsStringfirstStr:[self.baseData[indexPath.row]memberName] andkeyColor:K_RGBColor(244, 252, 50) andSecondString:[self.baseData[indexPath.row]titleText] andkeyColor:K_RGBColor(244, 252, 50)];
//    cell.data          =  [NSString stringWithFormat:@"%@ 获得 %@",[self.baseData[indexPath.row] memberName],[self.baseData[indexPath.row] awardName]];
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
