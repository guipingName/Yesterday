//
//  cellClickedViewController.h
//  Yesterday
//
//  Created by guiping on 2017/9/1.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    AIR_LED_DEFAULT_COLOR = 0,		// 熄灭
    AIR_LED_RED_COLOR,			//红色
    AIR_LED_GREEN_COLOR,		//绿色
    AIR_LED_BLUE_COLOR,			//蓝色
    AIR_LED_YELLOW_COLOR,		//黄色
    AIR_LED_PURPLE_COLOR,		//紫色
    AIR_LED_LIGHT_BLUE_COLOR,     //浅蓝色
    AIR_LED_WHITE_COLOR			//白色
}COLOR_T;

@interface cellClickedViewController : BaseViewController

@end
