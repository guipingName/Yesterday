//
//  CoreAnimationController.m
//  ProjectTest
//
//  Created by hejuan on 16/8/24.
//  Copyright © 2016年 WXP. All rights reserved.
//

#import "CoreAnimationController.h"

@interface CoreAnimationController ()<CAAnimationDelegate>{
    UIImageView *imageView;
}

@end

@implementation CoreAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"AppIcon-129x29"];
    imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.frame = CGRectMake(100, 50, 40, 40);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
    
    //[self positionBasicAnimation];
    [self rotationBasicAnimation];
    
    [self keyFrameAnimation];
}

- (void)clickImageView{
    NSLog(@"clickImage");
}

- (void)positionBasicAnimation{
    CABasicAnimation *positionBasicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionBasicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(40, 400)];
    positionBasicAnimation.duration = 2.0;
    positionBasicAnimation.repeatCount = 1;
    positionBasicAnimation.delegate = self;
    
    //    basicAnimation.removedOnCompletion = NO;
    //    basicAnimation.fillMode = kCAFillModeForwards;
    [imageView.layer addAnimation:positionBasicAnimation forKey:@"basicAnimation"];
}

- (void)rotationBasicAnimation{
    CABasicAnimation *rotationBasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationBasicAnimation.delegate = self;
    rotationBasicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3];
    rotationBasicAnimation.duration = 2.0;
    rotationBasicAnimation.autoreverses = YES;
    [imageView.layer addAnimation:rotationBasicAnimation forKey:@"rotationBasicAnimation"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    imageView.layer.position = CGPointMake(40, 400);
    [CATransaction commit];
    
}

- (void)keyFrameAnimation{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.delegate = self;
    NSValue *key1 = [NSValue valueWithCGPoint:CGPointMake(80, 100)];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(60, 150)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(40, 200)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(60, 250)];
    NSValue *key5 = [NSValue valueWithCGPoint:CGPointMake(80, 300)];
    NSValue *key6 = [NSValue valueWithCGPoint:CGPointMake(60, 350)];
    NSValue *key7 = [NSValue valueWithCGPoint:CGPointMake(40, 400)];
    keyFrameAnimation.values = @[key1,key2,key3,key4,key5,key6,key7];
    keyFrameAnimation.duration = 3.0;
    [imageView.layer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation"];
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
