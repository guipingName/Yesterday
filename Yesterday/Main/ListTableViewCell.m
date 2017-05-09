//
//  ListTableViewCell.m
//  GPAnimation
//
//  Created by guiping on 2017/4/18.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell{
    UIView *lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_lbTitle) {
            _lbTitle = [[UILabel alloc] init];
            _lbTitle.font = [UIFont systemFontOfSize:18];
            _lbTitle.textColor = [UIColor blackColor];
            [self.contentView addSubview:_lbTitle];
        }
        if (!_lbDescribe) {
            _lbDescribe = [[UILabel alloc] init];
            _lbDescribe.font = [UIFont systemFontOfSize:14];
            _lbDescribe.textColor = [UIColor grayColor];
            [self.contentView addSubview:_lbDescribe];
        }
        if (!lineView) {
            lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
            [self.contentView addSubview:lineView];
        }
        if (!_lbNumber) {
            _lbNumber = [[UILabel alloc] init];
            [self.contentView addSubview:_lbNumber];
            _lbNumber.textColor = [UIColor whiteColor];
            _lbNumber.font = [UIFont systemFontOfSize:14];
            _lbNumber.backgroundColor = THEME_COLOR;
            _lbNumber.textAlignment = NSTextAlignmentCenter;
            _lbNumber.layer.masksToBounds = YES;
        }
    }
    return self;
}

-(void)layoutSubviews{
    _lbTitle.frame = CGRectMake(50, 10, self.bounds.size.width, 30);
    _lbDescribe.frame = CGRectMake(50, 35, self.bounds.size.width, 20);
    lineView.frame = CGRectMake(25, 0, 1, self.bounds.size.height);
    _lbNumber.frame = CGRectMake(10, self.bounds.size.height / 2 - 15, 30, 30);
    _lbNumber.layer.cornerRadius = 15;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
