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
#define Die_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"die"]
@implementation AIDateTool
/**
 *  存储时间到沙盒
 *
 *  @param selDate 选中的生日
 */
+(void)save:(UUDatePicker_DateModel*)selDate die:(BOOL)die{
    //归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selDate];
    if (die) {
        
        [data writeToFile:Die_PATH atomically:YES];
    }else{
        [data writeToFile:Birth_PATH atomically:YES];
    }
}
/**
 *  从沙盒中取出时间
 *
 *  @return 取出的来的时间模型
 */
+(UUDatePicker_DateModel*)dateBirth{

    UUDatePicker_DateModel *birth =  [NSKeyedUnarchiver unarchiveObjectWithFile:Birth_PATH];
    return birth;
}

/**存在多久了 */
+(NSDateComponents*)existToday{
    NSDate *date = [self getBrithDate];
    NSDateComponents *componets = [date deltaWithNow];
    return componets;
}
/**
 *  得到出生到现在一共多少秒
 */
+(double)brith2NowAllSeconds{
    NSDate *brithDate = [self getBrithDate];
    NSDate *nowDate = [NSDate date];
    return  [nowDate secondsFrom:brithDate];
}
/**
 *  出身到死一共多少秒
 */
+(double)brith2EndAllSeconds{
    NSDate *brithDate = [self getBrithDate];
    NSDate *endDate = [self getDieDate];
    return [endDate secondsFrom:brithDate];
}
/**
 *  得到出生的date
 */
+(NSDate*)getBrithDate{
    UUDatePicker_DateModel *birthModel = [AIDateTool dateBirth];
    if (!birthModel) { //如果没有存储生日就从当前日期开始
        return [NSDate date];
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //HH为24小时制
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *birth = [NSString stringWithFormat:@"%@%@%@%@%@",birthModel.year,birthModel.month,birthModel.day,birthModel.hour,birthModel.minute];
    NSDate *date = [inputFormatter dateFromString:birth];
    return date;
}
/**
 *  得到死亡时间
 */
+(NSDate*)getDieDate{
    UUDatePicker_DateModel *dieModel = [AIDateTool dateDie];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //HH为24小时制
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *die = [NSString stringWithFormat:@"%@%@%@%@%@",dieModel.year,dieModel.month,dieModel.day,dieModel.hour,dieModel.minute];
    NSDate *date = [inputFormatter dateFromString:die];
    return date;
}
/**
 *  从沙盒中取出时间  死亡
 *
 *  @return 取出的来的时间模型
 */
+(UUDatePicker_DateModel*)dateDie{
    UUDatePicker_DateModel *die =  [NSKeyedUnarchiver unarchiveObjectWithFile:Die_PATH];
    return die;
}

@end
