//
//  AITemp1ViewController.m
//  AISian
//
//  Created by 艾泽鑫 on 15/9/28.
//  Copyright © 2015年 aizexin. All rights reserved.
//

#import "AITemp1ViewController.h"
#import "AITemp2ViewController.h"
@interface AITemp1ViewController ()

@end

@implementation AITemp1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)jump2Second:(UIButton *)sender {
    AITemp2ViewController *temp2VC = [[AITemp2ViewController alloc]init];
    [self.navigationController pushViewController:temp2VC animated:YES];
}


@end
