//
//  AIJokeDataModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIJokeDataModel : NSObject
/**内容*/
@property(nonatomic,strong)NSArray *data;
/**
 *  最大时间
 */
@property(nonatomic ,copy)NSString *max_time;
/**
 *  最小时间
 */
@property(nonatomic ,copy)NSString *min_time;

@end
