//
//  AIStatusPhotoView.m
//  AISian
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusPhotoView.h"
#import "UIImageView+AFNetworking.h"
#import "AIPhoto.h"
//#import "UIView+AIExtension.h"
@interface AIStatusPhotoView ()
@property(nonatomic,weak)UIImageView *gifImageView;
@end
@implementation AIStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
   
    self = [super initWithFrame:frame];
    if (self) {
       
        [self setContentMode:(UIViewContentModeScaleAspectFill)];
        [self setClipsToBounds:YES];
        
        UIImageView *gifImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        self.gifImageView = gifImageView;
        [self addSubview:gifImageView];
    }
    return self;
}

-(void)layoutSubviews{
    CGRect rect = self.gifImageView.frame;
    rect.origin.x = Mainsize.width - _gifImageView.frame.size.width;
    rect.origin.y = Mainsize.height - _gifImageView.frame.size.height;
    self.gifImageView.frame = rect;
//    self.gifImageView.x = self.width - _gifImageView.width;
//    self.gifImageView.y = self.height - _gifImageView.height;
}

-(void)setPhoto:(AIPhoto *)photo{
    NSString *extension = photo.thumbnail_pic.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //下载图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}
@end
