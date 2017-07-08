//
//  ApplyScoreViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/29.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "ApplyScoreViewController.h"

#import "AndyDropDownList.h"

#import "EntityScore.h"
@interface ApplyScoreViewController ()<AndyDropDownDelegate>
{
    __weak IBOutlet UILabel *_totalTimes;
    __weak IBOutlet UILabel *_remainTimes;//剩余次数
    __weak IBOutlet UILabel *_expireDate;
    NSString *selectGoodsId;
    __weak IBOutlet UITextField *_categoryText;
    
    NSMutableArray *catalogArrayName;//分类集合数组
    NSMutableArray *cateLogArrayModel;//
}
@property (nonatomic, strong) AndyDropDownList *list;
@end

@implementation ApplyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"申请积分";
    catalogArrayName  = [NSMutableArray new];
    cateLogArrayModel = [NSMutableArray new];
    
    //查询申请积分记录
    [self showAnimated:YES title:@"查询中。。。" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/member/queryMemberPointGoods"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            [self handleData:r.dataList];
            
        }else{//测试数据
            NSArray *ArrayData = @[
  @{@"goodsName":@"500新濠币",@"totalTimes":@"10",@"remainTimes": @"2",@"expireDate":@"2016-12-15",@"id": @"3"},
  @{@"goodsName":@"300新濠币",@"totalTimes": @"5",@"remainTimes": @"2",@"expireDate": @"2016-12-15",@"id":@"3"}];
            [self handleData:ArrayData];
        }
    }];
}
-(void)handleData:(NSArray *)dataDic{
    NSArray *catalogArray = [EntityScore getObjecsFromDic:dataDic];
    [cateLogArrayModel addObjectsFromArray:catalogArray];
    [catalogArray enumerateObjectsUsingBlock:^(EntityScore *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        [catalogArrayName addObject:obj.goodsName];
        if (idx == 0) {
            [self updatePointScoreData:obj];
            
            _categoryText.text = obj.goodsName;
        }
    }];
    [self.view addSubview:self.list];
}
//更新商品数据

- (IBAction)ChoseBtnGoods:(UIButton *)sender {
    [self.list showList:188];
    
}
#pragma mark - view
-(AndyDropDownList *)list{
    if (!_list){
        _list = [[AndyDropDownList alloc]initWithListDataSource:catalogArrayName rowHeight:35 indexy:188 view:_categoryText];
        _list.delegate = self;
    }
    return _list;
}

-(void)dropDownListParame:(NSString *)aStr andViewAndy:(AndyDropDownList *)andyDropDownList{
    _categoryText.text = aStr;
    [cateLogArrayModel enumerateObjectsUsingBlock:^(EntityScore*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        if ([obj.goodsName isEqualToString:aStr]) {//选择商品
            [self updatePointScoreData:obj];
        }
    }];
}
-(void)updatePointScoreData:(EntityScore *)score{
    _totalTimes.text = score.totalTimes;
    
    _remainTimes.text = score.remainTimes;
    
    NSDateFormatter *outPutStr = [NSDateFormatter dateFormatterWithFormat:@"yyyy年MM月dd日"];
    NSString *addTime = [outPutStr stringFromDate:[U_CILENT_FORMATTER dateFromString:score.expireDate]];
    _expireDate.text = addTime;

    
    selectGoodsId = score.Id;
    
}
- (IBAction)TouchScoreApply:(id)sender {
    [self scoreApply];
}

-(void)scoreApply{
    
    
    //可以判断是否可以申请
//    [self showAnimated:NO title:@"" whileExecutingBlock:^CGDataResult *{
//        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"applyPoint":selectGoodsId} andBymethodName:@"api/pointGoods/pointApply"];
//    } completionBlock:^(BOOL b, CGDataResult *r) {
//        if(b){
            //提交申请
//            http://103.226.152.162:7777/api/pointGoods/useGoods?goodsId=90&clientId=9340773321&
            [self showAnimated:YES title:@"申请积分" whileExecutingBlock:^CGDataResult *{
                return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"goodsId":selectGoodsId} andBymethodName:@"api/pointGoods/useGoods"];
            } completionBlock:^(BOOL b, CGDataResult *r) {
                if(b){
                    [self.view makeToast:r.errorMsg duration:1.0f position:@"center"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        POP;
                    });
                }
            }];

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
