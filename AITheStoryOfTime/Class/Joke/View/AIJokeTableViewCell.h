//
//  AIJokeTableViewCell.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIJokeCellModel;
@interface AIJokeTableViewCell : UITableViewCell
#warning 准备搭建UI
/**
 *  用户头像
 */
@property(nonatomic,weak)UIImageView *avatarImage;
@property(nonatomic,strong)AIJokeCellModel *data;

+(instancetype)createJokeCell:(UITableView*)tabelView;
@end
