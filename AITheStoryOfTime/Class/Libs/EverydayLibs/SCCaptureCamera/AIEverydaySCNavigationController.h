//
//  SCNavigationController.h
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-17.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCDefines.h"

@protocol EverydaySCNavigationControllerDelegate;

@interface AIEverydaySCNavigationController : UINavigationController


- (void)showCameraWithParentController:(UIViewController*)parentController;

@property (nonatomic, assign) id <EverydaySCNavigationControllerDelegate> scNaigationDelegate;
@end



@protocol EverydaySCNavigationControllerDelegate <NSObject>
@optional
- (BOOL)willDismissNavigationController:(AIEverydaySCNavigationController*)navigatonController;

- (void)didTakePicture:(AIEverydaySCNavigationController*)navigationController image:(UIImage*)image;

@end