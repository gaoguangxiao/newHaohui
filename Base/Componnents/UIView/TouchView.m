//
//  TouchView.m
//  HyJoinCar
//
//  Created by ggx on 2016/11/8.
//  Copyright © 2016年 乐途拼车. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
//    NSLog(@"触摸底部视图");
}

- (IBAction)touchView:(id)sender {
    [self endEditing:YES];
}
@end
