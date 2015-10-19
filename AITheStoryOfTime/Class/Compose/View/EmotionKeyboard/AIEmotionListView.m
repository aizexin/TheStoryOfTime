//
//  AIEmotionListView.m
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/17.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIEmotionListView.h"
#import "AIEmotionGridView.h"
//#import "UIView+Extension.h"

@interface AIEmotionListView ()<UIScrollViewDelegate>
@property(weak,nonatomic)UIScrollView *scrollView;
@property(weak,nonatomic)UIPageControl *pageControl;
@end
@implementation AIEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        //隐藏滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView = scrollView;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        //pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //1pageControl的frame
//    self.pageControl.width = Mainsize.width;
//    self.pageControl.height = 30;
//    self.pageControl.y = self.height - self.pageControl.height;
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 30, Mainsize.width, 30);
    //2scrollView的frame
//    self.scrollView.width = Mainsize.width;
//    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.frame = CGRectMake(0, 0, Mainsize.width, self.frame.size.height - self.pageControl.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    //3设置gridView的frame
    
    CGFloat gridW = self.scrollView.frame.size.width;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        AIEmotionGridView *gridView = (AIEmotionGridView*)self.scrollView.subviews[i];
        gridView.frame = CGRectMake(i * gridW, 0, gridW, self.scrollView.frame.size.height);
//        gridView.width = self.scrollView.width;
//        gridView.height = self.scrollView.height;
//        gridView.x = i * gridView.width;
    }

    
}

/**
 *  这里要分割数组
 */
-(void)setEmotions:(NSArray *)emotions{
    
    _emotions = emotions;
    //设置总页数
    NSInteger totalPage = (emotions.count + AIEmotionMaxCountPerPage - 1)/AIEmotionMaxCountPerPage;
    //当前有多少页
    NSInteger currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPage;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = totalPage <= 1;

//    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < totalPage; i++) {
        AIEmotionGridView *gridview = nil;
        if (i >= currentGridViewCount) {//说明emotionGridVIew的个数不够
            gridview = [[AIEmotionGridView alloc]init];
            
            [self.scrollView addSubview:gridview];
        }else{
            gridview = self.scrollView.subviews[i];
        }
        //数组中起始位置
        int loc = i * AIEmotionMaxCountPerPage;
        int len = AIEmotionMaxCountPerPage;
        
        if (loc +len >emotions.count) {//对越界进行判断 (表情个数小于一页的最大个数)
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridview.emotions = gridViewEmotions;
//        [self.scrollView  addSubview:gridview];
        gridview.hidden = NO;
    }
    //隐藏后面不需要用到的gridView
    
    for (int i = totalPage; i < currentGridViewCount; i++) {
        AIEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }

    
    //重新布局子控件
    [self setNeedsLayout];
    
    //表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
  
}
#pragma mark 代理方法
#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)((scrollView.contentOffset.x/scrollView.frame.size.width)+0.5);
}

@end
