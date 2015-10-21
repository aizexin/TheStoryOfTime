//
//  AIComposeViewController.m
//  AISian
//
//  Created by 艾泽鑫 on 15/10/3.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AIComposeViewController.h"
#import "AITextView.h"
#import "AIComposeToolbar.h"
#import "AIComposePhotosView.h"
#import "AFHTTPRequestOperationManager.h"
#import "AIAccountTool.h"
#import "AIAccountModel.h"
#import "AIStatusesTool.h"
#import "AIEmotionKeyboard.h"
#import "AIEmotion.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define Compose_Path @"https://api.weibo.com/2/statuses/update.json"//没有图片发送微博的接口
#define Compose_Path_Image @"https://upload.api.weibo.com/2/statuses/upload.json"//发送有图片的微（有且只有一张）
@interface AIComposeViewController ()<AIComposeToolbarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)AITextView *textView;

@property(nonatomic,strong)UIImagePickerController *pickerVC;
/**
 *  工具栏
 */
@property(nonatomic,strong)AIComposeToolbar *composeToolbar;
/**
 *  相册
 */
@property(nonatomic,weak)AIComposePhotosView *photosView;
/**
 *  是否在跟换键盘
 */
@property(nonatomic,assign,getter=isChangeKeyboard)BOOL changeKeyboard;
/**
 *  键盘高度
 */
@property(nonatomic,assign)CGFloat keyboardH;
/**
 *  自定义键盘
 */
@property(nonatomic,strong)AIEmotionKeyboard *emotionKeyboard;
@end

@implementation AIComposeViewController

#pragma mark -初始化方法


-(AIEmotionKeyboard *)emotionKeyboard{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [AIEmotionKeyboard keyboard];
        
//        _emotionKeyboard.width = Mainsize.width;
//        _emotionKeyboard.height = self.keyboardH;
//        _emotionKeyboard.frame = CGRectMake(0, 0, Mainsize.width, self.keyboardH);
        [_emotionKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(Mainsize.width));
            make.height.mas_equalTo(@(self.keyboardH));
        }];
        
    }
    return _emotionKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavBar];
    //设置textView
    [self setupTextView];
    //添加toolbar
    [self setupToolbar];
    //添加表情相关通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelected:) name:AIEmotionDidSeletedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidDeleted:) name:AIEmotionDidDeletedNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  添加工具栏
 */
-(void)setupToolbar{
    //添加自定义toolbar
    AIComposeToolbar *toolBar = [[AIComposeToolbar alloc]init];
    self.composeToolbar = toolBar;
    toolBar.delegate = self;
    
//    toolBar.width = self.view.width;
//    toolBar.height = 44;
//    toolBar.x = 0;
//    toolBar.y = self.view.height - toolBar.height;
//    toolBar.frame = CGRectMake(0, Mainsize.height - toolBar.frame.size.height, Mainsize.width, 44);
    [self.view addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.width.mas_equalTo(@(Mainsize.width));
        make.height.mas_equalTo(@(44));
    }];
}

/**
 *  添加AItextView
 */
-(void)setupTextView{
    AITextView *textView = [[AITextView alloc]initWithFrame:self.view.bounds];
    textView.delegate = self;
    self.textView = textView;
    textView.placeholder = @"分享新鲜事";
    textView.font = [UIFont systemFontOfSize:20];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    //添加通知监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    //相册
    AIComposePhotosView *photosView = [[AIComposePhotosView alloc]init];
    self.photosView = photosView;
//    photosView.width = textView.width;
//    photosView.height = textView.height;
//    photosView.y = 80;
    photosView.frame = CGRectMake(0, 80, textView.frame.size.width, textView.frame.size.height);
    [textView addSubview:photosView];
    
}

/**
 *  设置导航栏
 */
