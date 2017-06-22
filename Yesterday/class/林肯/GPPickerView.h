//
//  SliderView.h
//  Yesterday
//
//  Created by guiping on 2017/6/21.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPPickerView;
@protocol GPPickerViewDelegate <NSObject>

- (NSUInteger) numbersOfRows;

-(void)pickerView:(GPPickerView *)pickerView didSelectRow:(NSInteger)row;

- (UIView *)pickerView:(GPPickerView *)pickerView viewForRow:(NSInteger)row reusingView:(UIView *)view;

@end


@interface GPPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, weak) id<GPPickerViewDelegate> delegate;



- (void) reloadData;
@end
