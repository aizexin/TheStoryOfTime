//
//  AIEmotion.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotion.h"
#import "NSString+Emoji.h"

@implementation AIEmotion
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    if (code ==nil) {
        return;
    }
    self.emoji = [NSString emojiWithStringCode:code];
}
/**
 *  当从文件中解析出来一个对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
        self.directory = [decoder decodeObjectForKey:@"directory"];
    }
    return self;
}
/**
 *  讲对象写入文件的时候调用
 * 在这个方法中写秦楚：要存储那些对象的属性，以及怎样存储
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.directory forKey:@"directory"];
    
}

- (BOOL)isEqual:(AIEmotion*)otherEmotion
{
    if (self.code) { // emoji表情
        AILog(@"%@--isEqual--%@", self.code, otherEmotion.code);
        return [self.code isEqualToString:otherEmotion.code];
    } else { // 图片表情
        AILog(@"%@--isEqual--%@", self.chs, otherEmotion.chs);
        return [self.png isEqualToString:otherEmotion.png] && [self.chs isEqualToString:otherEmotion.chs];
    }
}


@end
