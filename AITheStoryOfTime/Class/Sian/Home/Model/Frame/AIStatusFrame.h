//
//  AIStatusFrame.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AIStatusDetailFrame,AIStatusesModel;
@interface AIStatusFrame : NSObject
/**
 *  微博内容frame
 */
@property(nonatomic,strong)AIStatusDetailFrame *detailFrame;
/**
 *  微博工具栏frame
 */
@property(nonatomic,assign)CGRect toolbarFrame;
/**Cell高度*/
@property(nonatomic,assign)CGFloat cellHeight;
/**
 *  微博内容模型
 */
@property(nonatomic,strong)AIStatusesModel *statusesModel;

@end
