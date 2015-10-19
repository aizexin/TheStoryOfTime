//
//  AIAccountModel.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIAccountModel.h"

@implementation AIAccountModel
+(instancetype)accountWithDict:(NSDictionary*)dict{
    AIAccountModel *model = [[AIAccountModel alloc]init];
    model.access_token = dict[@"access_token"];
    model.expires_in = dict[@"expires_in"];
    model.uid = dict[@"uid"];
    //计算过期时间
    NSDate *now = [NSDate date];
    model.expires_in_time = [now dateByAddingTimeInterval:([model.expires_in doubleValue])];
    return model;
}
//归档时调用
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.screen_name forKey:@"screen_name"];
    
}
//解归档的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    }
    return self;
}
@end
