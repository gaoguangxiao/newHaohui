//
//  LRInputView.h
//  CPetro
//
//  Created by ggx on 2017/3/9.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "CGView.h"

@interface LRInputView : CGView
//重写构造方法，防止
- (id)initItemWithFrame:(CGRect)frame andlabelName:(NSDictionary *)paramData;

//@property(nonatomic,strong)

- (id)initTextWithFrame:(CGRect)frame andlabelName:(NSString *)paramData;

@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UIButton *tipName;
@property(nonatomic,strong)UITextField *inputText;
@property(nonatomic,strong)UIView *inputLineView;
@end
