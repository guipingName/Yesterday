//
//  aaViewController.m
//  Yesterday
//
//  Created by guiping on 2017/6/20.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "ElectricViewController.h"

@interface ElectricViewController ()

@end

@implementation ElectricViewController

-(instancetype)init{
    if (self = [super init]) {
        self.title = @"悟空i8";
        self.tabBarItem.title = @"电量管家";
        self.tabBarItem.image = [UIImage imageNamed:@"电量管家"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"电量管家选中"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:225/255.0 alpha:1];
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
