//
//  AITemp2ViewController.m
//  AISian
//
//  Created by 艾泽鑫 on 15/9/28.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AITemp2ViewController.h"
#import "AITemp3ViewController.h"
@interface AITemp2ViewController ()

@end

@implementation AITemp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)jump2Three:(UIButton *)sender {
    AITemp3ViewController *temp3 = [[AITemp3ViewController alloc]init];
    [self.navigationController pushViewController:temp3 animated:YES];
}

@end
