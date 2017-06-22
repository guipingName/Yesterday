//
//  likonViewController.m
//  Yesterday
//
//  Created by guiping on 2017/5/11.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "likonViewController.h"
#import "Circle.h"
#import "GPPickerView.h"

#define TAG_BUTTON_START 500

typedef NS_ENUM(NSUInteger, OperateButton){
    OperateButtonNone,
    OperateButtonOnOff,
    OperateButtonYaotou,
    OperateButtonTime,
    OperateButtonMode,
    OperateButtonWind,
    OperateButtonMax
};

@interface likonViewController ()

#define UIWIDTH(pix)  pix * WIDTH / 1242
#define UIHEIGHT(pix) pix * HEIGHT / 2208

#define LIKON_COLOR [UIColor colorWithRed:0/255.0 green:174/255.0 blue:225/255.0 alpha:1]

@property (nonatomic, strong) UIView *bgView;

@end

@implementation likonViewController{
    UIImageView *navigationImageView;
    UILabel *lbShidu;           // 湿度
    UILabel *lbTemp;            // 温度
    UILabel *lbStatus;          // 状态
    UIImageView *IVElectric;    // 电量
    UIImageView *IVChild;       // 童锁
    UIImageView *IVYaotou;      // 摇头
    UIImageView *IVWind;        // 风
    
    UILabel *lbTemperature;
    Circle *circle;
    
    NSMutableArray *dataArray;
}

-(instancetype)init{
    if (self = [super init]) {
        self.title = @"悟空i8";
        self.tabBarItem.title = @"遥控面板";
        self.tabBarItem.image = [UIImage imageNamed:@"遥控面板"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"遥控面板选中"];
    }
    return self;
}

