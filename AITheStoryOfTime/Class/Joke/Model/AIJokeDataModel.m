//
//  AIJokeDataModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeDataModel.h"
#import "AIJokeCellModel.h"
#import "AIJokeContentDataModel.h"
@implementation AIJokeDataModel
- (NSDictionary *)objectClassInArray
{
    return @{@"data" : [AIJokeContentDataModel class]};
}
@end
