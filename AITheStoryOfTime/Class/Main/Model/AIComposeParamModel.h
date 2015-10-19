//
//  AIComposeParamModel.h
//  AISian
//
//  Created by 艾泽鑫 on 15/10/13.
//  Copyright © 2015年 aizexin. All rights reserved.
//发送一条没有图片微博参数模型

#import <Foundation/Foundation.h>

@interface AIComposeParamModel : NSObject
/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property(nonatomic,copy)NSString *access_token;
/**	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property(nonatomic,copy)NSString *status;
@end
