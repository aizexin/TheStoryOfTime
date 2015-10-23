//
//  AIEverdayTool.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//  关于everday模块工具类

#import <Foundation/Foundation.h>
@class AIEverydayLineFrameModel;
@interface AIEverydayTool : NSObject

/**
 *  保存frameModel到本地
 */
+(void)saveLineFrameModel:(AIEverydayLineFrameModel*)frameModel;
/**
 *  读取本地frameModel
 */
+(AIEverydayLineFrameModel *)frameModel;
//-----------------------数据库相关-----------------
/**
 *  储存照片到本地
 */
+(void)saveImage:(UIImage*)image;
/**
 *  从数据库中取出所有模型
 */
+(NSMutableArray*)allEverydayCellModel;
/**从数据库中删除一个EverydayCellModel*/
+(void)deleteEverdayCellModelWithIndex:(NSInteger)index;
@end
