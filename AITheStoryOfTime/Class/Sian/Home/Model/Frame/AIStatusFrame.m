//
//  AIStatusFrame.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusFrame.h"
#import "AIStatusDetailFrame.h"
#import "AIStatusesModel.h"
#import "AIDefine.h"
@implementation AIStatusFrame


-(void)setStatusesModel:(AIStatusesModel *)statusesModel{
    _statusesModel = statusesModel;
    //计算具体内容
    [self setupDetailFrame];
    //计算toolbar
    [self setupToolbarFrame];
    //计算cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}
-(void)setupDetailFrame{
    AIStatusDetailFrame *detailFrame = [[AIStatusDetailFrame alloc] init];
    detailFrame.statusesModel = self.statusesModel;
    self.detailFrame = detailFrame;
}
-(void)setupToolbarFrame{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = Mainsize.width;
    ;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}
@end
