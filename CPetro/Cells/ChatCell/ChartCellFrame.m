//
//  ChartCellFrame.m
//  tulingIOS
//
//  Created by Colin on 14-8-9.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#define kIconMarginX 5
#define kIconMarginY 5

#import "ChartCellFrame.h"

@implementation ChartCellFrame

-(void)setChartMessage:(ChartMessage *)chartMessage
{
    _chartMessage=chartMessage;
    
    CGSize winSize=[UIScreen mainScreen].bounds.size;
    CGFloat iconX=kIconMarginX;
    CGFloat iconY=kIconMarginY;
    CGFloat iconWidth=40;
    CGFloat iconHeight=40;
    
    if([chartMessage.messageType intValue]==2){
      
    }else if ([chartMessage.messageType intValue]==1){
        iconX=winSize.width-kIconMarginX-iconWidth;
    }
    self.iconRect=CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    CGFloat contentX=CGRectGetMaxX(self.iconRect)+kIconMarginX;
    CGFloat contentY=iconY;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    CGSize contentSize=[chartMessage.content boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    if (contentSize.width < 180) {
          contentSize.width = 180;//
    }
  
    if([chartMessage.messageType intValue]==1){
        contentX = iconX-kIconMarginX-contentSize.width-iconWidth;
    }
//    CGSize timeSize=[chartMessage.createTime boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
//    if (timeSize.width>contentSize.width) {
//        contentSize.width = timeSize.width;
//    }
    //另外的名字和
    self.chartViewRect=CGRectMake(contentX, contentY, contentSize.width+35, contentSize.height+30+40);
    
    self.cellHeight=MAX(CGRectGetMaxY(self.iconRect), CGRectGetMaxY(self.chartViewRect))+kIconMarginX;
}
@end
