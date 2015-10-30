//
//  AIStatusDetailView.m
//  AISian
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIStatusDetailView.h"
#import "AIStatusRetweetedView.h"
#import "AIStatusOriginalView.h"
#import "AIStatusDetailFrame.h"
#import "AIDefine.h"
@interface AIStatusDetailView ()
/**
 *  转发的微博View
 */
@property(nonatomic,weak)AIStatusRetweetedView *statusRetweetedView;
/**
 *  原始微博
 */
@property(nonatomic,weak)AIStatusOriginalView *statusOrginalView;
@end
@implementation AIStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.userInteractionEnabled = YES;
        //设置背景图片
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];

        AIStatusOriginalView *originalView = [[AIStatusOriginalView alloc]init];
        self.statusOrginalView = originalView;
        [self addSubview:originalView];
        
//        AILog(@"AIStatusOriginalView%@",NSStringFromCGRect(self.statusRetweetedView.frame));
        AIStatusRetweetedView *statusRetweetedView = [[AIStatusRetweetedView alloc]init];
        
        self.statusRetweetedView = statusRetweetedView;
        [self addSubview:statusRetweetedView];
    }
    return self;
}
-(void)setDetailFrame:(AIStatusDetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    self.frame = detailFrame.frame;
    
    self.statusOrginalView.originalFrame = detailFrame.originalFrame;
    
    self.statusRetweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
