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
#import "SVProgressHUD.h"
#define AIEverydayEveryImageTime 0.2
@interface AIEverydayVideoImageView ()
@property(nonatomic,strong)NSMutableArray *allImageM;
@end

@implementation AIEverydayVideoImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [AIEverydayTool allEverydayCellModel];
        _allImageM = [NSMutableArray arrayWithCapacity:array.count];
        for (AIEverydayCellModel *model in array) {
            [_allImageM addObject:model.everydayImage];
        }
        self.image = [self.allImageM firstObject];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SignleTap:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}


//#pragma mark ------懒加载
//-(NSMutableArray *)allImageM{
//    
//    return _allImageM;
//}
-(void)SignleTap:(UITapGestureRecognizer*)tap{
    // 0. 如果正在动画，直接返回
    if ([self isAnimating]) {
        [self stopAnimating];
        return;
    };
    if (self.allImageM.count!=0) {
        self.animationImages = self.allImageM;
        self.animationDuration = self.allImageM.count*AIEverydayEveryImageTime;
        [self setAnimationRepeatCount:1];
        
        //开始动画
        [self startAnimating];
    }else{
        [SVProgressHUD showErrorWithStatus:@"还没有照片可以播放哦~"];
    }
}

@end
