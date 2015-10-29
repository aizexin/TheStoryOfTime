//
//  AIHttpTool.h
//  AISian
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AINetStateNONet,   //没网
    AINetStateWAN,   //手机自带广域网
    AINetStateWIFI   //WIFI
}AINetState;

@interface AIHttpTool : NSObject


+(void)get:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+(void)post:(NSString*)path params:(NSDictionary*)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**检测网络*/
+ (BOOL)isReachable;

@end
