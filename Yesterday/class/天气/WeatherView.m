//
//  weatherView.m
//  Yesterday
//
//  Created by guiping on 2017/6/8.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "WeatherView.h"
#import "WeatherModel.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define widthPix kScreenWidth/320
#define heightPix kScreenHeight/568

@implementation WeatherView{
    // 城市名称
    UILabel *lbCity;
    
    // 天气图标
    UIImageView *imgWeather;
    
    // 气温
    UILabel *lbTemp;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
    
    lbCity = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, kScreenWidth-160, 44)];
    lbCity.textAlignment = NSTextAlignmentCenter;
    lbCity.font = [UIFont boldSystemFontOfSize:30];
    [self addSubview:lbCity];
    
    imgWeather = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imgWeather.center = CGPointMake(self.bounds.size.width / 2, CGRectGetMaxY(lbCity.frame) + 60);
    [self addSubview:imgWeather];
    
    lbTemp = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(imgWeather.frame), (WIDTH-100), 40*heightPix)];
    lbTemp.font = [UIFont boldSystemFontOfSize:30*heightPix];
    lbTemp.textAlignment = NSTextAlignmentCenter;
    lbTemp.textColor = [UIColor whiteColor];
    [self addSubview:lbTemp];
    
    
    for (NSInteger i = 0; i < 2; i++) {
        
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/2-100*widthPix)/2+kScreenWidth/2*i, CGRectGetMaxY(lbTemp.frame)+20, 100*widthPix, 30*heightPix)];
        dayLabel.font = [UIFont boldSystemFontOfSize:15*heightPix];
        dayLabel.textColor = [UIColor whiteColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.tag = 300+i;
        [self addSubview:dayLabel];
        
        UIImageView *smallWeatherImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/2-70*widthPix)/2+kScreenWidth/2*i, CGRectGetMaxY(dayLabel.frame), 70*widthPix, 70*heightPix)];
        smallWeatherImg.tag = 302+i;
        [self addSubview:smallWeatherImg];
        
        UILabel *samllTempLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/2-100*widthPix)/2+kScreenWidth/2*i, CGRectGetMaxY(smallWeatherImg.frame), 100*widthPix, 30*heightPix)];
        samllTempLabel.font = [UIFont boldSystemFontOfSize:15*heightPix];
        samllTempLabel.textColor = [UIColor whiteColor];
        samllTempLabel.tag = 304+i;
        samllTempLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:samllTempLabel];
        
        UILabel *windLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/2-100*widthPix)/2+kScreenWidth/2*i, CGRectGetMaxY(samllTempLabel.frame), 100*widthPix, 30*heightPix)];
        windLabel.font = [UIFont boldSystemFontOfSize:15*heightPix];
        windLabel.textColor = [UIColor whiteColor];
        windLabel.tag = 306+i;
        windLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:windLabel];
    }
    
    
}

-(void)setModel:(WeatherModel *)model {
    _model = model;
    
    UILabel *lbDay1 = (UILabel *)[self viewWithTag:300];
    UILabel *lbDay2 = (UILabel *)[self viewWithTag:301];
    UIImageView *imgWeather1 = (UIImageView *)[self viewWithTag:302];
    UIImageView *imgWeather2 = (UIImageView *)[self viewWithTag:303];
    UILabel *lbTemp1 = (UILabel *)[self viewWithTag:304];
    UILabel *lbTemp2 = (UILabel *)[self viewWithTag:305];
    UILabel *lbWind1 = (UILabel *)[self viewWithTag:306];
    UILabel *lbWind2 = (UILabel *)[self viewWithTag:307];

    lbCity.text = model.cityName;
    [self changeImageAnimatedWithView:imgWeather AndImage: [UIImage imageNamed:[model.todayDic objectForKey:@"code_day"]]];

    lbTemp.text = [NSString stringWithFormat:@"%@℃ / %@℃",[model.todayDic objectForKey:@"high"],[model.todayDic objectForKey:@"low"]];
    lbDay1.text = @"明天";
    [self changeImageAnimatedWithView:imgWeather1 AndImage: [UIImage imageNamed:[model.tomorrowDic objectForKey:@"code_day"]]];
    
    lbTemp1.text = [NSString stringWithFormat:@"%@℃/%@℃",[model.tomorrowDic objectForKey:@"high"],[model.tomorrowDic objectForKey:@"low"]];
    lbWind1.text = [NSString stringWithFormat:@"%@风 风速:%@",[model.tomorrowDic objectForKey:@"wind_direction" ],[model.tomorrowDic objectForKey:@"wind_speed"]];

    lbDay2.text = @"后天";
    [self changeImageAnimatedWithView:imgWeather2 AndImage: [UIImage imageNamed:[model.afterTomorrowDic objectForKey:@"code_day"]]];
    
    lbTemp2.text = [NSString stringWithFormat:@"%@℃/%@℃",[model.afterTomorrowDic objectForKey:@"high"],[model.afterTomorrowDic objectForKey:@"low"]];
    lbWind2.text = [NSString stringWithFormat:@"%@风 风速:%@",[model.afterTomorrowDic objectForKey:@"wind_direction" ],[model.afterTomorrowDic objectForKey:@"wind_speed"]];
}

//动画切换天气图标
- (void)changeImageAnimatedWithView:(UIImageView *)imageV AndImage:(UIImage *)image {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [imageV.layer addAnimation:transition forKey:@"a"];
    [imageV setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
