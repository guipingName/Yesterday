//
//  weatherViewController.m
//  Yesterday
//
//  Created by guiping on 2017/6/8.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "WeatherView.h"

#define widthPix WIDTH/320
#define heightPix HEIGHT/568

@interface WeatherViewController ()

@property (nonatomic, strong) UIImageView  *backgroudView;

@property(nonatomic,strong)WeatherView *weatherV;


//多云动画
@property (nonatomic, strong) NSMutableArray *imageArr;//鸟图片数组
@property (nonatomic, strong) UIImageView *birdImage;//鸟本体
@property (nonatomic, strong) UIImageView *birdRefImage;//鸟倒影
@property (nonatomic, strong) UIImageView *cloudImageViewF;//云
@property (nonatomic, strong) UIImageView *cloudImageViewS;//云
//晴天动画
@property (nonatomic, strong) UIImageView *sunImage;//太阳
@property (nonatomic, strong) UIImageView *sunshineImage;//太阳光
@property (nonatomic, strong) UIImageView *sunCloudImage;//晴天云
//雨天动画
@property (nonatomic, strong) UIImageView *rainCloudImage;//乌云
@property (nonatomic, strong) NSArray *jsonArray;

@end

@implementation WeatherViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = THEME_COLOR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:94/255.0 green:158/255.0 blue:202/255.0 alpha:1];
    self.backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_normal.jpg"]];
    _backgroudView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    [self.view addSubview:self.backgroudView];
    
    [self.view addSubview:self.weatherV];
        
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weather.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if (responseObject == nil) {
        NSLog(@"test.json文件内容===格式错误");
    }
    NSArray *resultArray = responseObject[@"results"];
    for (NSDictionary *dic in resultArray) {
        WeatherModel *model = [[WeatherModel alloc]init];
        model.cityName = dic[@"location"][@"name"];
        model.todayDic = (NSDictionary *)[dic[@"daily"] objectAtIndex:0];
        model.tomorrowDic = (NSDictionary *)[dic[@"daily"] objectAtIndex:1];
        model.afterTomorrowDic = (NSDictionary *)[dic[@"daily"] objectAtIndex:2];
        self.weatherV.model = model;
        [self addAnimationWithType:[dic[@"daily"] objectAtIndex:0][@"code_day"]];
    }
    
    NSArray *imageNames = @[@"晴天",@"多云",@"雨",@"雪",@"雾霾",@"冷"];
    for (int i=0; i<imageNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        button.frame = CGRectMake((WIDTH - 221) / 2 +(i % 3) * (75+3) , HEIGHT-90 + (i / 3) * 43, 75, 40);
        button.backgroundColor = UICOLOR_RGBA(255, 255, 255, 0.25);
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        [button setTitle:imageNames[i] forState:UIControlStateNormal];
        button.tag = 300 + i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) buttonClicked:(UIButton *) sender{
    [self addAnimationWithType:[NSString stringWithFormat:@"%ld",sender.tag - 300]];
}

- (void)changeImageAnimated:(UIImage *)image {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.backgroudView.layer addAnimation:transition forKey:@"a"];
    [self.backgroudView setImage:image];
    
}

- (void)removeAnimationView {
    //先将所有的动画移除
    [self.birdImage removeFromSuperview];
    [self.birdRefImage removeFromSuperview];
    [self.cloudImageViewF removeFromSuperview];
    [self.cloudImageViewS removeFromSuperview];
    [self.sunImage removeFromSuperview];
    [self.sunshineImage removeFromSuperview];
    [self.sunCloudImage removeFromSuperview];
    [self.rainCloudImage removeFromSuperview];
    
    for (NSInteger i = 0; i < _jsonArray.count; i++) {
        UIImageView *rainLineView = (UIImageView *)[self.view viewWithTag:100+i];
        [rainLineView removeFromSuperview];//移除下雨
        
        UIImageView *snowView = (UIImageView *)[self.view viewWithTag:1000+i];
        [snowView removeFromSuperview];//移除雪
    }
}

