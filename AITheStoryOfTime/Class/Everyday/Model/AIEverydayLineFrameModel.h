//
//  AIBaseLineFrameModel.h
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//  图像基准线的模型

#import <Foundation/Foundation.h>


@interface AIEverydayLineFrameModel : NSObject<NSCoding>
/**眼睛基准线frame*/
@property(nonatomic,copy)NSString *eyesFrameStr;
/**嘴巴基准线frame*/
@property(nonatomic,copy)NSString *mouthFrameStr;
/**鼻子基准线frame*/
@property(nonatomic,copy)NSString *noseFrameStr;


@end
