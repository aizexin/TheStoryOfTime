//
//  AIHttpTool.m
//  AISian
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//处理所有关于网络请求的问题

#import "AIHttpTool.h"
#import "AFHTTPRequestOperationManager.h"
@implementation AIHttpTool

+(void)get:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
