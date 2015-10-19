//
//  AIStatusDetailView.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//  微博内容View

#import <UIKit/UIKit.h>

@class AIStatusOriginalView,AIStatusRetweetedView,AIStatusDetailFrame,AIStatusesModel;
@interface AIStatusDetailView : UIImageView

/**
 *  微博详情的frame
 */
@property(nonatomic,strong)AIStatusDetailFrame *detailFrame;

@end
