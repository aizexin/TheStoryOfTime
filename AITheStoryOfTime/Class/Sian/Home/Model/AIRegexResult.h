//
//  AIRegexResult.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIRegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end
