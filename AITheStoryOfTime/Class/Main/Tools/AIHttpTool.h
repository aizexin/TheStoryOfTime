//
//  AIHttpTool.h
//  AISian
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIHttpTool : NSObject


+(void)get:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+(void)post:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
