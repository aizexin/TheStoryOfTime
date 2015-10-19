//
//  AIComposePhotosView.m
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIComposePhotosView.h"
#import "AIDefine.h"
#import "UIView+Extension.h"
#define MaxColsPerRow 4
#define Margin 10
@implementation AIComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[UIColor yellowColor]];
    }
    return self;
}
/**
 *  添加一张图片
 *
 *  @param image 添加的图片
 */
-(void)addImage:(UIImage*)image{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = image;
    [imageV setContentMode:(UIViewContentModeScaleAspectFit)];
    [self addSubview:imageV];
    //添加数组中
    [self.photos addObject:image];
}

-(void)layoutSubviews{
    int count = (int)self.subviews.count;
    CGFloat imageW = (self.width - ((MaxColsPerRow+1) * Margin)) / MaxColsPerRow;
    CGFloat imageH = imageW;
    for (int i = 0; i < count; i++) {
        int row = i / MaxColsPerRow;
        int col = i % MaxColsPerRow;
        UIImageView *imageV = self.subviews[i];
        imageV.width = imageW;
        imageV.height = imageH;
        imageV.x = col * (imageW + Margin) + Margin;
        imageV.y = row * (imageH + Margin);
    }
}

-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end
