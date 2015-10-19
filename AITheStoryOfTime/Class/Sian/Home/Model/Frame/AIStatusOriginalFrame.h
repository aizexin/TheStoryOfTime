//
//  AIStatusOriginalFrame.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AIStatusesModel,AIStatusPhotosFrame;
@interface AIStatusOriginalFrame : NSObject
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
///** 来源 */
//@property (nonatomic, assign) CGRect sourceFrame;
///** 时间 */
//@property (nonatomic, assign) CGRect timeFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** vip图片 */
@property (nonatomic, assign) CGRect vipFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;
/**微博相册的frame*/
@property(nonatomic,assign)CGRect photosFrame;
/** 微博数据 */
@property (nonatomic, strong) AIStatusesModel *status;


@end
