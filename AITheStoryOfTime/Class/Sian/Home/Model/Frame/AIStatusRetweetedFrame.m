//
//  AIStatusRetweetedFrame.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusRetweetedFrame.h"
#import "AIStatusesModel.h"
#import "AIUserModel.h"
#import "AIDefine.h"
#import "AIStatusPhotosView.h"

@implementation AIStatusRetweetedFrame


-(void)setRetweetedStatus:(AIStatusesModel *)retweetedStatus{
    _retweetedStatus = retweetedStatus;
//    AILog(@"%@",retweetedStatus);
    // 1.昵称
    CGFloat nameX = AIStatusCellInset;
    CGFloat nameY = AIStatusCellInset;
    NSString *name = [NSString stringWithFormat:@"@%@",retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:AIStatusRetweetedNameFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + AIStatusCellInset * 0.5;
    CGFloat maxW = Mainsize.width - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:AIStatusRetweetedTextFont maxSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};


    //6.相册
    if (self.retweetedStatus.pic_urls.count != 0) {
        CGFloat photosX = nameX;
        CGFloat photosY =  CGRectGetMaxY(self.textFrame) + AIStatusCellInset * 0.5;
        CGSize photoSize = [AIStatusPhotosView sizeWithPhotosCount:self.retweetedStatus.pic_urls.count];
        self.retweetedPhotosFrame = (CGRect){{photosX,photosY},photoSize};
    }else{
        self.retweetedPhotosFrame = CGRectZero;
    }
    
    //7.自己
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = Mainsize.width;
    CGFloat H = 0;
    if (retweetedStatus.pic_urls.count == 0) {
        H = CGRectGetMaxY(self.textFrame);
    }else{
        H = CGRectGetMaxY(self.retweetedPhotosFrame);
    }
    self.frame = CGRectMake(X, Y, W, H);
}

@end
