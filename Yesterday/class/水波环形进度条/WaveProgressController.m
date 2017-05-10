//
//  ViewController.m
//  LXWaveProgressDemo
//
//  Created by liuxin on 16/8/1.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "WaveProgressController.h"
#import "WaveProgressView.h"


@interface WaveProgressController ()

@end

@implementation WaveProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    // 第一个
    WaveProgressView *progressView = [[WaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView.center=CGPointMake(CGRectGetMidX(self.view.bounds), 150);
    progressView.progress = 0.3;
    progressView.speed = 0.5;
    [self.view addSubview:progressView];
    
    // 第二个
    WaveProgressView *progressView1 = [[WaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView1.center=CGPointMake(CGRectGetMidX(self.view.bounds), 270);
    progressView1.progress = 0.5;
    progressView1.waveHeight = 10;
    progressView1.speed = 1.0;
    progressView1.isShowSingleWave=YES;
    progressView1.firstWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:1];
    [self.view addSubview:progressView1];
    
    // 第三个
    WaveProgressView *progressView2 = [[WaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView2.center=CGPointMake(CGRectGetMidX(self.view.bounds), 390);
    progressView2.progress = 0.7;
    progressView2.waveHeight = 7;
    progressView2.speed = 0.8;
    progressView2.firstWaveColor = [UIColor colorWithRed:134/255.0 green:216/255.0 blue:210/255.0 alpha:1];
    progressView2.secondWaveColor = [UIColor colorWithRed:134/255.0 green:216/255.0 blue:210/255.0 alpha:0.5];
    [self.view addSubview:progressView2];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
