//
//  AIComposePhotosView.h
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIComposePhotosView : UIView

/**
 *  添加一张图片
 *
 *  @param image 添加的图片
 */
-(void)addImage:(UIImage*)image;
/**
 *  里面的图片
 */
@property(nonatomic,strong)NSMutableArray *photos;
@end
