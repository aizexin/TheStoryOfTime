//
//  AIComposeToolbar.h
//  AISian
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIComposeToolbar;
typedef enum {
    AIComposeToolBarTagTypeCamera, //相机
    AIComposeToolBarTagTypePicture, //相册
    AIComposeToolBarTagTypeMention, //提到@
    AIComposeToolBarTagTypeTrend, //话题
    AIComposeToolBarTagTypeEmotion //表情
}AIComposeToolBarTagType;

@protocol AIComposeToolbarDelegate <NSObject>

-(void)composeToolbar:(AIComposeToolbar*)toolbar didClick:(AIComposeToolBarTagType)type;

@end
@interface AIComposeToolbar : UIView
@property(nonatomic,weak)id<AIComposeToolbarDelegate> delegate;
/**
 *  是否显示表情按钮
 */
@property(nonatomic,assign,getter=isShowEmotion)BOOL showEmotion;

//-(void)setButtonImage:(NSString*)image buttonType:(AIComposeToolBarTagType)buttonType;




@end
