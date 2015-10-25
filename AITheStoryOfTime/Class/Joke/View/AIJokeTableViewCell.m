//
//  AIJokeTableViewCell.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeTableViewCell.h"

@implementation AIJokeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)createJokeCell:(UITableView*)tabelView{
    static NSString *identifier = @"AIJokeCell";
    AIJokeTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AIJokeTableViewCell alloc]init];
    }
    return cell;
}

@end
