//
//  AIBaseTool.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIBaseTool : NSObject
//[AIHttpTool getWithUrl:@"" params:param resultModel:resultClass success:success failure:failure ]
+(void)getWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void (^)(NSError* error))failure;
+(void)postWithUrl:(NSString *)url params:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void (^)(NSError* error))failure;
@end
