//
//  AIJokeUserModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeUserModel.h"
#import "UIImageView+WebCache.h"
@implementation AIJokeUserModel
-(void)setAvatar_url:(NSString *)avatar_url{
    _avatar_url = avatar_url;
    NSURL *url = [NSURL URLWithString:_avatar_url];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picture_empty"]];
    _iconImage = imageView.image;
}
@end
