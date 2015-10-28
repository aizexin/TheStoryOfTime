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
/**
 *  请求笑话数据
 *
 *  @param paramModel <#paramModel description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)JokeWithParams:(AIJokeParamModel *)paramModel success:(void (^)(AIJokeCellModel* resultModel))success failure:(void (^)(NSError *error))failure;
/**
 * 保存最后20条数据
 */
+(void)save20Joke:(NSArray*)jokes;
/**
 *  清空Joke缓存
 */
+(void)cleanJoke;
/**
 *  读取数据库
 */
+(NSMutableArray *)readJokeTable;
@end
