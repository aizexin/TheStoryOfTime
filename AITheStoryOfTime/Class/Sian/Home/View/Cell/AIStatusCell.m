//
//  AIStatusCell.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusCell.h"
#import "AIStatusDetailView.h"
#import "AIStatusToolbar.h"
#import "AIStatusFrame.h"

@interface AIStatusCell ()

@end
@implementation AIStatusCell
+(instancetype)statusCell:(UITableView*)tableView{
    static NSString *identifier = @"cell";
    
    AIStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (!cell) {
        cell = [[AIStatusCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         AIStatusDetailView *detailView = [[AIStatusDetailView alloc]init];
        self.statusDetailView = detailView;
        [self.contentView addSubview:detailView];
        AIStatusToolbar *toolbar = [[AIStatusToolbar alloc]init];
        self.toolbar = toolbar;
        [self.contentView addSubview:toolbar];
    }
    return self;
}

-(void)setStatusFrame:(AIStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //详细内容
    self.statusDetailView.detailFrame = statusFrame.detailFrame;
    //工具栏
    self.toolbar.frame = statusFrame.toolbarFrame;
}

@end
