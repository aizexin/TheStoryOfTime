//
//  AIEmotionToolbar.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AIEmotionToolbar;

//表情工具栏上按钮总数
#define AIEmotionToolbarCount 4

typedef enum{
    AIEmotionTypeRecent, //最近
    AIEmotionTypeDefault, //默认
    AIEmotionTypeEmoji, //Emoji
    AIEmotionTypeLxh    //浪小花
}AIEmotionType;

@protocol AIEmotionToolbarDelegate <NSObject>

-(void)emotionToolbar:(AIEmotionToolbar*)toolbar didSelectedButton:(AIEmotionType)type;

@end
@interface AIEmotionToolbar : UIView

@property(nonatomic,weak)id<AIEmotionToolbarDelegate> delegate;

@end
