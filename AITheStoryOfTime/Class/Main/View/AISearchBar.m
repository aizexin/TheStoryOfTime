//
//  AISearchBar.m
//  AISian
//
//  Created by 艾泽鑫 on 15/9/28.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AISearchBar.h"
#import "UIView+AIExtension.h"
#import "UIImage+Extension.h"
@implementation AISearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        //设置背景
        UIImage *bgImage = [UIImage resizedImage:@"searchbar_textfield_background"];
        [self setBackground:bgImage];
        //设置文字上下居中
        [self setContentVerticalAlignment:(UIControlContentVerticalAlignmentCenter)];
        
        //设置左边放大镜
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.size = CGSizeMake(imageV.height+10, imageV.height);
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        
        //右边删除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self setLeftViewMode:(UITextFieldViewModeAlways)];
       
    }
    return self;
}

+(instancetype)searchBar{
    return [[self alloc]init];
}
@end
