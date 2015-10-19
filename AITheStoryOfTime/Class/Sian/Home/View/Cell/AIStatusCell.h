//
//  AIStatusCell.h
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIStatusDetailView,AIStatusToolbar,AIStatusFrame;
@interface AIStatusCell : UITableViewCell
/**
 *   微博详情view
 */
@property(nonatomic,strong)AIStatusDetailView *statusDetailView ;
/**
 *  微博下边的工具栏
 */
@property(nonatomic,strong)AIStatusToolbar *toolbar;
/**
 *  微博的frame
 */
@property(nonatomic,strong)AIStatusFrame *statusFrame;

+(instancetype)statusCell:(UITableView*)tableView;
@end
