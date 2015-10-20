//
//  AIBirthListView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/20.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIBirthListView.h"
#import "AIFixScreen.h"
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
    NSInteger col = 0;
    NSInteger row = 2;
//    if (!die) {//生之钟
//    }
    col = die?2:3;
    for (int i = 0; i< col*row; i++) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
    }
    
//适配
    [self fixScreen];
}

-(void)fixScreen{
    
    for (int i = 0; i < self.subviews.count; i++) {
        UILabel *label = (UILabel*)self.subviews[i];
        
    }

}

@end
