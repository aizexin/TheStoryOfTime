//
//  AIJokeTableViewCell.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIJokeCellFrameModel,AIJokeDetailView,AIJokeToolbar;
@interface AIJokeTableViewCell : UITableViewCell

/**里面装Cell内容*/
@property(nonatomic,strong)AIJokeDetailView *detailView;
/**工具栏*/
@property(nonatomic,strong)AIJokeToolbar *toolbar;

/**joke的frame*/
@property(nonatomic,strong)AIJokeCellFrameModel *frameData;

+(instancetype)createJokeCell:(UITableView*)tabelView;
@end
