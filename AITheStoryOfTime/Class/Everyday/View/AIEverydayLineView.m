//
//  AIEverydayLineVIew.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayLineView.h"
#define AILineBgWith 11
@interface AIEverydayLineView ()
@property(nonatomic,weak)UIView *showLineView;
@end

@implementation AIEverydayLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *showLineView = [[UIView alloc]init];
        self.showLineView = showLineView;
        self.showLineView.backgroundColor = [UIColor redColor];
        [self addSubview:showLineView];
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(instancetype)initWithType:(AILineType)type{
    self = [super init];
    _type = type;
    return self;
}

-(void)setType:(AILineType)type{
    _type = type;
//    if (type == AILineTypeHorizontal) {//水平
//        self.frame = CGRectMake(0, 5, Mainsize.width, 11);
//    }else{
//        self.frame = CGRectMake(0, 5, Mainsize.width, 11);
//    }
    switch (type) {
        case AILineTypeEyes:{
            //眼睛
            self.frame = CGRectMake(0, 100, Mainsize.width, AILineBgWith);
            self.showLineView.frame = CGRectMake(0, 5, Mainsize.width, AIEverydayBaseLineWith);
            break;
        }
        case AILineTypeMouth:{
            //嘴巴
            self.frame = CGRectMake(0, 200, Mainsize.width, AILineBgWith);
            self.showLineView.frame = CGRectMake(0, 5, Mainsize.width, AIEverydayBaseLineWith);
            break;
        }
        case AILineTypeNose:{
            //鼻子
            self.frame = CGRectMake(Mainsize.width * 0.5, 0, AILineBgWith, Mainsize.height);
            self.showLineView.frame = CGRectMake(5, 0, AIEverydayBaseLineWith, Mainsize.height);
            break;
        }
        default:
            break;
    }
}

@end
