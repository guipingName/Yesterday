//
//  BezierPathViewController.m
//  GPAnimation
//
//  Created by guiping on 2017/5/5.
//  Copyright © 2017年 pingui. All rights reserved.
//
#ifndef W_H_
#define W_H_
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#import "BezierPathViewController.h"

@interface BezierPathViewController (){
    NSTimer *timer;
    CAShapeLayer *shapeLayer;
}


@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.画两个圆
    [self createBezierPath:CGRectMake(0, 0, 100, 100)];
    
    // 2.画一个转动的圆
    [self circleBezierPath];
    //用定时器模拟数值输入的情况
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(circleAnimationTypeOne) userInfo:nil repeats:YES];
    
    // 3.二次贝塞尔曲线
    [self createCurvedLine];
    
    // 4.圆角矩形
    [self RoundedRect];
    
    [self aline];
}

#pragma mark --------------- 直线 ----------------
- (void) aline{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(30, 70)];
    [path addLineToPoint:CGPointMake(WIDTH - 60, 80)];
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=path.CGPath;
    //layer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:layer];
    layer.strokeColor=[UIColor greenColor].CGColor;
    layer.lineWidth = 3;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

#pragma mark --------------- 二次贝塞尔曲线 ----------------
-(void)createCurvedLine{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(20, 270)];
    [aPath addQuadCurveToPoint:CGPointMake(200, 270) controlPoint:CGPointMake(30, 100)];
    
    CAShapeLayer *curvedLineLayer=[CAShapeLayer layer];
    curvedLineLayer.path=aPath.CGPath;
    //curvedLineLayer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:curvedLineLayer];
    curvedLineLayer.fillColor = [UIColor clearColor].CGColor;
    curvedLineLayer.strokeColor=[UIColor redColor].CGColor;
    curvedLineLayer.path = aPath.CGPath;
    curvedLineLayer.lineWidth = 5;
    
//    CAGradientLayer *layer = [CAGradientLayer layer];
//    layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
//    //layer.locations = locationsArray;
//    layer.frame = CGRectMake(0, 0, 100, 100);
//    layer.startPoint = CGPointMake(0, 0);
//    layer.endPoint = CGPointMake(1.0, 0);
//    [curvedLineLayer addSublayer:layer];
}

#pragma mark --------------- 圆角矩形 ----------------
- (void) RoundedRect{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(WIDTH * 3 / 4 - 60, 200, 120, 70) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *curvedLineLayer=[CAShapeLayer layer];
    curvedLineLayer.path=path.CGPath;
    //curvedLineLayer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:curvedLineLayer];
    curvedLineLayer.fillColor = nil;
    curvedLineLayer.strokeColor=[UIColor grayColor].CGColor;
    curvedLineLayer.lineWidth = 4;
}

#pragma mark --------------- 画一个转动的圆 ----------------
-(void)circleBezierPath{
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(WIDTH * 3 / 4 - 40, 85, 80, 80)];
    
    shapeLayer = [CAShapeLayer layer];
    //shapeLayer.frame = CGRectMake(0, 0, 80, 80);
    //shapeLayer.position = CGPointMake(220, 130);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    
    shapeLayer.path = circlePath.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}

- (void)circleAnimationTypeOne{
    if (shapeLayer.strokeEnd > 1 && shapeLayer.strokeStart < 1) {
        shapeLayer.strokeStart += 0.1;
    }
    else if(shapeLayer.strokeStart == 0){
        shapeLayer.strokeEnd += 0.1;
    }
    
    if (shapeLayer.strokeEnd == 0) {
        shapeLayer.strokeStart = 0;
    }
    
    if (shapeLayer.strokeStart == shapeLayer.strokeEnd) {
        shapeLayer.strokeEnd = 0;
    }
}


#pragma mark --------------- 圆 ----------------
-(void)createBezierPath:(CGRect)mybound{
    
    // 考虑到线条的粗细
    // 圆心到外边缘的距离 = 半径 + 线条粗细 / 2
    // 圆心到内边缘的距离 = 半径 - 线条粗细 / 2
    // 如果画同心圆使外边缘或内边缘对齐可适当调整半径
    
    //外圆
    UIBezierPath *_trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH / 4, 120) radius:40 + 1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    
    CAShapeLayer *_trackLayer = [CAShapeLayer new];
    _trackLayer.frame = mybound;
    [self.view.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.strokeColor=[UIColor grayColor].CGColor;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.lineWidth = 4;
    
    //内圆(方法一) 不完整的圆
//    UIBezierPath *_progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH / 4, 120) radius:40 startAngle:- M_PI_2 endAngle:(M_PI * 2) * 0.7 - M_PI_2 clockwise:YES];
//    
//    CAShapeLayer *_progressLayer = [CAShapeLayer new];
//    [self.view.layer addSublayer:_progressLayer];
//    _progressLayer.fillColor = nil;
//    _progressLayer.strokeColor=[UIColor redColor].CGColor;
//    _progressLayer.lineCap = kCALineCapRound;
//    _progressLayer.path = _progressPath.CGPath;
//    _progressLayer.lineWidth = 6;
//    _progressLayer.frame = mybound;
    
    // 不完整的圆 方法二
    // 先画一个完整的圆 然后改变strokeStart 和 strokeEnd属性
    UIBezierPath *_progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH / 4, 120) radius:40 startAngle:- M_PI_2 endAngle:M_PI * 1.5  clockwise:YES];
    
    CAShapeLayer *_progressLayer = [CAShapeLayer new];
    _progressLayer.frame = mybound;
    [self.view.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor=[UIColor redColor].CGColor;
    // 终点处理 平角
    _progressLayer.lineCap = kCALineCapSquare;
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.lineWidth = 6;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0.8;
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
