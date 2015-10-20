//
//  AIDateTool.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/20.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UUDatePicker_DateModel;
@interface AIDateTool : NSObject
/**
 *  存储时间到沙盒
 *
 *  @param selDate 选中的生日
 */
+(void)save:(UUDatePicker_DateModel*)selDate die:(BOOL)die;
/**
 *  从沙盒中取出时间
 *
 *  @return 取出的来的时间模型
 */
+(UUDatePicker_DateModel*)dateBirth;

/**存在多久了 */
+(NSDateComponents*)existToday;
/**
 *  出生到现在一共多少秒
 */
+(double)brith2NowAllSeconds;
/**
 *  获得出生日期
 */
+(NSDate*)getBrithDate;
/**
 *  得到死亡时间
 */
+(NSDate*)getDieDate;
/**
 *  出生到死一共多少秒 */
+(double)brith2EndAllSeconds;
@end
