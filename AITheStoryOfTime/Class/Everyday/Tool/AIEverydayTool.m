//
//  AIEverdayTool.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayTool.h"
#import "AIEverydayLineFrameModel.h"
#define PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"everydayFrameModel"]
@implementation AIEverydayTool

+(void)saveLineFrameModel:(AIEverydayLineFrameModel*)frameModel{
    //归档
    [NSKeyedArchiver archiveRootObject:frameModel toFile:PATH];
}

+(AIEverydayLineFrameModel *)frameModel{
    //接档
    AIEverydayLineFrameModel *frameModel = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH];
    return frameModel;
}
@end
