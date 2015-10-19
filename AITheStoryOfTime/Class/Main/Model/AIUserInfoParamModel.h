//
//  AIUserInfoParamModel.h
//  AISian
//
//  Created by 艾泽鑫 on 15/10/13.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIUserInfoParamModel : NSObject
/**false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property(nonatomic,copy)NSString *access_token;
/**false	int64	需要查询的用户ID。*/
@property(nonatomic,copy)NSString *uid;
@end
