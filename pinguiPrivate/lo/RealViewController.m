//
//  RealViewController.m
//  pingui_dan
//
//  Created by guiping on 2017/12/11.
//  Copyright © 2017年 guiping. All rights reserved.
//

#import "RealViewController.h"
#import "YQAnimationLayer.h"
#import "IFlyMSC/IFlyMSC.h"

@interface RealViewController ()<IFlySpeechSynthesizerDelegate>
{
    NSInteger tapCount;
    NSDate *dateLastOpt;
    NSDate *reDate;
}
@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;
@property (nonatomic, strong) CAEmitterLayer * emitterLayer;
@property (nonatomic, strong) CAEmitterLayer *caELayer;
@end

@implementation RealViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:22.0f/255.0 green:22.0f/255.0 blue:22.0f/255.0 alpha:1.0];
    tapCount = 0;
    
    [self initSynthesizer];
    
    // 特效一
    [self SetupEmitter];
    // 特效二
    //[self createeYanhua];
}

- (void) yuyinStart
{
    NSString *sdwd = _yuyxin;
    if (!sdwd || sdwd.length == 0) {
        sdwd = @"橙子  橙子 🍊  我喜欢你，我爱你";
    }
    [_iFlySpeechSynthesizer startSpeaking:sdwd];
    if (_iFlySpeechSynthesizer.isSpeaking) {
        //_state = Playing;
    }
}

- (void) onCompleted:(IFlySpeechError*) error
{
    NSLog(@"onCompleted");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    tapCount++;
    if (tapCount == 30) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (tapCount == 10) {
        [self yuyinStart];
    }
    
    if (tapCount > 9) {
        if (dateLastOpt && [[NSDate date] timeIntervalSinceDate:dateLastOpt] <= 5) {
            return;
        }
        dateLastOpt = [NSDate date];
        if ([_goddess isEqualToString:@" "]) {
            return;
        }
        for (id layer in self.view.layer.sublayers) {
            if([layer isKindOfClass:[YQAnimationLayer class]]) {
                [layer removeFromSuperlayer];
            }
        }
        [YQAnimationLayer createAnimationLayerWithString:_goddess andRect: CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.width) andView:self.view andFont:[UIFont boldSystemFontOfSize:40] andStrokeColor:[UIColor cyanColor]];
    }else{
        if (reDate && [[NSDate date] timeIntervalSinceDate:dateLastOpt] > 3) {
            tapCount = 1;
        }
        reDate = [NSDate date];
    }
}


- (void) createeYanhua{
    self.view.backgroundColor       = [UIColor blackColor];
    self.caELayer                   = [CAEmitterLayer layer];
    // 发射源
    self.caELayer.emitterPosition   = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
    // 发射源尺寸大小
    self.caELayer.emitterSize       = CGSizeMake(50, 0);
    // 发射源模式
    self.caELayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    self.caELayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    self.caELayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    self.caELayer.velocity          = 1;
    // 随机产生粒子
    self.caELayer.seed              = (arc4random() % 100) + 1;
    
    // cell
    CAEmitterCell *cell             = [CAEmitterCell emitterCell];
    // 速率
    cell.birthRate                  = 1.0;
    // 发射的角度
    cell.emissionRange              = 0.11 * M_PI;
    // 速度
    cell.velocity                   = 300;
    // 范围
    cell.velocityRange              = 150;
    // Y轴 加速度分量
    cell.yAcceleration              = 75;
    // 声明周期
    cell.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents                   = (id)
    [[UIImage imageNamed:@"FFRing"] CGImage];
    // 缩放比例
    cell.scale                      = 0.2;
    // 粒子的颜色
    cell.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange                  = 1.0;
    // 子旋转角度范围
    cell.spinRange                  = M_PI;
    
    // 爆炸
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 125;
    // 360 deg//周围发射角度
    spark.emissionRange             = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration             = 75;
    //粒子生命周期
    spark.lifetime                  = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents                  = (id)
    [[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    spark.scaleSpeed                = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.25;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    self.caELayer.emitterCells = [NSArray arrayWithObject:cell];
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:self.caELayer];
}


- (void)SetupEmitter{
    // Cells spawn in the bottom, moving up
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize    = CGSizeMake(1, 0.0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter.renderMode        = kCAEmitterLayerAdditive;
    //fireworksEmitter.seed = 500;//(arc4random()%100)+300;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate        = 6.0;
    rocket.emissionRange    = 0.12 * M_PI;  // some variation in angle
    rocket.velocity            = 500;
    rocket.velocityRange    = 150;
    rocket.yAcceleration    = 0;
    rocket.lifetime            = 2.02;    // we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents            = (id) [[UIImage imageNamed:@"ball"] CGImage];
    rocket.scale            = 0.2;
    //    rocket.color            = [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
    rocket.greenRange        = 1.0;        // different colors
    rocket.redRange            = 1.0;
    rocket.blueRange        = 1.0;
    
    rocket.spinRange        = M_PI;        // slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = 0;
    burst.scale                = 2.5;
    burst.redSpeed            =-1.5;        // shifting
    burst.blueSpeed            =+1.5;        // shifting
    burst.greenSpeed        =+1.0;        // shifting
    burst.lifetime            = 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 666;
    spark.velocity            = 125;
    spark.emissionRange        = 2* M_PI;    // 360 deg
    spark.yAcceleration        = 75;        // gravity
    spark.lifetime            = 3;
    
    spark.contents            = (id) [[UIImage imageNamed:@"fire"] CGImage];
    spark.scale                =0.5;
    spark.scaleSpeed        =-0.2;
    spark.greenSpeed        =-0.1;
    spark.redSpeed            = 0.4;
    spark.blueSpeed            =-0.1;
    spark.alphaSpeed        =-0.5;
    spark.spin                = 2* M_PI;
    spark.spinRange            = 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                = [NSArray arrayWithObject:burst];
    burst.emitterCells                = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
    
}

- (CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue = y;
    
    animation.duration = time;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}


- (CAAnimation *)SetupScaleAnimation{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAnimation.duration = 3.0;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:40.0];
    //scaleAnimation.repeatCount = MAXFLOAT;
    //scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    
    return scaleAnimation;
}

- (CAAnimation *)SetupGroupAnimation{
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 3.0;
    groupAnimation.animations = @[[self moveY:3.0f Y:[NSNumber numberWithFloat:-300.0f]]];
    //groupAnimation.autoreverses = YES;
    //groupAnimation.repeatCount = MAXFLOAT;
    return groupAnimation;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 2.0f, 2.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


// 雪花模式
- (void)snowaaa{
    // 雪花／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／
    
    // Configure the particle emitter to the top edge of the screen
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize        = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);;
    
    // Spawn points for the flakes are within on the outline of the line
    snowEmitter.emitterMode        = kCAEmitterLayerOutline;
    snowEmitter.emitterShape    = kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    //    随机颗粒的大小
    snowflake.scale = 0.2;
    snowflake.scaleRange = 0.5;
    
    //    缩放比列速度
    //        snowflake.scaleSpeed = 0.1;
    
    //    粒子参数的速度乘数因子；
    snowflake.birthRate        = 20.0;
    
    //生命周期
    snowflake.lifetime        = 60.0;
    
    //    粒子速度
    snowflake.velocity        = 20;                // falling down slowly
    snowflake.velocityRange = 10;
    //    粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    
    //    周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;        // some variation in angle
    //    自动旋转
    snowflake.spinRange        = 0.25 * M_PI;        // slow spin
    
    snowflake.contents        = (id) [[UIImage imageNamed:@"fire"] CGImage];
    snowflake.color            = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer addSublayer:snowEmitter];
    
    //    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    //// 雪花／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／
    //// 雪花／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／／
}

