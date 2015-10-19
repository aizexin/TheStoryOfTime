//
//  AIPhoto.m
//  AISian
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIPhoto.h"

@implementation AIPhoto


-(void)setThumbnail_pic:(NSString *)thumbnail_pic{
    _thumbnail_pic = [thumbnail_pic copy];
    self.bmiddle_pic = [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