//添加动画
- (void)addAnimationWithType:(NSString *)weatherType{
    //先将所有的动画移除
    [self removeAnimationView];
    
    NSInteger type = [weatherType integerValue];
    switch (type) {
        case 0: //晴天
            [self changeImageAnimated:[UIImage imageNamed:@"bg_sunny_day.jpg"]];
            [self sun];
            break;
        case 1: //多云
            [self changeImageAnimated:[UIImage imageNamed:@"bg_normal.jpg"]];
            [self wind];
            break;
        case 2: //雨
            [self changeImageAnimated:[UIImage imageNamed:@"bg_rain_day.jpg"]];
            [self rain];
            break;
        case 3: //雪
            [self changeImageAnimated:[UIImage imageNamed:@"bg_snow_night.jpg"]];
            [self snow];
            break;
        case 4: //雾霾
            [self changeImageAnimated:[UIImage imageNamed:@"bg_haze.jpg"]];
            break;
        case 5: //冷
            [self changeImageAnimated:[UIImage imageNamed:@"bg_fog_day.jpg"]];
            break;
        default:
            break;
    }
    [self.view bringSubviewToFront:self.weatherV];
}

//晴天动画
- (void)sun {
    //太阳
    _sunImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ele_sunnySun"]];
    CGRect frameSun = _sunImage.frame;
    frameSun.size = CGSizeMake(200, 200*579/612.0);
    _sunImage.frame = frameSun;
    _sunImage.center = CGPointMake(HEIGHT * 0.1, HEIGHT * 0.1);
    [self.view addSubview:_sunImage];
    [_sunImage.layer addAnimation:[self sunshineAnimationWithDuration:40] forKey:nil];
    
    //太阳光
    _sunshineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ele_sunnySunshine"]];
    CGRect _sunImageFrame = _sunshineImage.frame;
    _sunImageFrame.size = CGSizeMake(400, 400);
    _sunshineImage.frame = _sunImageFrame;
    _sunshineImage.center = CGPointMake(HEIGHT * 0.1, HEIGHT * 0.1);
    [self.view addSubview:_sunshineImage];
    [_sunshineImage.layer addAnimation:[self sunshineAnimationWithDuration:40] forKey:nil];

    //晴天云
    _sunCloudImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ele_sunnyCloud2"]];
    CGRect frame = _sunCloudImage.frame;
    frame.size = CGSizeMake(HEIGHT *0.7, WIDTH*0.5);
    _sunCloudImage.frame = frame;
    _sunCloudImage.center = CGPointMake(WIDTH * 0.25, HEIGHT*0.5);
    [_sunCloudImage.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:50] forKey:nil];
    [self.view addSubview:_sunCloudImage];
}

//多云动画
- (void)wind {
    
    //鸟 本体
    _birdImage = [[UIImageView alloc]initWithFrame:CGRectMake(-30, HEIGHT * 0.2, 70, 50)];
    [_birdImage setAnimationImages:self.imageArr];
    _birdImage.animationRepeatCount = 0;
    _birdImage.animationDuration = 1;
    [_birdImage startAnimating];
    [self.view addSubview:_birdImage];
    [_birdImage.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:10  ] forKey:nil];
    
    //鸟 倒影
    _birdRefImage = [[UIImageView alloc]initWithFrame:CGRectMake(-30, HEIGHT * 0.8, 70, 50)];
    //[self.backgroudView addSubview:self.birdRefImage];
    [_birdRefImage setAnimationImages:self.imageArr];
    _birdRefImage.animationRepeatCount = 0;
    _birdRefImage.animationDuration = 1;
    _birdRefImage.alpha = 0.4;
    [_birdRefImage startAnimating];
    
    [_birdRefImage.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:10] forKey:nil];
    
    
    //云朵效果
    _cloudImageViewF = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ele_sunnyCloud2"]];
    CGRect frame = _cloudImageViewF.frame;
    frame.size = CGSizeMake(HEIGHT *0.7, WIDTH*0.5);
    _cloudImageViewF.frame = frame;
    _cloudImageViewF.center = CGPointMake(WIDTH * 0.25, HEIGHT*0.7);
    [_cloudImageViewF.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:70] forKey:nil];
    [self.view addSubview:_cloudImageViewF];

    _cloudImageViewS = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ele_sunnyCloud1"]];
    _cloudImageViewS.frame = self.cloudImageViewF.frame;
    _cloudImageViewS.center = CGPointMake(WIDTH * 0.05, HEIGHT*0.7);
    [_cloudImageViewS.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:70] forKey:nil];
    [self.view addSubview:_cloudImageViewS];
    
}

