//
//  ViewController.m
//  ScrollLabel
//
//  Created by liuyiyi on 2017/5/16.
//  Copyright © 2017年 liuyiyi. All rights reserved.
//

#import "ViewController.h"
#import "ScrollLabelView.h"
#import "Animate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    ScrollLabelView *view = [[ScrollLabelView alloc] initWithFrame:CGRectMake(0, 100, 150, 50)];
//    [view setTitle:@"11223344556677889900" font:[UIFont systemFontOfSize:14]];

    
    [self.view.layer addSublayer:[Animate shake]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
