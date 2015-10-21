//
//  AIBirthBottomView.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIBirthBottomView;
@protocol AIBirthBottomViewDelegate <NSObject>

-(void)birthBottomViewDidChange:(AIBirthBottomView*)BottomView;
-(void)birthBottomViewDidShare:(AIBirthBottomView*)BottomView;

@end
@interface AIBirthBottomView : UIView
/**
 *  判断是否是死之钟
 */
@property(nonatomic,assign,getter=isDie)BOOL die;

@property(nonatomic,weak)id<AIBirthBottomViewDelegate> delegate;

-(void)startChange;
-(void)stopChange;
@end
