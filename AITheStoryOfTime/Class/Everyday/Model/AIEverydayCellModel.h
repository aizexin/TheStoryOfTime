//
//  AIEverydayCellModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIEverydayCellModel : NSObject
/**
 *  得到的图片
 */
@property(nonatomic,strong)UIImage *everydayImage;
/**
 *  日期
 */
@property(nonatomic,copy)NSString *time;
/**
 *  数据库中id
 */
@property(nonatomic,assign)NSNumber *cellId;
@end
