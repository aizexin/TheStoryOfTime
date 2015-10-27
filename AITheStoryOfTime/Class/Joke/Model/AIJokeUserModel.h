//
//  AIJokeUserModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIJokeUserModel : NSObject
/**
 *  头像图片链接
 */
@property(nonatomic ,copy)NSString *avatar_url;
@property(nonatomic,strong)UIImage *iconImage;
/**
 *  用户名
 */
@property(nonatomic ,copy)NSString *name;
/**
 *  用户id
 */
@property(nonatomic ,copy)NSString *user_id;
@end
