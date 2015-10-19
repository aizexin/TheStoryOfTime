//
//  AITabBar.h
//  AISian
//
//  Created by 艾泽鑫 on 15/10/3.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AITabBar;
@protocol AITabBarDelegate <NSObject>

-(void)tabBarDidClickedPlusButton:(AITabBar*)tabBar;

@end
@interface AITabBar : UITabBar
@property(nonatomic,weak)id<AITabBarDelegate> plusDelegate;
@end
