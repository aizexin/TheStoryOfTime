//
//  AIJokeCellDetailFrameModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeCellDetailFrameModel.h"
#import "AIJokeGroupModel.h"
#import "NSString+Extension.h"
#import "AIJokeDefine.h"
@implementation AIJokeCellDetailFrameModel
-(void)setData:(AIJokeGroupModel *)data{
    _data = data;
    //头像frame
    self.iconFrame = CGRectMake(AIJokePadding, AIJokePadding + AIJokeCellMargin, AIJokeIconW, AIJokeIconH);
    
    //昵称frame
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + AIJokePadding;
    CGFloat nameY = AIJokePadding;
    CGFloat nameW = Mainsize.width - nameX - AIJokePadding;
    CGFloat nameH = AIJokeIconH;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //内容frame
    UIFont *contentFont = AIJokeContentTextFont;
    CGSize maxSize = CGSizeMake(Mainsize.width - 2*AIJokePadding, MAXFLOAT);
//    AILog(@"content---------%@",data.content);
    CGSize textSize = [data.content sizeWithFont:contentFont maxSize:maxSize];
    CGFloat textX =  AIJokePadding;
    CGFloat textY = CGRectGetMaxY(_iconFrame) + AIJokePadding;
    
    self.textFrame = (CGRect){textX,textY,textSize};
    
    //自己的frame
    CGFloat X = 0;
    CGFloat Y = AIJokeCellMargin;
    CGFloat W = Mainsize.width;
    CGFloat H = CGRectGetMaxY(_textFrame);
    self.frame = CGRectMake(X, Y, W, H);
   
}
@end
