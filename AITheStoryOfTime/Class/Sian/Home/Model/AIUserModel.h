//
//  AIUserModel.h
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIUserModel : NSObject
@property(nonatomic ,copy)NSString *idstr;
/**
 *  向好友显示的名称
 */
@property(nonatomic ,copy)NSString *name;
/**
 *  头像缩略图
 */
@property(nonatomic ,copy)NSString *profile_image_url;

//mbtype = 12,
//mbrank = 5,
/**
 *  是否会员
 */
@property(nonatomic,assign)int mbtype;
/**
 *  会员等级
 */
@property(nonatomic,assign)int mbrank;

/**
 *  判断是否会员
 */
@property(nonatomic,assign,getter=isVip,readonly)BOOL vip;
@end
