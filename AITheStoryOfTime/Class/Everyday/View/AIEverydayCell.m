//
//  AIEverydayCell.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayCell.h"
#import "AIEverydayCellModel.h"

@implementation AIEverydayCell


-(void)setModel:(AIEverydayCellModel *)model{
    _model = model;
    self.cellImage.image = model.everydayImage;
    self.timeLabel.text = model.time;
}
- (IBAction)onClickDelete:(UIButton *)sender {
    AILog(@"onClickDelete");
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}


@end
