//
//  AIEverydayToolbar.m
//  AITheStoryOfTime
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEverydayToolbar.h"
#import "AIFixScreen.h"
@interface AIEverydayToolbar ()
/**
 *  返回按钮
 */
@property(nonatomic,weak)UIButton *saveBtn;
/**
 *  重拍按钮
 */
@property(nonatomic,weak)UIButton *resetBtn;
/**
 *  取消按钮 --不保存
 */
@property(nonatomic,weak)UIButton *cancelBtn;
@end

@implementation AIEverydayToolbar
//[SCCommon saveImageToPhotoAlbum:stillImage];//存至本机

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.layer.cornerRadius = 8;
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        cancelBtn.backgroundColor = AIRandomColor;
        [cancelBtn addTarget:self action:@selector(onClickCancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        self.cancelBtn = cancelBtn;
        [self addSubview:cancelBtn];
        //重拍
        UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resetBtn.layer.cornerRadius = 8;
        [resetBtn setTitle:@"重拍" forState:(UIControlStateNormal)];
        [resetBtn addTarget:self action:@selector(onClickResetBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        resetBtn.backgroundColor = AIRandomColor;
        self.resetBtn = resetBtn;
        [self addSubview:resetBtn];
        //保存按钮
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.layer.cornerRadius = 8;
        saveBtn.backgroundColor = AIRandomColor;
        [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        [saveBtn addTarget:self action:@selector(onClickSaveBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        self.saveBtn = saveBtn;
        [self addSubview:saveBtn];
        
        //屏幕适配
        [self fitScreen];
    }
    return self;
}

/**
 *  屏幕适配
 */
-(void)fitScreen{
//    CGFloat btnWith = AIEverydayToolBarHeight;
    //取消
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(self.resetBtn.mas_left).offset = 0;
        make.width.mas_equalTo(@[self.resetBtn,self.saveBtn]);
    }];
    //重拍
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(self.saveBtn.mas_left).offset = 0;

    }];
    //保存
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
//        make.width.mas_equalTo(@(btnWith));
    }];
}
#pragma mark -------------点击事件--------------------------
/**
 *  取消
 */
-(void)onClickCancelBtn:(UIButton*)btn{
    if (self.cancelImage) {
        self.cancelImage();
    }
}
/**
 *  重拍
 */
-(void)onClickResetBtn:(UIButton*)btn{
    if (self.resetImage) {
        self.resetImage();
    }
}
/**
 *  保存
 */
-(void)onClickSaveBtn:(UIButton*)btn{
    if (self.saveImage) {
        self.saveImage();
    }
}

@end
