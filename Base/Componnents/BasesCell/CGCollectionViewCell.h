//
//  CGCollectionViewCell.h
//  HyJoinCar
//
//  Created by ggx on 2016/11/3.
//  Copyright © 2016年 乐途拼车. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CGCollectionViewCell : UICollectionViewCell
/**
 所有的cell全部继承这个cell，传值采用 data
 */
@property(nonatomic,assign)id data;

@property(nonatomic,strong)NSIndexPath *indexPath;
@end
