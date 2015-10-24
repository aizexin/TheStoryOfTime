//
//  AIDefine.h
//  AIweichat
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#ifndef AIweichat_AIDefine_h
#define AIweichat_AIDefine_h

#import "UIImage+Extension.h"
#import "NSString+Extension.h"

//导航栏高度
#define AINavgationBarH 65

#define Mainsize ([[UIScreen mainScreen]bounds].size)
#define AIViewSize (self.view.frame.size)
// 颜色
#define AIColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define AIRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 是否为iOS9
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
// 导航栏标题的字体
#define AINavigationTitleFont [UIFont boldSystemFontOfSize:20]
//tabBarItem字体大小
#define AITabBarItemFont [UIFont systemFontOfSize:13]
// 是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)
#endif

#ifdef DEBUG//调试阶段的log
#define AILog(...) NSLog(__VA_ARGS__)
#else
#define AILog(...)
#endif
//应用信息
#define AIAppKey @"2715650149"
#define AIAppSecrect @"afdbfd1bf69c792038ebe9abd56011f5"
#define AIAppRediectURI @"http://www.baidu.com"


// cell的计算参数
// cell之间的间距
#define AIStatusCellMargin 10
// cell的内边距
#define AIStatusCellInset 10
// 原创微博昵称字体
#define AIStatusOrginalNameFont [UIFont systemFontOfSize:14]
// 原创微博时间字体
#define AIStatusOrginalTimeFont [UIFont systemFontOfSize:12]
// 原创微博来源字体
#define AIStatusOrginalSourceFont AIStatusOrginalTimeFont
// 原创微博正文字体
#define AIStatusOrginalTextFont [UIFont systemFontOfSize:15]

// 转发微博昵称字体
#define AIStatusRetweetedNameFont AIStatusOrginalNameFont
// 转发微博正文字体
#define AIStatusRetweetedTextFont AIStatusOrginalTextFont



//微博键盘相关
/**
 * 发微博表情键盘的toolbar文字字体
 */
#define AIComposeToolbarFont [UIFont systemFontOfSize:13]

//表情最大行数
#define AIEmotionMaxRows 3
//表情最大列数
#define AIEmotionMaxCols 7
//每页最多显示多少个表情
#define AIEmotionMaxCountPerPage (AIEmotionMaxRows * AIEmotionMaxCols -1)

//通知
//表情选中的通知
#define AIEmotionDidSeletedNotification @"AIEmotionDidSeletedNotification"

//点击删除按钮的通知
#define AIEmotionDidDeletedNotification @"AIEmotionDidDeletedNotification"

//通知里面用来取出表情用的key
#define AISelectedEmotion  @"AISelectedEmotion"

//-------------------------------Birth相关--------------------------
#define AIBirthShowScale (280.0/320)
#define kMenuDisplayedWidth Mainsize.width *(280.0/320)


//Birth模块相关的
//一年有多少秒
#define AIAllSecondOfYear 31536000
//做爱频率
#define AIMakeLove 864000
//吃饭频率
#define AIEAT 28800
//周末频率
#define AIWeek 604800
//长假频率
#define AILongHoliday 2592000


//-----------------------------------分享相关--------------------------
#import "UMSocial.h"
//友盟key
#define AIUMAPPKEY @"5626764f67e58ee7aa0025e9"
//微信
#define AIWeChatAPPID @"wx47a6979c287472bb"
#define AIWeChatAPPSecret @"afcbcebc9a1aa9fdd82855780aafd9c3"

//腾讯
#define AIQQAPPID @"1104912742"
#define AIQQAPPSecret @"SlT0CtA8VPxoA1NZ"

//----------------------Everyday相关---------------
#define AIEverydayToolBarHeight 44
//定位先的宽度
#define AIEverydayBaseLineWith 2


//-----------------------地图相关---------------------
#import "AIMapDefine.h"



