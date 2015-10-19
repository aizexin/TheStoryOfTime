//
//  AIEmotionKeyboard.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotionKeyboard.h"
#import "AIEmotionListView.h"
#import "AIEmotionToolbar.h"
#import "AIEmotionTool.h"
#import "UIView+Extension.h"
//#import "AIEmotion.h"
//#import "MJExtension.h"
@interface AIEmotionKeyboard ()
@property(nonatomic,weak)UIView *toolbar;
@property(nonatomic,weak)AIEmotionListView *listView;


@end

@implementation AIEmotionKeyboard

#pragma mark 初始化方法


+(instancetype)keyboard{    
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        AIEmotionListView *listView = [[AIEmotionListView alloc]init];
        self.listView = listView;
        [self addSubview:listView];
        //添加工具条
        AIEmotionToolbar *toolbar = [[AIEmotionToolbar alloc]init];
        toolbar.delegate = self;
        self.toolbar = toolbar;
        
        [self addSubview:toolbar];

    }
    return self;
}

-(void)layoutSubviews{
    //工具条位置
    self.toolbar.width = Mainsize.width;
    self.toolbar.height = 35;
    
    //listView位置
    self.listView.width = Mainsize.width;
    self.listView.height = self.height - self.toolbar.height;
    
    self.toolbar.y = self.listView.height;

}


#pragma mark 代理方法
#pragma mark -AIEmotionToolbarDelegate
-(void)emotionToolbar:(AIEmotionToolbar *)toolbar didSelectedButton:(AIEmotionType)type{
    switch (type) {
        case AIEmotionTypeRecent:   //最近
            self.listView.emotions = [AIEmotionTool recentEmotions];
            break;
        case AIEmotionTypeDefault:  //默认
            self.listView.emotions = [AIEmotionTool defaultEmotions];//self.defaultEmotions;
            break;
        case AIEmotionTypeEmoji:    //emoji
            self.listView.emotions = [AIEmotionTool emojiEmotions];//self.emojiEmotions;
            break;
        case AIEmotionTypeLxh:      //浪小花
            self.listView.emotions = [AIEmotionTool lxhEmotions];//self.lxhEmotions;
            break;
        default:
            break;
    }
}



@end
