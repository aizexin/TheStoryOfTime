//
//  AIJokeTableViewCell.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeTableViewCell.h"
#import "AIJokeToolbar.h"
#import "AIJokeGroupModel.h"
#import "AIJokeUserModel.h"
#import "AIFixScreen.h"
#import "UIImageView+AFNetworking.h"
#define AIJokePadding 3
#define AIJokeIconW 40
#define AIJokeIconH AIJokeIconW
#define AIJokeToolbarH 30
@implementation AIJokeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //头像
        UIImageView *iconImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImageV];
        self.avatarImageV = iconImageV;
        //昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:nameLabel];
        self.userNameLabel = nameLabel;
        //内容文字
        UILabel *textLabel = [[UILabel alloc]init];
        [self.contentView addSubview:textLabel];
        self.jokeText = textLabel;
        //工具栏
        AIJokeToolbar *toolbar = [[AIJokeToolbar alloc]init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
        
        //屏幕适配
        [self fitScreen];
    }
    return self;
}
-(void)fitScreen{
    //头像
    [self.avatarImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(AIJokePadding));
        make.top.mas_equalTo(@(AIJokePadding));
        make.width.mas_equalTo(@(AIJokeIconW));
        make.height.mas_equalTo(@(AIJokeIconH));
//        make.right.mas_equalTo(self.userNameLabel.mas_left).offset = -AIJokePadding;
//        make.bottom.mas_equalTo(self.jokeText.mas_top).offset = -AIJokePadding;
    }];
    //名字
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageV.mas_right).offset = AIJokePadding;
        make.top.mas_equalTo(@(AIJokePadding));
        make.right.mas_equalTo(@(-AIJokePadding));
        make.bottom.mas_equalTo(self.jokeText.mas_top).offset = -AIJokePadding;
    }];
    //内容
    [self.jokeText mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(@(AIJokePadding));
       make.right.mas_equalTo(@(-AIJokePadding));
       make.bottom.mas_equalTo(self.toolbar.mas_top).offset = -AIJokePadding;
    }];
    //工具条
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(AIJokePadding));
        make.right.mas_equalTo(@(-AIJokePadding));
        make.height.mas_equalTo(@(AIJokeToolbarH));
    }];
}

+(instancetype)createJokeCell:(UITableView*)tabelView{
    static NSString *identifier = @"AIJokeCell";
    AIJokeTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AIJokeTableViewCell alloc]init];
    }
    return cell;
}

-(void)setData:(AIJokeGroupModel *)data{
    _data = data;
    //头像
    AIJokeUserModel *user = data.user;
    AILog(@"%@",user);
    NSURL *avatar_url = [NSURL URLWithString:data.user.avatar_url];
    [self.avatarImageV setImageWithURL:avatar_url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //名字
    self.userNameLabel.text = data.user.name;
    //笑话内容
    self.jokeText.text = data.content;
    
}

@end
