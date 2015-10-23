//
//  AIEverdayTool.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayTool.h"
#import "AIEverydayLineFrameModel.h"
#import "AIEverydayCellModel.h"
#import "AIDBTool.h"
#import "NSDate+MJ.h"
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

+(void)saveImage:(UIImage*)image{
    
    AIEverydayCellModel *model = [[AIEverydayCellModel alloc]init];
    model.everydayImage = image;
    model.time = [[NSDate date]dateStringYMD];
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    [dbtool createEverdayTable];
    [dbtool insertEverydayCellModel:model];
}

+(NSMutableArray*)allEverydayCellModel{
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    [dbtool createEverdayTable];
    return [dbtool selectAllEverdayCellModel];
}

+(void)deleteEverdayCellModelWithIndex:(NSInteger)index{
    AIDBTool *dbtool = [AIDBTool shareDBTool];
    [dbtool deleteEverdayCellModelWithID:index];
}
@end
