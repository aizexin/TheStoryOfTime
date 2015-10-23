//
//  AIEverydayVideoImageView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/24.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayVideoImageView.h"
#import "AIEverydayTool.h"
#import "AIEverydayCellModel.h"
@interface AIEverydayVideoImageView ()
@property(nonatomic,strong)NSMutableArray *allImageM;
@end

@implementation AIEverydayVideoImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [self.allImageM firstObject];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SignleTap:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark ------懒加载
-(NSMutableArray *)allImageM{
    if (!_allImageM) {
        NSArray *array = [AIEverydayTool allEverydayCellModel];
        _allImageM = [NSMutableArray arrayWithCapacity:array.count];
        for (AIEverydayCellModel *model in array) {
            [_allImageM addObject:model.everydayImage];
        }
    }
    return _allImageM;
}
-(void)SignleTap:(UITapGestureRecognizer*)tap{
    // 0. 如果正在动画，直接返回
    if ([self isAnimating]) {
        [self stopAnimating];
        return;
    };
    self.animationImages = self.allImageM;
    self.animationDuration = 1;
    [self setAnimationRepeatCount:1];
    
    //开始动画
    [self startAnimating];
}

@end
