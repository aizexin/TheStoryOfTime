//
//  AIStatusDetailFrame.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AIStatusOriginalFrame,AIStatusRetweetedFrame,AIStatusesModel;
@interface AIStatusDetailFrame : NSObject
/**
 *  原创微博frame
 */
@property(nonatomic,strong)AIStatusOriginalFrame *originalFrame;
/**
 *  转发微博frame
 */
@property(nonatomic,strong)AIStatusRetweetedFrame *retweetedFrame;
/**
 *  微博数据模型
 */
@property(nonatomic,strong)AIStatusesModel *statusesModel;
/**
 *  自己的frame
 */
@property(nonatomic,assign)CGRect frame;

@end
