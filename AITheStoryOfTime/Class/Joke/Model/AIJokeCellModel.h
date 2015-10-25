//
//  AIJokeCellModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//  里面放了一个cell全部信息 包含评论

#import <Foundation/Foundation.h>
@class AIJokeDataModel;

@interface AIJokeCellModel : NSObject

@property(nonatomic,strong)AIJokeDataModel *data;

@end
