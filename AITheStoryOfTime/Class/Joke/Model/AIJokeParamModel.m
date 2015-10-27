//
//  AIJokeParamModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
///**


#import "AIJokeParamModel.h"

@implementation AIJokeParamModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.os_version = [UIDevice currentDevice].systemVersion;
        self.device_type = [UIDevice currentDevice].model;
        self.screen_width = [NSString stringWithFormat:@"%ld",(NSInteger)Mainsize.width];
        
    }
    return self;
}
@end
