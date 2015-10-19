//
//  AIStatusesTool.h
//  AISian
//
//  Created by 艾泽鑫 on 15/10/12.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIHomeStatusesParamModel.h"
#import "AIHomeStatusesResultModel.h"
#import "AIUserInfoParamModel.h"
#import "AIUserInfoResultModel.h"
#import "AIComposeParamModel.h"
#import "AIComposeResultModel.h"
#import "AIBaseTool.h"
@interface AIStatusesTool : AIBaseTool
//[AIStatusesTool homeStatusesWithParams:(参数模型) success:(返回一个结果模型) failure:(void (^)(NSError *error))];
+(void)homeStatusesWithParams:(AIHomeStatusesParamModel *)paramModel success:(void (^)(AIHomeStatusesResultModel* resultModel))success failure:(void (^)(NSError *error))failure;
/**
 请求用户信息数据
*/
+(void)userInfoStatusesWithParams:(AIUserInfoParamModel *)paramModel success:(void (^)(AIUserInfoResultModel * resultModel))success failure:(void (^)(NSError *error))failure;

/**
 发送一条没有图片的微博
 */
+(void)composeStatusesWithParams:(AIComposeParamModel *)paramModel success:(void (^)(AIComposeResultModel * resultModel))success failure:(void (^)(NSError *error))failure;

@end
