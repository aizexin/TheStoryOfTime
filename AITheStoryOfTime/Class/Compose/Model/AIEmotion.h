//
//  AIEmotion.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
