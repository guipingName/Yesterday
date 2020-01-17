//
//  RealViewController.h
//  pingui_dan
//
//  Created by guiping on 2017/12/11.
//  Copyright © 2017年 guiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealViewController : UIViewController

@property (nonatomic, copy) NSString *goddess;
@property (nonatomic, copy) NSString *yuyxin;
@end


@interface TTSConfig : NSObject
+(TTSConfig *)sharedInstance;

@property (nonatomic) NSString *speed;
@property (nonatomic) NSString *volume;
@property (nonatomic) NSString *pitch;
@property (nonatomic) NSString *sampleRate;
@property (nonatomic) NSString *vcnName;
@property (nonatomic) NSString *engineType;// the engine type of Text-to-Speech:"auto","local","cloud"


@property (nonatomic,strong) NSArray *vcnNickNameArray;
@property (nonatomic,strong) NSArray *vcnIdentiferArray;

@end
