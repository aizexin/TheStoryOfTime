//
//  AIJokeCellFrameModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AIJokeCellDetailFrameModel,AIJokeGroupModel;

@interface AIJokeCellFrameModel : NSObject
/**工具栏的frame*/
@property(nonatomic,assign)CGRect toolbarFrame;

/**cell里面内容的frame*/
@property(nonatomic,strong)AIJokeCellDetailFrameModel *detailFrameModel;

/**cell的整个高度*/
@property(nonatomic,assign)CGFloat jokeCellHeight;

/**
 *  装每一个cell的数据
 */
@property(nonatomic,strong)AIJokeGroupModel *data;
@end
