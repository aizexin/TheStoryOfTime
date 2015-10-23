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
@end
