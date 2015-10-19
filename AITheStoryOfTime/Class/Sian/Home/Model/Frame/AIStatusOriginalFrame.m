//
//  AIStatusOriginalFrame.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusOriginalFrame.h"
#import "AIDefine.h"
#import "AIUserModel.h"
#import "AIStatusesModel.h"
#import "AIStatusPhotosView.h"
@implementation AIStatusOriginalFrame


-(void)setStatus:(AIStatusesModel *)status{
    
    _status = status;
    //1.设置头像
    CGFloat iconX = AIStatusCellInset;
    CGFloat iconY = AIStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2.设置昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + AIStatusCellInset;
    CGFloat nameY = iconY;
   CGSize nameSize = [status.user.name sizeWithFont:AIStatusOrginalNameFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //设置vip图标
    AIUserModel *userModel = status.user;
    if (userModel.isVip) {
        //7.vip图标
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + AIStatusCellMargin *0.5;
        CGFloat vipY = nameY;
        CGFloat vipW = nameSize.height;
        CGFloat vipH = vipW;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //这里设置时间和来源没用 ,需要时时跟新
    
    //5.正文
    CGFloat textX = AIStatusCellInset;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + AIStatusCellInset;
    CGSize textSize = [status.text sizeWithFont:AIStatusOrginalTextFont maxSize:CGSizeMake(Mainsize.width - 2*AIStatusCellInset , CGFLOAT_MAX)];
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    //6.相册
    if (self.status.pic_urls.count != 0) {
        CGFloat photosX = iconX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + AIStatusCellInset * 0.5;
        CGSize photoSize = [AIStatusPhotosView sizeWithPhotosCount:self.status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photoSize};
    }
    
    //7.自己
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = Mainsize.width;
    CGFloat H = 0;
    if (self.status.pic_urls.count == 0) {
       H = CGRectGetMaxY(self.textFrame);
    }else{
       H = CGRectGetMaxY(self.photosFrame);
    }
    self.frame = CGRectMake(X, Y, W, H);
    
}
@end