- (void)initSynthesizer
{
    TTSConfig *instance = [TTSConfig sharedInstance];
    if (instance == nil) {
        return;
    }
    
    //TTS singleton
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    _iFlySpeechSynthesizer.delegate = self;
    
    //set the resource path, only for offline TTS
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    //NSString *newResPath = [[NSString alloc] initWithFormat:@"%@/aisound/common.jet;%@/aisound/xiaoyan.jet",resPath,resPath];
    //[[IFlySpeechUtility getUtility] setParameter:@"tts" forKey:[IFlyResourceUtil ENGINE_START]];
    //[_iFlySpeechSynthesizer setParameter:newResPath forKey:@"tts_res_path"];
    
    //set speed,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
    
    //set volume,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
    
    //set pitch,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
    
    //set sample rate
    [_iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //set TTS speaker
    [_iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
    
    //set text encoding mode
    [_iFlySpeechSynthesizer setParameter:@"unicode" forKey:[IFlySpeechConstant TEXT_ENCODING]];
    
    //set engine type
    [_iFlySpeechSynthesizer setParameter:instance.engineType forKey:[IFlySpeechConstant ENGINE_TYPE]];
    
    NSDictionary* languageDic=@{@"catherine":@"text_english",//English
                                @"XiaoYun":@"text_vietnam",//Vietnamese
                                @"Abha":@"text_hindi",//Hindi
                                @"Gabriela":@"text_spanish",//Spanish
                                @"Allabent":@"text_russian",//Russian
                                @"Mariane":@"text_french"};//French
    
    NSString* textNameKey=[languageDic valueForKey:instance.vcnName];
    NSString* textSample=nil;
    
    if(textNameKey && [textNameKey length]>0){
        textSample=NSLocalizedStringFromTable(textNameKey, @"tts/tts", nil);
    }else{
        textSample=NSLocalizedStringFromTable(@"text_chinese", @"tts/tts", nil);
    }
}

@end



@implementation TTSConfig

-(id)init {
    self  = [super init];
    if (self) {
        [self defaultSetting];
        return  self;
    }
    return nil;
}

+(TTSConfig *)sharedInstance {
    static TTSConfig  * instance = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        instance = [[TTSConfig alloc] init];
    });
    return instance;
}


-(void)defaultSetting {
    _speed = @"50";
    _volume = @"100";
    _pitch = @"50";
    _sampleRate = @"16000";
    _engineType = @"cloud";
    _vcnName = @"xiaofeng";
    
    
    _vcnNickNameArray = @[NSLocalizedString(@"xiaoyan", nil),
                          NSLocalizedString(@"xiaoyu", nil),
                          NSLocalizedString(@"xiaoyan2", nil),
                          NSLocalizedString(@"xiaoqi", nil),
                          NSLocalizedString(@"xiaofeng", nil),
                          NSLocalizedString(@"xiaoxin", nil),
                          NSLocalizedString(@"xiaokun", nil),
                          NSLocalizedString(@"English", nil),
                          NSLocalizedString(@"Vietnamese", nil),
                          NSLocalizedString(@"Hindi", nil),
                          NSLocalizedString(@"Spanish", nil),
                          NSLocalizedString(@"Russian", nil),
                          NSLocalizedString(@"French", nil)];
    
    _vcnIdentiferArray = @[@"xiaoyan",@"xiaoyu",@"vixy",@"vixq",@"vixf",@"vixx",@"vixk",@"catherine",@"XiaoYun",@"Abha",@"Gabriela",@"Allabent",@"Mariane"];
}


@end
