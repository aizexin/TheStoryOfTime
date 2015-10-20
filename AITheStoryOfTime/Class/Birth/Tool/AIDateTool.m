//
//  AIDateTool.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/20.
//  Copyright © 2015年 aizexin. All rights reserved.
//  提供存储时间，拿出时间，计算到现在的时间

#import "AIDateTool.h"
#import "UUDatePicker_DateModel.h"
#import "NSDate+MJ.h"
#import "DateTools.h"
#define Birth_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"birth"]
@implementation AIDateTool
/**
 *  存储时间到沙盒
 *
 *  @param selDate 选中的生日
 */
+(void)save:(UUDatePicker_DateModel*)selDate{
    //归档
   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selDate];
    [data writeToFile:Birth_PATH atomically:YES];
}
/**
 *  从沙盒中取出时间
 *
 *  @return 取出的来的时间模型
 */
+(UUDatePicker_DateModel*)dateBirth{
//    NSData *data = [NSData dataWithContentsOfFile:Birth_PATH options:(NSDataReadingMappedAlways) error:nil];
    UUDatePicker_DateModel *birth =  [NSKeyedUnarchiver unarchiveObjectWithFile:Birth_PATH];
    return birth;
}

/**存在多久了 */
+(NSDateComponents*)existToday{
//    UUDatePicker_DateModel *birthModel = [AIDateTool dateBirth];
//    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//    //HH为24小时制
//    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
//    
//    NSString *birth = [NSString stringWithFormat:@"%@%@%@%@%@",birthModel.year,birthModel.month,birthModel.day,birthModel.hour,birthModel.minute];
//    NSDate *date = [inputFormatter dateFromString:birth];
    NSDate *date = [self getBrithDate];
    NSDateComponents *componets = [date deltaWithNow];
    return componets;
}

+(double)allSeconds{
    NSDate *brithDate = [self getBrithDate];
    NSDate *nowDate = [NSDate date];
    return  [nowDate secondsFrom:brithDate];
}
+(NSDate*)getBrithDate{
    UUDatePicker_DateModel *birthModel = [AIDateTool dateBirth];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //HH为24小时制
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *birth = [NSString stringWithFormat:@"%@%@%@%@%@",birthModel.year,birthModel.month,birthModel.day,birthModel.hour,birthModel.minute];
    NSDate *date = [inputFormatter dateFromString:birth];
    return date;
}

@end
