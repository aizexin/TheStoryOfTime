//
//  AIBaseTool.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIBaseTool.h"
#import "MJExtension.h"
#import "AIHttpTool.h"
@implementation AIBaseTool

+(void)getWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void (^)(NSError* error))failure{
    //模型转换为字典
         NSDictionary *params = [param keyValues];
    
        [AIHttpTool get:url params:params success:^(id responseObject) {
            if (success) {
                id model = [resultClass objectWithKeyValues:responseObject];
                success(model);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
}

+(void)postWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void (^)(NSError* error))failure{
    //模型转换为字典
    NSDictionary *params = [param keyValues];
    
    [AIHttpTool post:url params:params success:^(id responseObject) {
        if (success) {
            id model = [resultClass objectWithKeyValues:responseObject];
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
