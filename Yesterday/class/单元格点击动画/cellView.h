//
//  cellView.h
//  scro
//
//  Created by guiping on 2017/8/30.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorCell;
@protocol colorChangedDelegate <NSObject>

- (void) didSelectedItem:(ColorCell *) cell;

@end

@interface ColorCell : UIView

@property (nonatomic, assign) u_int8_t colorId;

- (void)setColordata:(NSArray *) dataArray;

- (void) isShowAnimation:(BOOL) isSelected;

@property (nonatomic, weak) id<colorChangedDelegate> delegate;

@end
