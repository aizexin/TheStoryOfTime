//
//  AILoadMoreFooter.m
//  AISian
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AILoadMoreFooter.h"

@implementation AILoadMoreFooter

+(instancetype)footer{
    return [[[NSBundle mainBundle]loadNibNamed:@"AILoadMoreFooter" owner:nil options:nil]lastObject];
}

@end
