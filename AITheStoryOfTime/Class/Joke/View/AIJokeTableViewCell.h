//
//  AIJokeTableViewCell.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIJokeGroupModel,AIJokeToolbar;
@interface AIJokeTableViewCell : UITableViewCell
/**
 *  用户头像
 */
@property(nonatomic,weak)UIImageView *avatarImageV;
/**
 *  用户昵称
 */
@property(nonatomic,weak)UILabel *userNameLabel;
/**
 *  笑话内容
 */
@property(nonatomic,weak)UILabel *jokeText;
/**
 *  工具栏
 */
@property(nonatomic,strong)AIJokeToolbar *toolbar;

@property(nonatomic,strong)AIJokeGroupModel *data;

+(instancetype)createJokeCell:(UITableView*)tabelView;
@end
