//
//  AILink.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AILink : NSObject
/** 链接文字*/
@property(nonatomic ,copy)NSString *text;
/** 链接范围*/
@property(nonatomic ,assign)NSRange range;
/** 链接的矩形框*/
@property(nonatomic,strong)NSArray *rects;
@end
