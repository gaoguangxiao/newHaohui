//
//  MorePictureView.m
//  SimpleSrore
//
//  Created by gaoguangxiao on 2017/3/25.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "MorePictureView.h"

#import "EntityAd.h"
@implementation MorePictureView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(id)initMorePictureItemWithFram:(CGRect)frame andData:(NSArray *)paramData;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.bgimageView];
        [self.bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.top.bottom.equalTo(self);
        }];
        
        [self.bgimageView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgimageView).offset([self backLeftMaginHeight]);
            make.right.equalTo(self.bgimageView).offset(-60);
            make.height.equalTo(@30);
            make.top.equalTo(self.bgimageView).offset([self backtopMaginHeight]);
        }];
        
        CGSize sizeSupper = self.frame.size;
        
        CGFloat startY    = 40;
        CGFloat bottomMagin = 40;
        CGFloat sepHeight = (sizeSupper.height - startY - bottomMagin)/paramData.count ;//分割高度
        
        for (NSInteger i = 0 ; i < paramData.count; i++) {
            MorePictureTwoView *topView = [[MorePictureTwoView alloc] initItemWithFram:CGRectMake(10, startY + sepHeight * i, sizeSupper.width - 20, sepHeight) andData:paramData[i]andRow:i*10];
            topView.delegate = self;
            [self addSubview:topView];
        }
        
        
        
    }
    return self;
}
-(CGFloat)backLeftMaginHeight{
    if (SCREEN_WIDTH == 320){
        if (SCREEN_HEIGHT == 480) {
            return 70;
        }else{
            return 80;
        }
    }else{
        if (SCREEN_HEIGHT == 667) {
            return 95;
        }else{
            return 100;
            
        }
    }
    
}

-(CGFloat)backtopMaginHeight{
    if (SCREEN_WIDTH == 320){
        if (SCREEN_HEIGHT == 480) {
            return 15;
        }else{
            return 5;
        }
    }else{
        if (SCREEN_HEIGHT == 667) {
            return 13;
        }else{
            return 20;

        }
    }
    
}

-(void)Init{
    [super Init];
    self.backgroundColor = [UIColor clearColor];
    //    dispatch_after(DISPATCH_TIME_NOW,dispatch_get_main_queue(), ^{
    
    dispatch_queue_t queue = dispatch_queue_create("autoLoop", 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), 2 * NSEC_PER_SEC, 2* NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if ([self.dataNotice count]>0) {
            dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
                CGFloat heightSc = _scrollView.frame.size.height;
                
                if (((NSArray *)self.dataNotice).count>0) {
//                    NSLog(@"%f",_scrollView.contentOffset.y);
                    int page = ceilf(_scrollView.contentOffset.y/heightSc);
                    page ++;
                    page = page % ((NSArray *)self.dataNotice).count;
                    float x = page * heightSc;
//                    NSLog(@"Y的位置%f",x);
                    [_scrollView scrollRectToVisible:CGRectMake(0, x, _scrollView.frame.size.width, heightSc) animated:YES];
                }
                
            });
        }
        
    });
    dispatch_resume(timer);
    
    
}

-(void)setDataNotice:(NSArray *)dataNotice{
    _dataNotice = [dataNotice  copy];
    NSArray *dataList = _dataNotice;
    
    for (UIView *v in _scrollView.subviews) {
        [v removeFromSuperview];
    }
    
    [dataList enumerateObjectsUsingBlock:^(EntityAd *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        UIView *backView  =[[UIView alloc]initWithFrame:CGRectMake(0, _scrollView.frame.size.height * i, _scrollView.frame.size.width, 30)];
//        backView.userInteractionEnabled = YES;
        [_scrollView addSubview:backView];
        
        UILabel *labelShow = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        labelShow.textAlignment= NSTextAlignmentLeft;
        labelShow.userInteractionEnabled  = YES;
        NSMutableAttributedString *tip = [[NSMutableAttributedString alloc] init];
        [tip appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", obj.title] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:11.0f]}]];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchedAction:)];
        [labelShow addGestureRecognizer:tap];
        labelShow.attributedText = tip;
        labelShow.tag = i;
        [backView addSubview:labelShow];
        
    }];
    
    
    CGSize size = CGSizeMake(self.scrollView.bounds.size.height, dataNotice.count*self.scrollView.bounds.size.height);
    _scrollView.contentSize = size;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 30);
//        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}
-(UIImageView *)bgimageView{
    if (!_bgimageView) {
        _bgimageView = [UIImageView new];
        _bgimageView.image = [UIImage imageNamed:@"HomecenterBg"];
        _bgimageView.contentMode  = UIViewContentModeScaleToFill;
        _bgimageView.userInteractionEnabled = YES;
    }
    return _bgimageView;
}
-(void)didMorePictureTwoViewBtnItem:(NSInteger)tagBtn{
    if ([self.delegate respondsToSelector:@selector(didMorePictureViewBtn:)]) {
        [self.delegate didMorePictureViewBtn:tagBtn];
    }
}
-(void)touchedAction:(UITapGestureRecognizer *)sender{
    if (self.delegate && [_delegate respondsToSelector:@selector(clickedByHomeAtIndex:data:)]) {
        [_delegate clickedByHomeAtIndex:sender.view.tag data:_dataNotice[sender.view.tag]];
    }
}
@end
