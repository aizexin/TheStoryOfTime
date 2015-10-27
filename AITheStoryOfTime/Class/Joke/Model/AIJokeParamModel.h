//
//  AIJokeParamModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
// 
//@"http://ic.snssdk.com/neihan/stream/category/data/v2/?tag=joke&iid=3139869339&=9.0.2&os_api=18&app_name=joke_essay_social&channel=App%20Store&device_platform=ipad&idfa=idfa&vid=9900A444-643A-4792-BF53-5925CE7EBC2F&openudid=3beaf94e87d2b03d89c135480b3b36a78871aa27&device_type=iPad%20AIR&version_code=4.4.1&ac=WIFI&screen_width=1536&device_id=4437206054&aid=20&category_id=1&count=30&level=6&message_cursor=0&min_time=1445949969&mpic=1"
#import <Foundation/Foundation.h>

@interface AIJokeParamModel : NSObject
/**
 *  最小时间
 */
@property(nonatomic ,copy)NSString *min_time;
/** 系统版本*/
@property(nonatomic ,copy)NSString *os_version;
/** 设备类型*/
@property(nonatomic ,copy)NSString *device_type;
/** 设备屏幕宽度*/
@property(nonatomic ,copy)NSString *screen_width;
/** 设备屏幕宽度*/
@property(nonatomic ,copy)NSString *count;
@end
