//
//  SCCommon.h
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-19.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCommon : NSObject


+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize;
/**
 *  滑一条线
 *
 *  @param frame       <#frame description#>
 *  @param color       线的颜色
 *  @param parentLayer 父视图的层
 */
+ (void)drawALineWithFrame:(CGRect)frame andColor:(UIColor*)color inLayer:(CALayer*)parentLayer;

+ (void)saveImageToPhotoAlbum:(UIImage*)image;

@end
