//
//  AIBirthListView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/20.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIBirthListView.h"
#import "AIFixScreen.h"
#import "AIDateTool.h"
@interface AIBirthListView ()
@property(nonatomic,assign)NSInteger col;
@property(nonatomic,assign)NSInteger row;
@end

@implementation AIBirthListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setDie:(BOOL)die{
    _die = die;
    //移除以前的
    if (self.subviews.count>0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    self.row = 2;
    self.col = die?2:3;
    for (int i = 0; i< _col * _row; i++) {
        UILabel *label = [[UILabel alloc]init];
//        label.backgroundColor = AIRandomColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:label];
    }
    
//   填内容
    [self setupDate:die];
    [self setNeedsLayout];
}


-(void)layoutSubviews{
    CGFloat labelW  = self.frame.size.width / self.col;
    CGFloat labelH  = self.frame.size.height/self.row;
    CGFloat labelX  = 0;
    CGFloat labelY  = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        UILabel *label = (UILabel*)self.subviews[i];
        labelX  = (i % self.col) *labelW;
        labelY = (i/self.col) *labelH;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    }
}

/**
 *  填数据
 */
-(void)setupDate:(BOOL)die{
    NSMutableArray *messages = [NSMutableArray array];
    if (die) {//死之钟
        double nowToEndSeconds = [AIDateTool now2EndAllSeconds];
        NSInteger eatTime = nowToEndSeconds/AIEAT;
        NSString *eat = [NSString stringWithFormat:@"吃%ld顿饭",eatTime];
        [messages addObject:eat];
        //做爱
        NSInteger makeLoveTime = nowToEndSeconds/AIMakeLove;
        NSString *makeLove = [NSString stringWithFormat:@"做%ld次爱",makeLoveTime];
        [messages addObject:makeLove];
        //周末
        NSInteger weekTime = nowToEndSeconds/AIWeek;
        NSString *weeks = [NSString stringWithFormat:@"度过%ld个周末",weekTime];
        [messages addObject:weeks];
        //长假
        NSInteger longHolidayTime = nowToEndSeconds/AILongHoliday;
        NSString *longHoliday = [NSString stringWithFormat:@"享受%ld个长假",longHolidayTime];
        [messages addObject:longHoliday];
    }else{//生之时
        NSDateComponents *components = [AIDateTool existToday];
        NSString *year = [NSString stringWithFormat:@"%ld年",components.year];
        [messages addObject:year];
        NSString *months = [NSString stringWithFormat:@"%ld月",components.month];
        [messages addObject:months];
        //天
        NSString *day = [NSString stringWithFormat:@"%ld天",components.day];
        [messages addObject:day];
        //小时
        NSString *hours = [NSString stringWithFormat:@"%ld小时",components.hour];
        [messages addObject:hours];
        //分
        NSString *minute = [NSString stringWithFormat:@"%ld分",components.minute];
        [messages addObject:minute];
        //周
        NSString *second = [NSString stringWithFormat:@"%ld秒",components.second];
        [messages addObject:second];
        
    
    }
    //显示
    int index = 0;
    for (UILabel *label in self.subviews) {
        label.text = messages[index];
        index++;
    }
}

/**
 *  开始改变秒钟
 */
-(void)startChange{
    [self setupDate:self.die];
}
@end
