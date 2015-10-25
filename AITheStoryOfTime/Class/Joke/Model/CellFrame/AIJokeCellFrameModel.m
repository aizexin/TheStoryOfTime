//
//  AIJokeCellFrameModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeCellFrameModel.h"
#import "AIJokeDefine.h"
#import "AIJokeCellDetailFrameModel.h"

@implementation AIJokeCellFrameModel


-(void)setData:(AIJokeGroupModel *)data{
    _data = data;
    //计算详情的frame
    AIJokeCellDetailFrameModel *detailFrameModel = [[AIJokeCellDetailFrameModel alloc]init];
    detailFrameModel.data = data;
    self.detailFrameModel = detailFrameModel;
    //计算toolbar的frame
    //工具栏frame
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(detailFrameModel.frame) ;
    CGFloat toolbarW = Mainsize.width ;
    CGFloat toolbarH = 30;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    //计算高度
    self.jokeCellHeight = CGRectGetMaxY(_toolbarFrame);
}

@end
