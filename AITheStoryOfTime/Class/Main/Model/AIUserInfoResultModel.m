//
//  AIUserInfoResultModel.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/13.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIUserInfoResultModel.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
@implementation AIUserInfoResultModel
-(void)setProfile_image_url:(NSString *)profile_image_url{
    [super setProfile_image_url:profile_image_url];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    NSURL *url = [NSURL URLWithString:profile_image_url];
    _iconImageV = [[UIImageView alloc]init];
    [_iconImageV setImageWithURL:url];
}
@end
