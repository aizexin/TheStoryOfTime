//
//  AIJokeToolbar.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIJokeGroupModel;
@interface AIJokeToolbar : UIImageView
/**
 *  段子内容数据
 */
@property(nonatomic,strong)AIJokeGroupModel *groupModel;
@end
