//
//  WeatherModel.h
//  Yesterday
//
//  Created by guiping on 2017/6/8.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSDictionary *todayDic;
@property(nonatomic,strong)NSDictionary *tomorrowDic;
@property(nonatomic,strong)NSDictionary *afterTomorrowDic;

@end
