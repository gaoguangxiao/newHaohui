//
//  NoticeViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/4/5.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "NoticeViewController.h"

#import "NoticeCell.h"
#import "EntityAd.h"
#import "CGTableView+loadView2.h"
@interface NoticeViewController ()<UIView_LoadViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet CGTableView_loadView2 *_tableView;
   
}
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"公告栏";
//    [_tableView registerNib:[UINib nibWithNibName:@"NoticeCell" bundle:nil] forCellReuseIdentifier:@"NoticeCell"];
    _tableView.isFooter = NO;
    _tableView.isHeader = NO;
}
-(void)refreshView{
    
}
-(void)loadMore{
    
}
#pragma mark - table Delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataLine.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EntityAd *add = self.dataLine[indexPath.row];
    
    CGSize size = TEXTSIZE(add.zhaiyao, [UIFont systemFontOfSize:17.0], CGSizeMake(SCREEN_WIDTH - 65, MAXFLOAT));
    
    return size.height + 36;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentidi = @"cellIndex";
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentidi];
    if (!cell) {
        cell = CreateCell(@"NoticeCell");
    }
    cell.add = self.dataLine[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