-(void)setupNavBar
{
    //设置取消
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(onClickCancel:)];
    //设置发送
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:(UIBarButtonItemStylePlain) target:self action:@selector(onClickSend:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark -键盘处理事件
//UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 253}},
//UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 441.5},
//UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},
//UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
//UIKeyboardAnimationDurationUserInfoKey = 0.25,
//UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 694.5},
//UIKeyboardAnimationCurveUserInfoKey = 7
-(void)keyboardShow:(NSNotification*)notif{
    
    //弹出键盘需要的时间
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //2动画
    [UIView animateWithDuration:duration animations:^{
        
        CGRect keyboardRect = [notif.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardRect.size.height;
        self.keyboardH = keyboardH;
        [self.composeToolbar setTransform:(CGAffineTransformMakeTranslation(0, -keyboardH))];
    }];
}
-(void)keyboardHidden:(NSNotification*)notif{
    if (self.isChangeKeyboard) {
        self.changeKeyboard = NO;
        return;
    }
    //键盘隐藏的需要的时间
    CGFloat duration = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.composeToolbar setTransform:CGAffineTransformIdentity];
    }];
}

#pragma mark -按钮点击事件
-(void)onClickCancel:(UIBarButtonItem*)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onClickSend:(UIBarButtonItem*)send{
    //发微博
    [self composeStatus];
}

/**
 *  发微博
 */
- (void)composeStatus{
    if (self.photosView.photos.count > 0) {
        [self composeStatusWithImage];
    }else{
        [self composeStatusWIthOutImage];
    }
    //跳回
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送有图片的微博
 */
-(void)composeStatusWithImage{
#warning 准备封装有图片的http上传文件函数
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AIAccountModel *account = [AIAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    [manager POST:Compose_Path_Image parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [self.photosView.photos firstObject];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"status.jpeg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        AILog(@"---发送请求成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        AILog(@"---发送请求失败,%@",error.description);
    }];
}
/**
 *  发送没有图片的微博
 */
-(void)composeStatusWIthOutImage{

    AIComposeParamModel *param = [[AIComposeParamModel alloc]init];
    param.access_token = [AIAccountTool account].access_token;
    param.status = self.textView.text;
    [AIStatusesTool composeStatusesWithParams:param success:^(AIComposeResultModel *resultModel) {
        AILog(@"---发送请求成功");
    } failure:^(NSError *error) {
        AILog(@"---发送请求失败,%@",error.description);
    }];
}

#pragma mark -代理方法

#pragma mark AIComposeToolbarDelegate

-(void)composeToolbar:(AIComposeToolbar *)toolbar didClick:(AIComposeToolBarTagType)type{
    switch (type) {
        case AIComposeToolBarTagTypeCamera:{
            AILog(@"点击相机");
            if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) return;
            self.pickerVC = [[UIImagePickerController alloc]init];
            _pickerVC.delegate = self;
            [self.pickerVC setSourceType:(UIImagePickerControllerSourceTypeCamera)];
            //跳转到相册
            [self presentViewController:_pickerVC animated:YES completion:nil];
        }
            
            break;
        case AIComposeToolBarTagTypePicture:{
            AILog(@"点击相册");
            if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) return;
            self.pickerVC = [[UIImagePickerController alloc]init];
            _pickerVC.delegate = self;
            [self.pickerVC setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
            //跳转到相册
            [self presentViewController:_pickerVC animated:YES completion:nil];
        }
            
            break;
        case AIComposeToolBarTagTypeEmotion:{
            AILog(@"点击表情");
            [self openEmotion];
            
        }
            
            break;
            
        default:
            break;
    }
}
/**
 *  打开表情键盘
 */
-(void)openEmotion{
    self.changeKeyboard = YES;
    if(self.textView.inputView){//如果当前键盘为自定义
        self.textView.inputView = nil;
        //显示表情图片
        self.composeToolbar.showEmotion = YES;
    }else{//如果为系统自带键盘就，切换为自定义键盘
        self.textView.inputView = self.emotionKeyboard;
        self.composeToolbar.showEmotion = NO;
    }
    //如果临时跟换文本框的键盘，一定要重新打开键盘
    [self.textView resignFirstResponder];
    
    //跟换键盘完毕
    self.changeKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

#pragma mark -UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.photosView addImage:info[UIImagePickerControllerOriginalImage]];
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  view显示完毕弹出键盘
 */
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark -通知相关
-(void)emotionDidSelected:(NSNotification*)notification{
    AIEmotion *emotion = notification.userInfo[AISelectedEmotion];
    AILog(@"%@,---emoji = %@",emotion.chs,emotion.emoji);
}

-(void)emotionDidDeleted:(NSNotification*)notification{
    AILog(@"删除按钮");
}
@end
