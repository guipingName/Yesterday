//
//  cellClickedViewController.m
//  Yesterday
//
//  Created by guiping on 2017/9/1.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "cellClickedViewController.h"
#import "ChangeColorCell.h"
#import "cellView.h"


@interface cellClickedViewController (){
    UIView *bgView;
    UIView *colorView;
    UICollectionView *colorCollectionView;
    UIScrollView *scrollView;
    NSMutableArray *dataArray;
    u_int8_t selectColorId;
    UILabel *label;
}

@end

@implementation cellClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"ScrollView方式实现", @"CollectionView方式实现"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH - pix(280)) / 3 + (140 + (WIDTH - pix(280)) / 3) * i, 100, pix(140), 30);
        [self.view addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    label = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH - 80) / 2, 180, 80, 40)];
    [self.view addSubview:label];
    [self loadColorData];
}

- (void) buttonClicked:(UIButton *) sender{
    bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelChangeColorView:)];
    tap.delegate = (id<UIGestureRecognizerDelegate>)self;
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    colorView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bounds.size.height, bgView.bounds.size.width, piy(180))];
    colorView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:colorView];
    
    if ([sender.titleLabel.text isEqualToString:@"CollectionView方式实现"]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = pix(46);
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(pix(48), piy(68));
        layout.sectionInset = UIEdgeInsetsMake(piy(32), pix(23), piy(31), pix(23));
        
        colorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, colorView.bounds.size.width, piy(131)) collectionViewLayout:layout];
        colorCollectionView.backgroundColor = [UIColor whiteColor];
        colorCollectionView.bounces = NO;
        colorCollectionView.showsHorizontalScrollIndicator = NO;
        [colorView addSubview:colorCollectionView];
        
        [colorCollectionView registerClass:[ChangeColorCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        colorCollectionView.dataSource = (id<UICollectionViewDataSource>)self;;
        colorCollectionView.delegate = (id<UICollectionViewDelegate>)self;
        [colorCollectionView reloadData];
        if (selectColorId > 3) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [colorCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            });
        }
    }
    else{
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, colorView.bounds.size.width, piy(131))];
        [colorView addSubview:scrollView];
        
        for (int i=0; i<dataArray.count; i++) {
            ColorCell *view = [[ColorCell alloc] initWithFrame:CGRectMake(pix(23)+pix(94) * i, piy(32), pix(48), piy(68))];
            view.delegate = (id<colorChangedDelegate>)self;
            [view setColordata:dataArray[i]];
            if (i==selectColorId) {
                [view isShowAnimation:YES];
            }
            else{
                [view isShowAnimation:NO];
            }
            [scrollView addSubview:view];
        }
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(pix(94)*8, piy(131));
        if (selectColorId > 3) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [scrollView setContentOffset:CGPointMake(pix(94)*4, 0) animated:YES];
            });
        }
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, piy(131), colorView.bounds.size.width, 1)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [colorView addSubview:line];
    
    NSArray *buttonNames = @[@"取消", @"确定"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(colorView.bounds.size.width * i / 2, colorView.bounds.size.height - piy(48), colorView.bounds.size.width / 2, piy(48));
        [colorView addSubview:button];
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.2] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.1] andSize:CGSizeMake(button.bounds.size.width, button.bounds.size.height)] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(changeColorViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    line = [[UIView alloc] initWithFrame:CGRectMake(colorView.bounds.size.width / 2 - 0.5, colorView.bounds.size.height - piy(48), 1, piy(48))];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [colorView addSubview:line];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect originFrame = colorView.frame;
        originFrame.origin.y -= piy(180);
        colorView.frame = originFrame;
    }];
}

- (void) didSelectedItem:(ColorCell *) cell{
    if (cell.colorId == selectColorId) {
        return;
    }
    selectColorId = cell.colorId;
    for (UIView *ss in scrollView.subviews) {
        if ([ss isKindOfClass:[ColorCell class]]) {
            ColorCell *sa = (ColorCell *) ss;
            [sa isShowAnimation:NO];
        }
    }
    [cell isShowAnimation:YES];
}

- (void) cancelChangeColorView:(UITapGestureRecognizer *) sender{
    [self cancelColorView];
}

- (void) changeColorViewButtonClicked:(UIButton *) sender{
    [self cancelColorView];
    if ([sender.titleLabel.text isEqualToString:@"确定"]) {
        label.backgroundColor = [self colorFromHexString:dataArray[selectColorId][1]];
    }
    else{
        
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:colorView]) {
        return NO;
    }
    return YES;
}

-(void) cancelColorView{
    [UIView animateWithDuration:0.3 animations:^{
        bgView.backgroundColor = [UIColor clearColor];
        CGRect originFrame = colorView.frame;
        originFrame.origin.y += piy(180);
        colorView.frame = originFrame;
        
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        bgView = nil;
    }];
}

- (void) loadColorData{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    NSArray *  lightColorArray = @[@[@(AIR_LED_DEFAULT_COLOR),@"606060",(@"默认")],
                                   @[@(AIR_LED_RED_COLOR),@"ff3b6c",(@"红色")],
                                   @[@(AIR_LED_GREEN_COLOR),@"1fef2e",(@"绿色")],
                                   @[@(AIR_LED_BLUE_COLOR),@"2b5fff",(@"蓝色")],
                                   @[@(AIR_LED_YELLOW_COLOR),@"ffd200",(@"黄色")],
                                   @[@(AIR_LED_PURPLE_COLOR),@"de6eff",(@"紫色")],
                                   @[@(AIR_LED_LIGHT_BLUE_COLOR),@"2cf1ff",(@"青色")],
                                   @[@(AIR_LED_WHITE_COLOR),@"ffffff",(@"白色")]
                                   ];
    dataArray = [lightColorArray mutableCopy];
    selectColorId = arc4random() % 8;
    label.backgroundColor = [self colorFromHexString:dataArray[selectColorId][1]];
}

#pragma mark UICollectionViewDataSource回调方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ChangeColorCell *cel = (ChangeColorCell *)cell;
    if (selectColorId == [dataArray[indexPath.row][0] integerValue]) {
        [cel isShowAnimation:YES];
    }else{
        [cel isShowAnimation:NO];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChangeColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setColordata:dataArray[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    u_int8_t colorId = [dataArray[indexPath.row][0] integerValue];
    
    if (selectColorId == colorId) {
        return;
    }
    selectColorId = colorId;
    [colorCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0f green:((rgbValue & 0xFF00) >> 8)/255.0f blue:(rgbValue & 0xFF)/255.0f alpha:1.0];
    return color;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