- (void) back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = LIKON_COLOR;
    
    navigationImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.view addSubview:self.bgView];
    
    circle = [[Circle alloc] initWithFrame:CGRectMake((WIDTH - UIHEIGHT(831)) / 2, UIHEIGHT(59), UIHEIGHT(831), UIHEIGHT(831))];
    [self.view addSubview:circle];
    [circle startStroke];
    
    lbTemperature = [[UILabel alloc] init];
    [circle addSubview:lbTemperature];
    lbTemperature.font = [UIFont systemFontOfSize:50];
    lbTemperature.textAlignment = NSTextAlignmentCenter;
    lbTemperature.textColor = [UIColor whiteColor];
    lbTemperature.text = @"23℃";
    CGRect lbTempR = [self attributedLabel:lbTemperature String:@"℃" firstSize:80 lastSize:40];
    lbTemperature.frame = CGRectMake((circle.bounds.size.width - lbTempR.size.width) / 2, circle.bounds.size.height / 2 - 20, lbTempR.size.width, lbTempR.size.height);
    
    UIImageView *IVShidu = [[UIImageView alloc] initWithFrame:CGRectMake(circle.bounds.size.width/2 - 40, UIHEIGHT(200), 20, 20)];
    [circle addSubview:IVShidu];
    IVShidu.image = [UIImage imageNamed:@"i8_湿度"];
    
    UIImageView *IVTemp = [[UIImageView alloc] initWithFrame:CGRectMake(circle.bounds.size.width/2 + 20, CGRectGetMinY(IVShidu.frame), 20, 20)];
    [circle addSubview:IVTemp];
    IVTemp.image = [UIImage imageNamed:@"i8_室温"];
    
    lbShidu = [[UILabel alloc] initWithFrame:CGRectMake(circle.bounds.size.width/2 - 50, CGRectGetMaxY(IVShidu.frame), 40, 25)];
    [circle addSubview:lbShidu];
    lbShidu.font = [UIFont systemFontOfSize:13];
    lbShidu.textAlignment = NSTextAlignmentCenter;
    lbShidu.textColor = [UIColor whiteColor];
    lbShidu.text = @"70%";
    
    lbTemp = [[UILabel alloc] initWithFrame:CGRectMake(circle.bounds.size.width/2 + 15, CGRectGetMaxY(IVTemp.frame), 40, 25)];
    [circle addSubview:lbTemp];
    lbTemp.font = [UIFont systemFontOfSize:13];
    lbTemp.textAlignment = NSTextAlignmentCenter;
    lbTemp.textColor = [UIColor whiteColor];
    lbTemp.text = @"27℃";
    
    lbStatus = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lbTemperature.frame) - 30, CGRectGetMinY(lbTemperature.frame) + 10, 40, 25)];
    [circle addSubview:lbStatus];
    lbTemp.font = [UIFont systemFontOfSize:16];
    lbStatus.textAlignment = NSTextAlignmentLeft;
    lbStatus.textColor = [UIColor whiteColor];
    lbStatus.text = @"制冷";
    
    CGFloat w = (WIDTH - UIWIDTH(242) - 4 * 25) / 3;
    IVElectric = [[UIImageView alloc] initWithFrame:CGRectMake(UIWIDTH(121), CGRectGetMaxY(_bgView.frame) - UIHEIGHT(51) - 25, 20, 20)];
    [_bgView addSubview:IVElectric];
    IVElectric.image = [UIImage imageNamed:@"i8_湿度"];
    
    IVChild = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(IVElectric.frame) + w, CGRectGetMinY(IVElectric.frame), 20, 20)];
    [_bgView addSubview:IVChild];
    IVChild.image = [UIImage imageNamed:@"情景遥控锁_控制"];
    
    IVYaotou = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(IVChild.frame) + w, CGRectGetMinY(IVElectric.frame), 20, 20)];
    [_bgView addSubview:IVYaotou];
    IVYaotou.image = [UIImage imageNamed:@"学习_摆风"];
    
    IVWind = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(IVYaotou.frame) + w, CGRectGetMinY(IVElectric.frame), 20, 20)];
    [_bgView addSubview:IVWind];
    IVWind.image = [UIImage imageNamed:@"i8_风速无"];
    
    GPPickerView *pickerView = [[GPPickerView alloc] initWithFrame:CGRectMake(0, UIHEIGHT(1095), WIDTH, UIHEIGHT(269))];
    pickerView.delegate = (id<GPPickerViewDelegate>)self;
    pickerView.textColor = LIKON_COLOR;
    [self.view addSubview:pickerView];
    [self initData];
    [pickerView reloadData];
    [pickerView.pickerView selectRow:3 inComponent:0 animated:YES];
    
    
    NSArray *imageNamesN = @[@"i8_on",@"i8_开关",@"i8_摆头",@"i8_定时",@"i8_模式",@"i8_风速"];
    NSArray *imageNamesH = @[@"bimarBtn定时_gray",@"bimarBtn开关_gray",@"bimarBtn温度加_gray",@"bimarBtn风速_gray",@"bimarBtn模式_gray",@"bimarBtn温度减_gray"];
    for (int i=0; i<OperateButtonMax; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        button.frame = CGRectMake((i % 3) * UIWIDTH(414) , UIHEIGHT(1364) + (i / 3) * UIHEIGHT(252), UIWIDTH(414), UIHEIGHT(252));
        button.backgroundColor = UICOLOR_RGBA(255, 255, 255, 0.25);
        button.layer.borderWidth = 1;
        button.tag = TAG_BUTTON_START + i;
        button.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
        [button setImage:[UIImage imageNamed:imageNamesN[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNamesH[i]] forState:UIControlStateDisabled];
        [button setImage:[UIImage imageNamed:imageNamesH[i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) operationButtonClicked:(UIButton *) sender{
    
    int aa = (int)sender.tag - TAG_BUTTON_START;
    switch (aa) {
        case OperateButtonMode:
        {
            static int i = 0;
            circle.workMode = i%3;
            i++;
        }
            break;
        case OperateButtonYaotou:
        {
            static int i = 0;
            IVYaotou.image = [UIImage imageNamed:i%2==0?@"i8_摆头关":@"学习_摆风"];
            i++;
        }
            break;
        case OperateButtonWind:
        {
            NSArray *imageNames = @[@"i8_风速低", @"i8_风速中", @"i8_风速高", @"i8_风速自动1", @"i8_风速自动2", @"i8_风速自动3", @"i8_风速自动", @"i8_风速无"];
            static int i = 0;
            IVWind.image = [UIImage imageNamed:imageNames[i%imageNames.count]];
            i++;
        }
            break;
        default:
            break;
    }
}

- (void) initData{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    for (int i=0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"%d℃",i + 20];
        [dataArray addObject:str];
    }
}

-(NSUInteger) numbersOfRows{
    return dataArray.count;
}

- (UIView *)pickerView:(GPPickerView *)pickerView viewForRow:(NSInteger)row reusingView:(UIView *)view{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:view.bounds];
    titleLabel.center = view.center;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:23];
    titleLabel.textColor = LIKON_COLOR;
    titleLabel.transform =  CGAffineTransformMakeRotation(M_PI_2);
    titleLabel.text = dataArray[row];
    return titleLabel;
}
-(void)pickerView:(GPPickerView *)pickerView didSelectRow:(NSInteger)row{
    lbTemperature.text = dataArray[row];
    CGRect lbTempR = [self attributedLabel:lbTemperature String:@"℃" firstSize:80 lastSize:40];
    lbTemperature.frame = CGRectMake((circle.bounds.size.width - lbTempR.size.width) / 2, circle.bounds.size.height / 2 - 20, lbTempR.size.width, lbTempR.size.height);
}



- (CGRect) attributedLabel:(UILabel *) label String:(NSString *) searchString firstSize:(CGFloat) firstSize lastSize:(CGFloat) lastSize{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSRange ra = [label.text rangeOfString:searchString];
    if (ra.location != NSNotFound) {
        NSRange range = NSMakeRange(0, ra.location);
        //[noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:firstSize] range:range];
        NSRange range1 = NSMakeRange(ra.location, ra.length);
        //[noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:lastSize] range:range1];
    }
    else{
        
    }
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect labelRect = [noteStr boundingRectWithSize:CGSizeMake(150, CGFLOAT_MAX) options:options context:nil];
    //NSLog(@"size:%@", NSStringFromCGSize(labelRect.size));
    label.attributedText = noteStr;
    return labelRect;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navigationImageView.hidden = YES;
}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UIHEIGHT(1095))];
        _bgView.backgroundColor = LIKON_COLOR;
    }
    return _bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
