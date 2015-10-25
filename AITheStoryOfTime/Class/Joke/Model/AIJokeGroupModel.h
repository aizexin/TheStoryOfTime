//
//  AIJokeGroupModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AIJokeUserModel;
@interface AIJokeGroupModel : NSObject
/**内容*/
@property(nonatomic ,copy)NSString *content;
/**踩的数*/
@property(nonatomic ,assign)NSNumber *bury_count;
/**喜欢的数*/
@property(nonatomic ,assign)NSNumber *favorite_count;
/**id号*/
@property(nonatomic ,copy)NSNumber *id;
/**
 *  评论数
 */
@property(nonatomic ,copy)NSString *comment_count;
/**
 *  用户信息
 */
@property(nonatomic,strong)AIJokeUserModel *user;
@end