//雨天动画
- (void)rain {
    //加载JSON文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainData.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //将JSON数据转为NSArray或NSDictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _jsonArray = dict[@"weather"][@"image"];
    
    for (NSInteger i = 0; i < _jsonArray.count; i++) {
        
        NSDictionary *dic = [_jsonArray objectAtIndex:i];
        UIImageView *rainLineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:dic[@"-imageName"]]];
        rainLineView.tag = 100+i;
        NSArray *sizeArr = [dic[@"-size"] componentsSeparatedByString:@","];
        NSArray *originArr = [dic[@"-origin"] componentsSeparatedByString:@","];
        rainLineView.frame = CGRectMake([originArr[0] integerValue]*widthPix , [originArr[1] integerValue], [sizeArr[0] integerValue], [sizeArr[1] integerValue]);
        [self.view addSubview:rainLineView];
        [rainLineView.layer addAnimation:[self rainAnimationWithDuration:2+i%5] forKey:nil];
        [rainLineView.layer addAnimation:[self rainAlphaWithDuration:2+i%5] forKey:nil];
    }
    
    //乌云
    _rainCloudImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"night_rain_cloud"]];
    CGRect frame = _rainCloudImage.frame;
    frame.size = CGSizeMake(768/371.0* WIDTH*0.5, WIDTH*0.5);
    _rainCloudImage.frame = frame;
    _rainCloudImage.center = CGPointMake(WIDTH * 0.25, HEIGHT*0.1);
    [_rainCloudImage.layer addAnimation:[self birdFlyAnimationWithToValue:@(WIDTH+30) duration:50] forKey:nil];
    [self.view addSubview:_rainCloudImage];
}

//下雪
- (void)snow {
    //加载JSON文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainData.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //将JSON数据转为NSArray或NSDictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _jsonArray = dict[@"weather"][@"image"];
    for (NSInteger i = 0; i < _jsonArray.count; i++) {
        
        NSDictionary *dic = [_jsonArray objectAtIndex:i];
        UIImageView *snowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snow"]];
        snowView.tag = 1000+i;
        NSArray *originArr = [dic[@"-origin"] componentsSeparatedByString:@","];
        snowView.frame = CGRectMake([originArr[0] integerValue]*widthPix , [originArr[1] integerValue], arc4random()%7+3, arc4random()%7+3);
        [self.view addSubview:snowView];
        [snowView.layer addAnimation:[self rainAnimationWithDuration:5+i%5] forKey:nil];
        [snowView.layer addAnimation:[self rainAlphaWithDuration:5+i%5] forKey:nil];
        [snowView.layer addAnimation:[self sunshineAnimationWithDuration:5] forKey:nil];//雪花旋转
    }
}

//动画横向移动方法
- (CABasicAnimation *)birdFlyAnimationWithToValue:(NSNumber *)toValue duration:(NSInteger)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = toValue;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

//动画旋转方法
- (CABasicAnimation *)sunshineAnimationWithDuration:(NSInteger)duration{
    //旋转动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = MAXFLOAT;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    return rotationAnimation;
}

//下雨动画方法
- (CABasicAnimation *)rainAnimationWithDuration:(NSInteger)duration{
    
    CABasicAnimation* caBaseTransform = [CABasicAnimation animation];
    caBaseTransform.duration = duration;
    caBaseTransform.keyPath = @"transform";
    caBaseTransform.repeatCount = MAXFLOAT;
    caBaseTransform.removedOnCompletion = NO;
    caBaseTransform.fillMode = kCAFillModeForwards;
    caBaseTransform.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-170, -620, 0)];
    caBaseTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(HEIGHT/2.0*34/124.0, HEIGHT/2, 0)];
    
    return caBaseTransform;
}

//透明度动画
- (CABasicAnimation *)rainAlphaWithDuration:(NSInteger)duration {
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.1];
    showViewAnn.duration = duration;
    showViewAnn.repeatCount = MAXFLOAT;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    
    return showViewAnn;
}


-(NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            NSString *fileName = [NSString stringWithFormat:@"ele_sunnyBird%d.png",i];
            NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [_imageArr addObject:image];
        }
        
    }
    return _imageArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WeatherView *)weatherV {
    if (!_weatherV) {
        _weatherV = [[WeatherView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 90)];
    }
    return _weatherV;
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
