//
//  ViewController.m
//  TouchUnLock
//
//  Created by JasonLee on 2017/9/19.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "ViewController.h"
#import "DGTouchUnlockView.h"
@interface ViewController ()
@property(nonatomic, strong)NSMutableArray *pointArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DGTouchUnlockConfiguration *configuration = [[DGTouchUnlockConfiguration alloc] init];
    configuration.colNum = 3;
    configuration.rowNum = 4;
    configuration.btnHeight = 50;
    configuration.btnWidth = 50;
    DGTouchUnlockView *view = [DGTouchUnlockView viewWithConfiguration:configuration];
    view.frame = CGRectMake(0, 100, 300, 400);
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
