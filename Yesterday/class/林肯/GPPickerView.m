//
//  SliderView.m
//  Yesterday
//
//  Created by guiping on 2017/6/21.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "GPPickerView.h"

#define UIWIDTH(pix)  pix * WIDTH / 1242
#define UIHEIGHT(pix) pix * HEIGHT / 2208

@interface GPPickerView(){
    UIView *topLineView;
    UIView *footLineView;
}



@property (nonatomic, assign) NSUInteger dataCount;

@end

@implementation GPPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
        
        topLineView =[[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, UIHEIGHT(36), 1, 11)];
        [self addSubview:topLineView];
        
        footLineView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, CGRectGetHeight(self.bounds) - 11 - UIHEIGHT(36), 1, 11)];
        [self addSubview:footLineView];
    }
    return self;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    topLineView.backgroundColor = textColor;
    footLineView.backgroundColor = textColor;
}

-(void)reloadData{
    [_pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    ((UIView *)[pickerView.subviews objectAtIndex:1]).hidden = YES;
    ((UIView *)[pickerView.subviews objectAtIndex:2]).hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:viewForRow:reusingView:)]) {
        return [self.delegate pickerView:self viewForRow:row reusingView:view];
    }
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numbersOfRows)]) {
        return [self.delegate numbersOfRows];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
        [self.delegate pickerView:self didSelectRow:row];
    }
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = (id<UIPickerViewDelegate>)self;
        _pickerView.dataSource = (id<UIPickerViewDataSource>)self;
        _pickerView.transform = CGAffineTransformMakeScale(1, 0.35);
        _pickerView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
        _pickerView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _pickerView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [_pickerView reloadAllComponents];
    }
    return _pickerView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
