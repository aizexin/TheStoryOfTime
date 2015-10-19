//
//  AIHomeStatusesResultModel.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/12.
//  Copyright © 2015年 aizexin. All rights reserved.
//  微博返回结果模型

#import "AIHomeStatusesResultModel.h"
#import "MJExtension.h"
#import "AIStatusesModel.h"
@implementation AIHomeStatusesResultModel

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [AIStatusesModel class]};
}
@end
