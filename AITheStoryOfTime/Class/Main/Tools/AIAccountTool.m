//
//  AIAccountTool.m
//  AISian
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIAccountTool.h"
#import "AIAccountModel.h"
#define PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account"]

@implementation AIAccountTool

+(void)save:(AIAccountModel*)account{
    //归档
    [NSKeyedArchiver archiveRootObject:account toFile:PATH];
}

+(AIAccountModel *)account{
    //接档
    AIAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH];
    
//  判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_in_time] == NSOrderedAscending) {
        account = nil;
    }
    return account;
}

@end
