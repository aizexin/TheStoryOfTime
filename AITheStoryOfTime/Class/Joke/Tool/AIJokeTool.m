//
//  AIJokeTool.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeTool.h"
#import "AIJokeCellModel.h"
#import "AIJokeParamModel.h"
@implementation AIJokeTool

+(void)JokeWithParams:(AIJokeParamModel *)paramModel success:(void (^)(AIJokeCellModel* resultModel))success failure:(void (^)(NSError *error))failure{
//    &min_time=1416277057
    //默认一次30条数据
    [AIJokeTool getWithUrl:@"http://ic.snssdk.com/2/essay/zone/category/data/?category_id=1&level=6&count=30&iid=2452819313&device_id=3040432338&ac=wifi&channel=baidu&aid=7&app_name=joke_essay&version_code=317&device_platform=iOS&device_type=Lan998&os_api=10&os_version=2.3.4&uuid=947214017931502&openudid=c7a885a77527ad01" params:paramModel resultClass:[AIJokeCellModel class] success:success failure:failure];
}


@end
