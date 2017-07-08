//
//  LRMoreInputView.m
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "LRMoreInputView.h"


@implementation LRMoreInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initItemWithFram:(CGRect)frame andData:(NSArray *)paramData{
    if (self = [super initWithFrame:frame]) {
        NSInteger countRow = paramData.count;
        CGSize size = frame.size;
        
        NSInteger separatedHeight  = size.height/countRow;
        for (NSInteger i = 0; i<countRow; i++) {
            NSDictionary *tipNameDic = paramData[i];//修改为字典
            LRInputView *lrInput = [[LRInputView alloc]initItemWithFrame:CGRectMake(0, separatedHeight * i, size.width,separatedHeight) andlabelName:tipNameDic];
            lrInput.tag = i;
            [self addSubview:lrInput];
        }
       
    }
    return self;
}

@end
