//
//  AIStatusPhotosView.m
//  AISian
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusPhotosView.h"
#import "AIStatusPhotoView.h"
#import "MJPhotoBrowser.h"
#import "UIView+AIExtension.h"
#import "MJPhoto.h"
#import "AIPhoto.h"
#define AIStatusPhotoW 70
#define AIStatusPhotoH AIStatusPhotoW
#define AIStatusPhotoMargin 10
#define AIStatusPhotosMaxCount 9
#define AIStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
@implementation AIStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //预先添加9个控件
        for (int i = 0; i < AIStatusPhotosMaxCount; i++) {
            AIStatusPhotoView *imageView = [[AIStatusPhotoView alloc]init];
            [self addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i + 100;
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [imageView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

-(void)tapPhoto:(UITapGestureRecognizer*)tap{
    //1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    //2.设置图片浏览器中所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = self.pic_urls.count;
    
    for (int i = 0; i < count; i++) {
        AIPhoto *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc]init];
        //设置图片路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        //设置来源于哪一个uiimageview
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
        
    }
    browser.photos = photos;
    //设置默认显示的图片索引
    browser.currentPhotoIndex = tap.view.tag-100;
    //显示图片浏览器
    [browser show];

}

-(void)layoutSubviews{
    [super layoutSubviews];

    int count = self.pic_urls.count;

    int maxCols = AIStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        AIStatusPhotoView *photoView = self.subviews[i];
        photoView.width = AIStatusPhotoW;
        photoView.height = AIStatusPhotoH;
        photoView.x = (i % maxCols) * (AIStatusPhotoW + AIStatusPhotoMargin);
        photoView.y = (i / maxCols) * (AIStatusPhotoH + AIStatusPhotoMargin);
    }
  
}
-(void)setPic_urls:(NSMutableArray *)pic_urls{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < self.subviews.count; i++) {
        AIStatusPhotoView *photoView = self.subviews[i];
        if (i < pic_urls.count) { //显示图片
            photoView.photo = pic_urls[i];
            [self.subviews[i] setHidden:NO];
        }else{//隐藏图片
            [self.subviews[i] setHidden:YES];
        }
    }
}

+(CGSize)sizeWithPhotosCount:(NSInteger)photosCount{

    
    // 一行最多几列
    int maxCols = AIStatusPhotosMaxCols(photosCount);
    //总的列数
    NSInteger totalCols = photosCount > maxCols ? photosCount :photosCount;
    
    //总的行数
    NSInteger totalRows = (photosCount + maxCols - 1)/maxCols;
    CGFloat photoW = totalCols * (AIStatusPhotoW + AIStatusPhotoMargin);
    CGFloat photoH = totalRows * (AIStatusPhotoH + AIStatusPhotoMargin);
    return CGSizeMake(photoW,photoH);
}
@end
