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
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    if (indexPath.row < 9) {
        cell.lbNumber.text = [NSString stringWithFormat:@"0%ld",indexPath.row + 1];
    }else {
        cell.lbNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }
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
                  @"Quartz2D",
                  @"博客",
                  @"林肯控制界面",
                  nil];
    
    describeArray = [NSArray arrayWithObjects:
                     @"模态出一个透明的视图控制器，可做半屏窗口",
                     @"某个点产生冲击波效果的动画",
                     @"玻璃瓶里水波滚动型progress",
                     @"核心动画测试",
                     @"帧动画",
                     @"单元格展开收起",
                     @"绘制直线、圆、曲线。。。",
                     @"Quartz绘制直线、圆、矩形",
                     @"大牛们写的博客",
                     @"控制林肯设备",
                     nil];
    
    classArray = [NSArray arrayWithObjects:
                  @"BasicViewController",
                  @"ShockWaveController",
                  @"WaveProgressController",
                  @"CoreAnimationController",
                  @"FrameViewController",
                  @"TableViewController",
                  @"BezierPathViewController",
                  @"Quartz2DViewController",
                  @"BlogTableViewController",
                  @"likonViewController",
                  nil];
    
    [self.myTableView reloadData];
}

#pragma mark --------------- 懒加载 ----------------
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_myTableView];
        [_myTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _myTableView;
}

@end
