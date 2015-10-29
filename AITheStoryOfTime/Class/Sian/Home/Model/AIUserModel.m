//
//  AIUserModel.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIUserModel.h"

//#import "UIImage+WebP.h"
@implementation AIUserModel

-(BOOL)isVip{
    return self.mbtype > 2;
}

@end
