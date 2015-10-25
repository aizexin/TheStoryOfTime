//
//  AIJokeTool.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIBaseTool.h"

@class AIJokeParamModel,AIJokeCellModel;

@interface AIJokeTool : AIBaseTool
+(void)JokeWithParams:(AIJokeParamModel *)paramModel success:(void (^)(AIJokeCellModel* resultModel))success failure:(void (^)(NSError *error))failure;
@end
