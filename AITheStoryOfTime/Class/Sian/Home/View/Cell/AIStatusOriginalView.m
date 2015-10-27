//
//  AIStatusOrginalView.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusOriginalView.h"
#import "AIStatusesModel.h"
#import "AIStatusOriginalFrame.h"
#import "AIUserModel.h"
#import "UIImageView+AFNetworking.h"
#import "AIStatusPhotosView.h"
@interface AIStatusOriginalView ()
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textcontentLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  会员图标
 */
@property(nonatomic,weak)UIImageView *vipView;
/**微博Cell里相册 */
@property(nonatomic,weak)AIStatusPhotosView *photosView;
@end

@implementation AIStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = AIStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = AIStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textcontentLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = AIStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = AIStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        //6.会员图标
        UIImageView *vipView = [[UIImageView alloc]init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //7.添加相册
        AIStatusPhotosView *photosView = [[AIStatusPhotosView alloc]init];
        self.photosView = photosView;
        [self addSubview:photosView];
    }
    return self;
}

-(void)setOriginalFrame:(AIStatusOriginalFrame *)originalFrame{
    _originalFrame = originalFrame;
    //设置自己frame
    self.frame = originalFrame.frame;
    AIStatusesModel *statuses = originalFrame.status;
    AIUserModel *user = statuses.user;
    //头像
    NSURL *iconUrl = [NSURL URLWithString:user.profile_image_url];
    [self.iconView setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = originalFrame.iconFrame;
    //名称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        //设置vip图标
        NSString *vipRankIamge = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipRankIamge];
        self.vipView.frame = originalFrame.vipFrame;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.frame = CGRectZero;
    }
    //正文内容
//    self.textcontentLabel.text = statuses.text;
    self.textcontentLabel.attributedText = statuses.attributedText;
    self.textcontentLabel.frame = originalFrame.textFrame;
    //时间
    self.timeLabel.text = statuses.created_at;
    AILog(@"statuses.created_at---%@",statuses.created_at);
    self.timeLabel.textColor = [UIColor orangeColor];
//    self.timeLabel.frame = originalFrame.timeFrame;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + AIStatusCellInset * 0.5;
    CGSize timeSize = [self.timeLabel.text sizeWithFont:AIStatusOrginalTimeFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
#warning 重新计算frame
    //来源
    self.sourceLabel.text = statuses.source;
    //4.设置来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + AIStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self.sourceLabel.text sizeWithFont:AIStatusOrginalSourceFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    //相册
    if (statuses.pic_urls) {
        
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = statuses.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
}

@end
