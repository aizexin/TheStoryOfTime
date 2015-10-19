//
//  AIStatusesTool.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/12.
//  Copyright © 2015年 aizexin. All rights reserved.
// 微博业务工具类 ：处理关于微博的一切业务，加载，什么的


#import "AIStatusesTool.h"
#import "MJExtension.h"

@implementation AIStatusesTool
+(void)homeStatusesWithParams:(AIHomeStatusesParamModel *)paramModel success:(void (^)(AIHomeStatusesResultModel* resultModel))success failure:(void (^)(NSError *error))failure{
    
    [AIStatusesTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" params:paramModel resultClass:[AIHomeStatusesResultModel class] success:success failure:failure];

}

+(void)userInfoStatusesWithParams:(AIUserInfoParamModel *)paramModel success:(void (^)(AIUserInfoResultModel * resultModel))success failure:(void (^)(NSError *error))failure{

    [AIStatusesTool getWithUrl:@"https://api.weibo.com/2/users/show.json" params:paramModel resultClass:[AIUserInfoResultModel class] success:success failure:failure ];
}

+(void)composeStatusesWithParams:(AIComposeParamModel *)paramModel success:(void (^)(AIComposeResultModel * resultModel))success failure:(void (^)(NSError *error))failure{

    [AIStatusesTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:paramModel resultClass:[AIComposeResultModel class] success:success failure:failure];
}
//-(void)ss{
//    void(^block)(int a,int ) = ^(int a,int b ){
//        
//    };
//}
@end


