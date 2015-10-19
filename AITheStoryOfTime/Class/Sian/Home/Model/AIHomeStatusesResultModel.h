//
//  AIHomeStatusesResultModel.h
//  AISian
//
//  Created by 艾泽鑫 on 15/10/12.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIHomeStatusesResultModel : NSObject
/** 微博数组（装着AIStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;
@end
