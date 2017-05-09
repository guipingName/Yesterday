//
//  MyTableViewCell.h
//  GPAnimation
//
//  Created by guiping on 2017/4/18.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFoldCell.h"

@interface MyTableViewCell : CCFoldCell

@property (nonatomic, weak) IBOutlet UILabel *closeNumberLabel;

@property (nonatomic, weak) IBOutlet UILabel *openNumberLabel;

- (void)setNumber:(NSInteger)number;

@end
