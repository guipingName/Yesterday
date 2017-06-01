//
//  likonViewController.m
//  Yesterday
//
//  Created by guiping on 2017/5/11.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "likonViewController.h"

@interface likonViewController ()

#define UIWIDTH(pix)  pix * WIDTH / 1242
#define UIHEIGHT(pix) pix * HEIGHT / 2208

#define LIKON_COLOR [UIColor colorWithRed:0/255.0 green:174/255.0 blue:225/255.0 alpha:1]

@property (nonatomic, strong) UIView *bgView;

@end

@implementation likonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = LIKON_COLOR;
    
    [self.view addSubview:self.bgView];
    
    // 372
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH / 2, UIHEIGHT(475)) radius:UIHEIGHT(363) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = UIHEIGHT(9);
    layer.fillColor = nil;
    layer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    [_bgView.layer addSublayer:layer];
    
    // 382
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH / 2, UIHEIGHT(475)) radius:UIHEIGHT(372) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.lineWidth = UIHEIGHT(10);
    layer1.fillColor = nil;
    layer1.strokeColor = [UIColor whiteColor].CGColor;
    [_bgView.layer addSublayer:layer1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH - 60) / 2, UIHEIGHT(420), 60, 30)];
    [_bgView addSubview:label];
    label.text = @"23";
    
    
    
    
    NSArray *imageNamesN = @[@"i8_on",@"i8_开关",@"i8_摆头",@"i8_定时",@"学习_模式",@"i8_风速"];
    NSArray *imageNamesH = @[@"bimarBtn定时_gray",@"bimarBtn开关_gray",@"bimarBtn温度加_gray",@"bimarBtn风速_gray",@"bimarBtn模式_gray",@"bimarBtn温度减_gray"];
    for (int i=0; i<6; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        button.frame = CGRectMake((i % 3) * UIWIDTH(414) , UIHEIGHT(1556) - 64 + (i / 3) * UIHEIGHT(252), UIWIDTH(414), UIHEIGHT(252));
        button.backgroundColor = UICOLOR_RGBA(255, 255, 255, 0.25);
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
        [button setImage:[UIImage imageNamed:imageNamesN[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNamesH[i]] forState:UIControlStateDisabled];
        [button setImage:[UIImage imageNamed:imageNamesH[i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) operationButtonClicked:(UIButton *) sender{
    NSLog(@"buttonClicked");
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UIHEIGHT(1095))];
        _bgView.backgroundColor = LIKON_COLOR;
    }
    return _bgView;
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
