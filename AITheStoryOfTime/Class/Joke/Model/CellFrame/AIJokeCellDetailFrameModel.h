//
//  AIJokeCellDetailFrameModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AIJokeGroupModel;

@interface AIJokeCellDetailFrameModel : NSObject
/**头像frame*/
@property(nonatomic,assign)CGRect iconFrame;
/**昵称frame*/
@property(nonatomic,assign)CGRect nameFrame;
/**笑话frame*/
@property(nonatomic,assign)CGRect textFrame;
/**工具栏frame*/
@property(nonatomic,assign)CGRect toolbarFrame;
/**详细模型自己的frame*/
@property(nonatomic,assign)CGRect frame;

/**
 *  joke的数据模型
 */
@property(nonatomic,strong)AIJokeGroupModel *data;
@end
