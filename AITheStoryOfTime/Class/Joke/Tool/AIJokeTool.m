//
//  AIJokeTool.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
/*
 
 */

#import "AIJokeTool.h"
#import "AIJokeCellModel.h"
#import "AIJokeParamModel.h"
#import "AIDBTool.h"
@implementation AIJokeTool

+(void)JokeWithParams:(AIJokeParamModel *)paramModel success:(void (^)(AIJokeCellModel* resultModel))success failure:(void (^)(NSError *error))failure{
//    &min_time=1416277057
    //默认一次20条数据
    [AIJokeTool getWithUrl:@"http://ic.snssdk.com/neihan/stream/category/data/v2/?tag=joke&iid=3139869339&os_version=9.0.2&os_api=18&app_name=joke_essay_social&channel=App%20Store&device_platform=ipad&idfa=idfa&vid=9900A444-643A-4792-BF53-5925CE7EBC2F&openudid=3beaf94e87d2b03d89c135480b3b36a78871aa27&device_type=iPad%20AIR&version_code=4.4.1&ac=WIFI&screen_width=1536&device_id=4437206054&aid=20&category_id=1&count=30&level=6&message_cursor=0&min_time=1445949969&mpic=1" params:paramModel resultClass:[AIJokeCellModel class] success:success failure:failure];
}

/**
 * 保存最后20条数据
 */
+(void)save20Joke:(NSArray*)jokes{
    //创建数据库
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    //创建joketable
    [dbtool createJokeTable];
    //存储数据
    for (AIJokeGroupModel *groupModel in jokes) {
        [dbtool insertJokeCellModel:groupModel];
    }
}
/**
 *  清空Joke缓存
 */
+(void)cleanJoke{
    //创建数据库
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    [dbtool deleteAllJokeTable];
}
/**
 *  读取数据库
 */
+(NSMutableArray *)readJokeTable{
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    return [dbtool selectAllJokeCellModel];
}


@end
