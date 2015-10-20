//
//  AIStatusToolbar.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusToolbar.h"

@implementation AIStatusToolbar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];

    }
    return self;
}
@end
