//
//  cellView.m
//  scro
//
//  Created by guiping on 2017/8/30.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "cellView.h"

#define pix(x) WIDTH * x / 375.0
#define piy(y) HEIGHT * y / 667.0

@interface ColorCell()
{
    UILabel *lbColorName;
    UIView *normalView;
    UIView *selectedView;
    UIView *animationView;
    CAGradientLayer *sideGradLayer;
    CABasicAnimation *rotationAnimation;
}
@end

@implementation ColorCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        lbColorName = [[UILabel alloc] initWithFrame:CGRectMake(0, piy(56), pix(48), piy(12))];
        lbColorName.textAlignment = NSTextAlignmentCenter;
        lbColorName.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        lbColorName.font = [UIFont systemFontOfSize:12];
        [self addSubview:lbColorName];
        
        UIView *cicleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        [self addSubview:cicleView];
        cicleView.layer.shadowOpacity = 0.2;
        cicleView.layer.shadowOffset = CGSizeMake(4, 0);
        cicleView.layer.shadowRadius = 4;
        
        normalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cicleView.bounds.size.width, cicleView.bounds.size.width)];
        normalView.layer.cornerRadius = normalView.bounds.size.width/2;
        normalView.layer.masksToBounds = YES;
        [cicleView addSubview:normalView];
        
        UIView *normalInner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cicleView.bounds.size.width/3, cicleView.bounds.size.width/3)];
        normalInner.center = CGPointMake(normalView.bounds.size.width / 2, normalView.bounds.size.height / 2);
        [normalView addSubview:normalInner];
        normalInner.backgroundColor = [UIColor whiteColor];
        normalInner.layer.cornerRadius = normalInner.bounds.size.width/2;
        normalInner.layer.shadowColor = [UIColor blackColor].CGColor;
        normalInner.layer.shadowOffset = CGSizeMake(4, 0);
        normalInner.layer.shadowOpacity = 0.2f;
        normalInner.layer.shadowRadius = 4;
        
        selectedView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, cicleView.bounds.size.width - 6, cicleView.bounds.size.width - 6)];
        selectedView.layer.cornerRadius = selectedView.bounds.size.width/2;
        selectedView.layer.masksToBounds = YES;
        [cicleView addSubview:selectedView];
        UIView *selectedInner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cicleView.bounds.size.width/6, cicleView.bounds.size.width/6)];
        selectedInner.center = CGPointMake(selectedView.bounds.size.width / 2, selectedView.bounds.size.height / 2);
        [selectedView addSubview:selectedInner];
        selectedInner.backgroundColor = [UIColor whiteColor];
        selectedInner.layer.cornerRadius = selectedInner.bounds.size.width/2;
        selectedInner.layer.shadowColor = [UIColor blackColor].CGColor;
        selectedInner.layer.shadowOffset = CGSizeMake(4, 0);
        selectedInner.layer.shadowOpacity = 0.2f;
        selectedInner.layer.shadowRadius = 4;
        
        // 添加动画
        animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cicleView.bounds.size.width, cicleView.bounds.size.width)];
        //animationView.hidden = YES;
        animationView.backgroundColor = [UIColor clearColor];
        [self addSubview:animationView];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(animationView.bounds.size.width/2, animationView.bounds.size.width/2) radius:cicleView.bounds.size.width/2 - 1 startAngle:- M_PI / 2 endAngle:M_PI * 0.38 clockwise:NO];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.lineWidth = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blueColor].CGColor;
        [animationView.layer addSublayer:layer];
        
        sideGradLayer = [CAGradientLayer layer];
        sideGradLayer.frame = animationView.bounds;
        sideGradLayer.startPoint = CGPointZero;
        sideGradLayer.endPoint = CGPointMake(0, 1);
        [animationView.layer addSublayer:sideGradLayer];
        sideGradLayer.mask = layer;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void) doTap:(UITapGestureRecognizer *) sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [self.delegate didSelectedItem:self];
    }
}

-(void)setColordata:(NSArray *)dataArray{
    lbColorName.text = dataArray[2];
    UIColor *color = [self colorFromHexString:dataArray[1]];
    _colorId = [dataArray[0] integerValue];
    normalView.backgroundColor = color;
    selectedView.backgroundColor = color;
    if ([dataArray[0] integerValue]== 7) {
        color = [UIColor redColor];
    }
    sideGradLayer.colors = @[(__bridge id)color.CGColor,(__bridge id)[color colorWithAlphaComponent:0.2].CGColor];
}

-(void)isShowAnimation:(BOOL)isSelected{
    [animationView.layer removeAllAnimations];
    rotationAnimation = nil;
    if (isSelected) {
        normalView.hidden = YES;
        selectedView.hidden = NO;
        animationView.hidden = NO;
        lbColorName.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        [self startStroke];
    }
    else{
        lbColorName.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        normalView.hidden = NO;
        selectedView.hidden = YES;
        animationView.hidden = YES;
        
    }
}

-(void)startStroke{
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 4;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.fillMode = kCAFillModeBoth;
    [animationView.layer addAnimation:rotationAnimation forKey:nil];
}


- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0f green:((rgbValue & 0xFF00) >> 8)/255.0f blue:(rgbValue & 0xFF)/255.0f alpha:1.0];
    return color;
}


@end
