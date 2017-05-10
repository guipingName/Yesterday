//
//  Quartz2DViewController.m
//  Yesterday
//
//  Created by guiping on 2017/5/10.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "Quartz2DViewController.h"
#import "QuartzView.h"

@interface Quartz2DViewController ()

@end

@implementation Quartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    QuartzView *view = [[QuartzView alloc] initWithFrame:CGRectMake(10, 70, 355, 667 - 75)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
