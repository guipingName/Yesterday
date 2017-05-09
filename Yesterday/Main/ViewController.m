//
//  ViewController.m
//  yesterday
//
//  Created by guiping on 2017/5/9.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleArray;
    NSArray *describeArray;
    NSArray *classArray;
}
@property (nonatomic, strong) UITableView *myTableView;

@end

static NSString *identifier = @"ListTableViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = THEME_COLOR;
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    self.title = @"目 录";
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.lbTitle.text = titleArray[indexPath.row];
    cell.lbDescribe.text = describeArray[indexPath.row];
    cell.lbNumber.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tempStr = classArray[indexPath.row];
    Class class = NSClassFromString(tempStr);
    UIViewController *vc = [[class alloc]init];
    vc.title = titleArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --------------- 数据 ----------------
- (void) loadData{
    titleArray = [NSArray arrayWithObjects:
                  @"模态透明视图控制器",
                  @"冲击波动画",
                  @"水波球型进度条",
                  @"核心动画测试",
                  @"帧动画",
                  @"taleView单元格向下展开",
                  @"贝塞尔曲线",
                  nil];
    
    describeArray = [NSArray arrayWithObjects:
                     @"模态出一个透明的视图控制器，可做半屏窗口",
                     @"某个点产生冲击波效果的动画",
                     @"玻璃瓶里水波滚动型progress",
                     @"核心动画测试",
                     @"帧动画",
                     @"单元格展开收起",
                     @"绘制直线、圆、曲线。。。",
                     nil];
    
    classArray = [NSArray arrayWithObjects:
                  @"BasicViewController",
                  @"ShockWaveController",
                  @"WaveProgressController",
                  @"CoreAnimationController",
                  @"FrameViewController",
                  @"TableViewController",
                  @"BezierPathViewController",
                  nil];
    
    [self.myTableView reloadData];
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64)];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [self.view addSubview:_myTableView];
        [_myTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _myTableView;
}

@end