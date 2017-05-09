//
//  BasicViewController.m
//  ProjectTest
//
//  Created by hejuan on 16/8/24.
//  Copyright © 2016年 WXP. All rights reserved.
//

#import "BasicViewController.h"
#import "AViewController.h"
@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 100, WIDTH - 20 * 2, 40);
    label.backgroundColor = [UIColor cyanColor];
    label.text = @"BasicViewController";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AViewController *av = [[AViewController alloc]init];
    av.view.backgroundColor = [UIColor clearColor];
    av.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    av.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:av animated:YES completion:nil];
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
