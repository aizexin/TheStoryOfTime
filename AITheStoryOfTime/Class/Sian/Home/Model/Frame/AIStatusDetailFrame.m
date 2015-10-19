//
//  AIStatusDetailFrame.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusDetailFrame.h"
#import "AIStatusOriginalFrame.h"
#import "AIStatusRetweetedFrame.h"
#import "AIStatusesModel.h"
#import "AIDefine.h"
@implementation AIStatusDetailFrame


-(void)setStatusesModel:(AIStatusesModel *)statusesModel{
    _statusesModel = statusesModel;
    AIStatusOriginalFrame *originalFrame = [[AIStatusOriginalFrame alloc]init];
    originalFrame.status = statusesModel;
    self.originalFrame = originalFrame;
    
    CGFloat h = 0;
    if (statusesModel.retweeted_status) {
        AIStatusRetweetedFrame *retweetedFrame = [[AIStatusRetweetedFrame alloc]init];
        retweetedFrame.retweetedStatus = statusesModel.retweeted_status;
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        self.retweetedFrame = retweetedFrame;
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else {
        h = CGRectGetMaxY(originalFrame.frame);
    }

    //自己的frame
    CGFloat x = 0;
    CGFloat y = AIStatusCellMargin;
    CGFloat w = Mainsize.width;
    self.frame = CGRectMake(x, y, w, h);
}


@end
