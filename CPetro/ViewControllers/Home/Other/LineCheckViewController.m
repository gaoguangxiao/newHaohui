//
//  LineCheckViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/24.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LineCheckViewController.h"

#import "CGTableView+loadView2.h"
#import "LineCheckCell.h"

@interface LineCheckViewController ()<UIView_LoadViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet CGTableView_loadView2 *_tableView;
    NSMutableArray *_dataLine;
}
@end

@implementation LineCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"线路检测";
    _dataLine = [NSMutableArray new];
    
    _tableView.isFooter = NO;
    
}
-(void)refreshView{
    [_dataLine removeAllObjects];
    
    CGDataResult *r = [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/lineCheck/get"];
    if(r.status.boolValue&&[r.dataList count]>0){
        NSArray *tempArray = [EntityLineCheck getObjecsFromDic:r.dataList];
        if (tempArray.count > 0) {
            [_dataLine addObjectsFromArray:tempArray];
        }
        
    }
}
-(void)loadMore{
    
}
#pragma mark - table Delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataLine.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentidi = @"cellIndex";
    LineCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentidi];
    if (!cell) {
        cell = CreateCell(@"LineCheckCell");
    }
    cell.lineCheck = _dataLine[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EntityLineCheck *check = _dataLine[indexPath.row];
    NSString *requestURL = check.url;

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:requestURL]];
    
   
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
