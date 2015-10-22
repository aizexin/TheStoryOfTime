//
//  AIEverydayToolbar.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIEverydayToolbar : UIView
/**
 *  保存图片
 */
@property(nonatomic ,copy)void(^saveImage)();
/**
 *  点击取消
 */
@property(nonatomic ,copy)void(^cancelImage)();
/**
 *  重拍
 */
@property(nonatomic ,copy)void(^resetImage)();
@end
