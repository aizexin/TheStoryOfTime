//
//  AIEverydayCell.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIEverydayCellModel;
@interface AIEverydayCell : UICollectionViewCell
/**
 *  cell中的image
 */
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 *  数据模型
 */
@property(nonatomic,strong)AIEverydayCellModel *model;
/**
 *  删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@property(nonatomic ,copy)void (^deleteBlock)();
@end
