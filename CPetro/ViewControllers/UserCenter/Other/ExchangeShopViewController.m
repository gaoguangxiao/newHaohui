//
//  ExchangeShopViewController.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/29.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "ExchangeShopViewController.h"

//view
#import "AndyDropDownList.h"

#import "EntityCatalog.h"
#import "EntityGoods.h"
@interface ExchangeShopViewController ()<AndyDropDownDelegate>
{
    __weak IBOutlet UILabel *_needPoint;//所需积分
    __weak IBOutlet UILabel *_goodsName;//商品类型
    __weak IBOutlet UILabel *_peridTime;//有效期限
    NSString *selectGoodsId;//选择的新濠币id
    
    __weak IBOutlet UITextField *_categoryText;//分类的按钮
    NSMutableArray *catalogArrayName;//分类集合数组
    NSMutableArray *cateLogArrayModel;//
    
    NSMutableArray *newCatalogIdName;//新濠币的种类
    __weak IBOutlet UITextField *_newValue;//显示的面值
    NSArray *newCatelogGoods;
    
}
@property (nonatomic, strong) AndyDropDownList *list;
@end

@implementation ExchangeShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItemTitle = @"商品兑换";
    
    catalogArrayName = [NSMutableArray new];
    cateLogArrayModel = [NSMutableArray new];
    newCatalogIdName = [NSMutableArray new];
    
    [self showAnimated:YES title:@"" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken]} andBymethodName:@"api/pointGoods/catalog"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if (b) {
            NSArray *catalogArray = [EntityCatalog getObjecsFromDic:r.dataList];
            [cateLogArrayModel addObjectsFromArray:catalogArray];
            [catalogArray enumerateObjectsUsingBlock:^(EntityCatalog *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [catalogArrayName addObject:obj.catalogName];
                
                
                
                if (idx == 0) {
                    [self querypointGoods:obj.catalogId];
                    _categoryText.text = obj.catalogName;
                }
            }];
        }
    }];
    
    [self.view addSubview:self.list];//先添加
}
#pragma mark - 选择商品
- (IBAction)ChoseGoods:(UIButton *)sender {
    if (catalogArrayName.count > 0&&newCatalogIdName.count>0) {
        CGRect rectDropFram = self.list.frame;
        if (sender.tag == 0) {//商品
            rectDropFram.origin.y = 188;
            
            [self.list setShowData:catalogArrayName];
        }else{
            rectDropFram.origin.y = 248;
            [self.list setShowData:newCatalogIdName];
        
        }
        self.list.frame = rectDropFram;
        [self.list showList:self.list.frame.origin.y];
        self.list.tag = sender.tag;
        
        
    }
}

#pragma mark - 查询积分商品
-(void)querypointGoods:(NSString *)catalogId{
    
    [self showAnimated:YES title:@"正在查询" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"catalogId":catalogId} andBymethodName:@"api/pointGoods/query"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
            newCatelogGoods = [EntityGoods getObjecsFromDic:r.dataList];
            [newCatelogGoods enumerateObjectsUsingBlock:^(EntityGoods *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [newCatalogIdName addObject:obj.goodsName];//获取分类的新濠币
                if (idx == 0) {
                    _newValue.text = obj.goodsName;//初始化
                    [self updatePointGoodsData:obj];//更新第一组数据
                }
            }];
        }
    }];
}

#pragma mark - 立即兑换
- (IBAction)ExchangePointGoods:(UIButton *)sender {
    [self ExchangepointGoodsMethod:selectGoodsId andServiceCode:@"1"];
}

#pragma mark -立即兑换
-(void)ExchangepointGoodsMethod:(NSString *)goodsId andServiceCode:(NSString *)serviceCode{
    [self showAnimated:YES title:@"正在兑换。。。" whileExecutingBlock:^CGDataResult *{
        return [Service loadNetWorkingByParameters:@{@"clientId":[CustomUtil getToken],@"goodsId":goodsId,@"serviceCode":serviceCode} andBymethodName:@"api/pointGoods/exchange"];
    } completionBlock:^(BOOL b, CGDataResult *r) {
        if(b){
             [self.view makeToast:@"兑换成功" duration:1.0f position:@"center"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                POP;

            });
            
        }
    }];
}
#pragma mark - view
-(AndyDropDownList *)list{
    if (!_list){
        _list = [[AndyDropDownList alloc]initWithListDataSource:catalogArrayName rowHeight:35 indexy:CGRectGetMaxY(_categoryText.frame) view:_categoryText];
        //        _list = [[AndyDropDownList alloc]initWithListDataSource:catalogArrayName rowHeight:44 view:_categoryBtn];
        _list.delegate = self;
    }
    return _list;
}

-(void)dropDownListParame:(NSString *)aStr andViewAndy:(AndyDropDownList *)andyDropDownList{
    if (andyDropDownList.tag == 0) {
        //        [self sortDataCatalog:aStr andNewValue:_newValue.text];
        _categoryText.text = aStr;
        [cateLogArrayModel enumerateObjectsUsingBlock:^(EntityCatalog*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
            if ([obj.catalogName isEqualToString:aStr]) {//选择商品
                [self querypointGoods:obj.catalogId];
            }
        }];
    }else{
        [self sortDataNewValue:aStr];
        
    }
    
}
#pragma mark -界面数据渲染
-(void)sortDataNewValue:(NSString *)valueName{
    _newValue.text = valueName;
    [newCatalogIdName enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([valueName isEqualToString:obj]) {
            [newCatelogGoods enumerateObjectsUsingBlock:^(EntityGoods *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.goodsName isEqualToString:valueName]) {
                    [self updatePointGoodsData:obj];
                }
            }];
        }
    }];
}
//更新商品数据
-(void)updatePointGoodsData:(EntityGoods *)goodsInfo{
    _needPoint.text = goodsInfo.needPoint;
    
    _goodsName.text = [goodsInfo.goodsType isEqualToString:@"1"]?@"实物":@"虚拟货币";
    
    _peridTime.text = [NSString stringWithFormat:@"%@天",goodsInfo.period];
    
    //记录选择的 新濠币id
    selectGoodsId =  goodsInfo.goodsId;
    
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
