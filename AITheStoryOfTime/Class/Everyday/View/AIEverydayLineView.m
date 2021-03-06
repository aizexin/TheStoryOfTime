//
//  AIEverydayLineVIew.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayLineView.h"
#import "AIEverydayDefine.h"



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
        self.showLineView.backgroundColor = AIEverydayLineColor;
        [self addSubview:showLineView];
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
    CGRect rect =(CGRect)AIEverydayPhotoRect;
    CGSize superViewSize = rect.size;
    switch (type) {
        case AILineTypeEyes:{
            //眼睛
            self.frame = CGRectMake(0, 100, superViewSize.width, AILineBgWith);
            self.showLineView.frame = CGRectMake(0, AIShowLineX, superViewSize.width, AIEverydayBaseLineWith);
            break;
        }
        case AILineTypeMouth:{
            //嘴巴
            self.frame = CGRectMake(0, 200, superViewSize.width, AILineBgWith);
            self.showLineView.frame = CGRectMake(0, AIShowLineX, superViewSize.width, AIEverydayBaseLineWith);
            break;
        }
        case AILineTypeNose:{
            //鼻子
            self.frame = CGRectMake(superViewSize.width * 0.5, 0, AILineBgWith, superViewSize.height);
            self.showLineView.frame = CGRectMake(AIShowLineX, 0, AIEverydayBaseLineWith, superViewSize.height);
            break;
        }
        default:
            break;
    }
}

/**
 *  得到showline在俯视图坐标
 */
-(NSString*)showLineRectInImageView{
    CGRect rect =[self.showLineView convertRect:self.showLineView.frame toView:self.superview];
    return NSStringFromCGRect(rect);
}

@end
