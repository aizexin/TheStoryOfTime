//
//  AIJokeDetailView.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeDetailView.h"
#import "AIJokeToolbar.h"
#import "AIJokeGroupModel.h"
#import "AIJokeUserModel.h"
#import "AIFixScreen.h"
#import "AIJokeCellFrameModel.h"
#import "UIImageView+AFNetworking.h"
#import "AIJokeDefine.h"
#import "AIJokeCellDetailFrameModel.h"
@implementation AIJokeDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景图片
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        //头像
        UIImageView *iconImageV = [[UIImageView alloc]init];
        [self addSubview:iconImageV];
        self.avatarImageV = iconImageV;
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        [self addSubview:nameLabel];
        self.userNameLabel = nameLabel;
        //内容文字
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.numberOfLines = 0;
        textLabel.font = AIJokeContentTextFont;
        [self addSubview:textLabel];
        self.jokeText = textLabel;
       
    }
    return self;
}
-(void)setFrameData:(AIJokeCellDetailFrameModel *)frameData{
    _frameData = frameData;
    self.frame = frameData.frame;
    //头像
    AIJokeUserModel *user = frameData.data.user;
    AILog(@"%@",user);
    NSURL *avatar_url = [NSURL URLWithString:user.avatar_url];
    [self.avatarImageV setImageWithURL:avatar_url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.avatarImageV.frame = frameData.iconFrame;
    //名字
    self.userNameLabel.text = user.name;
    self.userNameLabel.frame = frameData.nameFrame;
    //笑话内容
    self.jokeText.text = frameData.data.content;
    self.jokeText.frame = frameData.textFrame;
}

@end
