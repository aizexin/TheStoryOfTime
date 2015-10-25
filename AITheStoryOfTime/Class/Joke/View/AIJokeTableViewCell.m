//
//  AIJokeTableViewCell.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeTableViewCell.h"
#import "AIJokeDetailView.h"
#import "AIJokeCellFrameModel.h"
#import "AIJokeToolbar.h"


@implementation AIJokeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        AIJokeDetailView *detailView = [[AIJokeDetailView alloc]init];
        self.detailView = detailView;
        [self.contentView addSubview:detailView];
        
        AIJokeToolbar *toolbar = [[AIJokeToolbar alloc]init];
        self.toolbar = toolbar;
        [self.contentView addSubview:toolbar];
        
    }
    return self;
}

+(instancetype)createJokeCell:(UITableView*)tabelView{
    static NSString *identifier = @"AIJokeCell";
    AIJokeTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AIJokeTableViewCell alloc]init];
    }
    return cell;
}

-(void)setFrameData:(AIJokeCellFrameModel *)frameData{
    _frameData = frameData;
    self.detailView.frameData = frameData.detailFrameModel;
    self.toolbar.frame = frameData.toolbarFrame;
}



@end
