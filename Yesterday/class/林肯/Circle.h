//
//  Circle.h
//  Yesterday
//
//  Created by guiping on 2017/6/20.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WorkMode){
    WorkModeNone,
    WorkModeOne,
    WorkModeTwo
};

@interface Circle : UIView

/**运行模式*/
@property (nonatomic, assign) WorkMode workMode;

- (void) startStroke;

@end
