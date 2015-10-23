//
//  AIEverydayLineVIew.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/23.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AILineTypeEyes,  //眼睛线
    AILineTypeMouth,  //嘴线
    AILineTypeNose    //鼻子线
}AILineType;

@interface AIEverydayLineView : UIView

@property(nonatomic,assign)AILineType type;

-(instancetype)initWithType:(AILineType)type;

/**
 *  得到showline在俯视图
 */
-(NSString*)showLineRectInImageView;
@end
