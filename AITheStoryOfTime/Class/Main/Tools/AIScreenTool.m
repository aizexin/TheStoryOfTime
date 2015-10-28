//
//  AIScreenTool.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/25.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIScreenTool.h"
#import "SCCommon.h"
@implementation AIScreenTool

+(UIImage*)screenWithSize:(CGSize)size inView:(UIView *)view{
    // 1.创建一个bitmap的上下文
    UIGraphicsBeginImageContext(size);
    
    
    // 2.将屏幕绘制到上下文中
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//     [SCCommon saveImageToPhotoAlbum:newImage];//存至本机
    return newImage;
}
@end
