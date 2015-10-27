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
/**收藏*/
@property(nonatomic ,assign)NSNumber *favorite_count;
/**推存*/
@property(nonatomic ,assign)NSNumber *digg_count;
/**用户是否已经点踩*/
@property(nonatomic ,assign)NSNumber *user_bury;
/**用户是否已经点赞*/
@property(nonatomic ,assign)NSNumber *user_digg;
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
