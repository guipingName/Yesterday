//
//  ChangeColorCell.h
//  Yesterday
//
//  Created by guiping on 2017/9/1.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <UIKit/UIKit.h>

#define pix(x) WIDTH * x / 375.0
#define piy(y) HEIGHT * y / 667.0

@interface ChangeColorCell : UICollectionViewCell

- (void)setColordata:(NSArray *) dataArray;

- (void) isShowAnimation:(BOOL) isSelected;

@end
