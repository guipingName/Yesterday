//
//  Circle.m
//  Yesterday
//
//  Created by guiping on 2017/6/20.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "Circle.h"

@implementation Circle
{
    CABasicAnimation* rotationAnimation;
    BOOL isAnimating;
    UIView *outSideView;
    
    CAGradientLayer *outGradLayer;
    CALayer *pointLayer;
    
    CAGradientLayer *inGradLayer;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGRect aa = frame;
        CGFloat ab = 0;
        if (frame.size.width > frame.size.height) {
            ab = frame.size.height;
        }
        else{
            ab = frame.size.width;
        }
        self.frame = CGRectMake(aa.origin.x, aa.origin.y, ab, ab);
        
        [self inSide];
        [self outSide];
    }
    return self;
}

-(void)startStroke{
    if (rotationAnimation && isAnimating) {
        return;
    }
    isAnimating = YES;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 6;
    rotationAnimation.delegate = (id <CAAnimationDelegate>)self;
    rotationAnimation.fillMode = kCAFillModeBoth;
    [outSideView.layer addAnimation:rotationAnimation forKey:nil];
}


-(void)setWorkMode:(WorkMode)workMode{
    switch (workMode) {
        case 0:
            outGradLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor];
            inGradLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor];
            pointLayer.backgroundColor = [UIColor blueColor].CGColor;
            break;
        case 1:
            outGradLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[[UIColor orangeColor] colorWithAlphaComponent:0.2].CGColor];
            inGradLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[[UIColor orangeColor] colorWithAlphaComponent:0.2].CGColor];
            pointLayer.backgroundColor = [UIColor orangeColor].CGColor;
            break;
        case 2:
            outGradLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[[UIColor redColor] colorWithAlphaComponent:0.2].CGColor];
            inGradLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[[UIColor redColor] colorWithAlphaComponent:0.2].CGColor];
            pointLayer.backgroundColor = [UIColor redColor].CGColor;
            break;
        default:
            break;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [outSideView.layer removeAllAnimations];
    rotationAnimation = nil;
    if (isAnimating) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self performSelector:@selector(startStroke) withObject:nil afterDelay:3];
            [[NSRunLoop currentRunLoop]run];
        });
    }
}

-(void) outSide{
    outSideView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:outSideView];

    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2) radius:self.bounds.size.width / 2 - 2 startAngle:- M_PI / 2 endAngle:M_PI * 0.38 clockwise:NO];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path2.CGPath;
    layer2.lineWidth = 2;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = [UIColor blueColor].CGColor;
    [outSideView.layer addSublayer:layer2];
    
    // 渐变色
    outGradLayer = [CAGradientLayer layer];
    outGradLayer.frame = self.bounds;
    outGradLayer.startPoint = CGPointZero;
    outGradLayer.endPoint = CGPointMake(0, 1);
    [outSideView.layer addSublayer:outGradLayer];
    outGradLayer.mask = layer2;
    outGradLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor];
    
    // 小圆点
    pointLayer = [CALayer layer];
    pointLayer.frame = CGRectMake(0, 0, 4, 4);
    pointLayer.cornerRadius = 2;
    pointLayer.masksToBounds = YES;
    pointLayer.position = CGPointMake(self.bounds.size.width / 2 , 2);
    pointLayer.backgroundColor = [UIColor blueColor].CGColor;
    [outSideView.layer addSublayer:pointLayer];
}

- (void) inSide{
    UIView *big = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:big];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2) radius:self.bounds.size.width / 2 - 10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 2;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    [big.layer addSublayer:layer];
    
    inGradLayer = [CAGradientLayer layer];
    inGradLayer.frame = self.bounds;
    inGradLayer.startPoint = CGPointZero;
    inGradLayer.endPoint = CGPointMake(0, 1);
    [big.layer addSublayer:inGradLayer];
    inGradLayer.mask = layer;
    inGradLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor];
    

    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.width / 2) radius:self.bounds.size.width / 2 - 6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.lineWidth = 4;
    layer1.fillColor = nil;
    layer1.strokeColor = [UIColor whiteColor].CGColor;
    [big.layer addSublayer:layer1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
