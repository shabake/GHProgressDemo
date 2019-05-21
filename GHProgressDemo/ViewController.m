//
//  ViewController.m
//  GHProgressDemo
//
//  Created by zhaozhiwei on 2019/5/22.
//  Copyright © 2019年 Hyman Stephens. All rights reserved.
//

#import "ViewController.h"
#import "GHProgress.h"


@interface ViewController ()
@property (nonatomic , strong) GHProgress *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GHProgress *progress = [[GHProgress alloc]initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 50) circleLocation:GHProgressCircleLocationBegin];
    
    progress.scaleBlock = ^(CGFloat scale) {
        self.navigationItem.title = [NSString stringWithFormat:@"%.2f",scale];
    };
    
    [self.view addSubview:progress];
}

@end
