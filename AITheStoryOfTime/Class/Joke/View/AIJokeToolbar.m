//
//  AIJokeToolbar.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIJokeToolbar.h"
#import "AIFixScreen.h"
#import "AIJokeGroupModel.h"
#import "AIJokeDefine.h"
@interface AIJokeToolbar ()

/**
 *  踩
 */
@property(nonatomic,strong)UIButton *buryButton;
/**
 *  喜欢
 */
@property(nonatomic,strong)UIButton *favoriteButton;
/**
 *  分享按钮
 */
@property(nonatomic,strong)UIButton *shareButton;
@end

@implementation AIJokeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //设置背景图片
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        //喜欢
        UIButton *favoriteButton = [[UIButton alloc]init];
        [favoriteButton setImage:[UIImage imageNamed:@"digupicon_textpage"] forState:(UIControlStateNormal)];
        [favoriteButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.favoriteButton = favoriteButton;
        [self addSubview:favoriteButton];
        
        //踩
        UIButton *buryButton = [[UIButton alloc]init];
        [buryButton setImage:[UIImage imageNamed:@"digdownicon_textpage"] forState:(UIControlStateNormal)];
        [buryButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.buryButton = buryButton;
        [self addSubview:buryButton];
        
        //分享按钮
        UIButton *shareButton = [[UIButton alloc]init];
        self.shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:shareButton];
        [shareButton setImage:[UIImage imageNamed:@"repost_btn_night"] forState:(UIControlStateNormal)];
        [shareButton setImage:[UIImage imageNamed:@"repost_btn_press"] forState:(UIControlStateHighlighted)];
        self.shareButton = shareButton;
        [shareButton addTarget:self action:@selector(onClickShareBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        //屏幕适配
        [self fitScreen];
    }
    return self;
}
-(void)fitScreen{
    //喜欢
    [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@30);
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
//        make.width.mas_equalTo(@1);
    }];
    //踩
    [self.buryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.favoriteButton.mas_right).offset = 0;
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.width.mas_equalTo(@100);
    }];
    //分享
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.left.mas_equalTo(self.buryButton.mas_right).offset = 0;
        make.right.mas_equalTo(@(-30));
    }];
}

-(void)setGroupModel:(AIJokeGroupModel *)groupModel{
    _groupModel = groupModel;
    AILog(@"favorite_count--%@",groupModel.favorite_count);
//    if (groupModel.favorite_count.length>0) {
    
        [self.favoriteButton setTitle:[NSString stringWithFormat:@"%ld",[groupModel.favorite_count integerValue] ] forState:(UIControlStateNormal)];
//    }
//    if (groupModel.bury_count.length>0) {
    
        [self.buryButton setTitle:[NSString stringWithFormat:@"%ld",[groupModel.bury_count integerValue] ] forState:(UIControlStateNormal)];
//    }
}

#pragma mark -------------------点击事件---------
-(void)onClickShareBtn:(UIButton*)shareBtn{
    NSDictionary *dict = @{@"jokeContent":self.groupModel.content};
    [[NSNotificationCenter defaultCenter]postNotificationName:AIJokeShareEventNotification object:nil userInfo:dict];
}


@end
