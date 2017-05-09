//
//  ShockWaveController.m
//  ProjectTest
//
//  Created by hejuan on 16/8/24.
//  Copyright © 2016年 WXP. All rights reserved.
//

#import "ShockWaveController.h"
#import "PulsingHaloLayer.h"

@interface ShockWaveController ()

@end

@implementation ShockWaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 20, 20);
    button.layer.cornerRadius = 10;
    button.backgroundColor = [UIColor lightGrayColor];
    button.center = CGPointMake(WIDTH / 2, self.view.frame.size.height / 3);
    [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnSearch];
    btnSearch.frame = CGRectMake((WIDTH - 20) / 2, 400, 20, 20);
    btnSearch.layer.cornerRadius = 10;
    btnSearch.layer.masksToBounds = YES;
    btnSearch.backgroundColor = [UIColor orangeColor];
    [btnSearch addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) btnSearchClicked:(UIButton *) sender{
    sender.enabled = NO;
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(sender.bounds), -CGRectGetMidY(sender.bounds), sender.bounds.size.width, sender.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:sender.layer.cornerRadius];
    CGPoint shapePosition = [self.view convertPoint:sender.center fromView:self.view];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = UICOLOR_RGBA(250, 126, 20, 0.8).CGColor;
    circleShape.lineWidth = 1;
    [self.view.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10.0, 10.0, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 1.0f;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:animation forKey:nil];
}

- (void)clicked:(UIButton *)sender{
    PulsingHaloLayer *lala = [[PulsingHaloLayer alloc]init];
    lala.animationDuration = 1.0;
    lala.animationRepeatCount = HUGE_VALF;
    lala.position = sender.center;
    [self.view.layer insertSublayer:lala below:sender.layer];
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
