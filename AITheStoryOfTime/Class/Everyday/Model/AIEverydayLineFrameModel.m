//
//  AIBaseLineFrameModel.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayLineFrameModel.h"

@implementation AIEverydayLineFrameModel

/**
 *  接档
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    self.eyesFrameStr = [aDecoder decodeObjectForKey:@"eyesFrameStr"];
    self.mouthFrameStr = [aDecoder decodeObjectForKey:@"mouthFrameStr"];
    self.noseFrameStr = [aDecoder decodeObjectForKey:@"noseFrameStr"];
    return self;
}

/**
 *  归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.eyesFrameStr forKey:@"eyesFrameStr"];
    [aCoder encodeObject:self.mouthFrameStr forKey:@"mouthFrameStr"];
    [aCoder encodeObject:self.noseFrameStr forKey:@"noseFrameStr"];
}

@end
