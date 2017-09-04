//
//  CityListViewController.m
//  Yesterday
//
//  Created by guiping on 2017/8/23.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "CityListViewController.h"
#import "Masonry.h"

@interface CityListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UILabel *currentCity;
}
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) UIView *tbHeaderView;
/**
 *  当前城市数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

/**
 *  索引数据源
 */
@property (nonatomic, strong) NSMutableArray *indexSourceArr;
@end


@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDatasource];
    [self initSubViews];
}

- (void)initDatasource
{
    self.dataSourceArr = [[NSMutableArray alloc]init];
    self.indexSourceArr = [[NSMutableArray alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *cityArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    _dataSourceArr = [self sortArray:cityArr];
    [_dataSourceArr insertObject:@"热门城市" atIndex:0];
    [_indexSourceArr insertObject:@"热门" atIndex:0];
}
- (void)initSubViews
{
    self.title = @"选择城市";
    [self.view addSubview:self.searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(54);
    }];
    [self.view addSubview:self.tbView];
    [_tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
    _tbView.sectionIndexColor = [UIColor blackColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tbView reloadData];
}

- (NSMutableArray *)sortArray:(NSMutableArray *)originalArray
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //根据拼音对数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //排序
    [originalArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArray = nil;
    BOOL flag = NO;
    
    //分组
    for (int i = 0;i < originalArray.count; i++) {
        NSString *pinyin = [originalArray[i] objectForKey:@"pinyin"];
        NSString *firstChar = [pinyin substringToIndex:1];
        if (![_indexSourceArr containsObject:[firstChar uppercaseString]]) {
            [_indexSourceArr addObject:[firstChar uppercaseString]];
            tempArray = [[NSMutableArray alloc]init];
            flag = NO;
        }
        if ([_indexSourceArr containsObject:[firstChar uppercaseString]]) {
            [tempArray addObject:originalArray[i]];
            if (flag == NO) {
                [array addObject:tempArray];
                flag = YES;
            }
        }
    }
    return array;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [self.dataSourceArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"热门城市";
    }
    return [_indexSourceArr objectAtIndex:section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexSourceArr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [HotCityCell cellHeight];
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HotCityCell *cell = [HotCityCell new];
        return cell;
    }
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    cell.textLabel.text = [[self.dataSourceArr[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - 延时加载
-(UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [UITableView new];
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = self.tbHeaderView;
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.delegate = self;
        _tbView.dataSource = self;
    }
    return _tbView;
}

- (UIView *)tbHeaderView
{
    if (!_tbHeaderView) {
        _tbHeaderView = [UIView new];
        _tbHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 54);
        currentCity = [UILabel new];
        currentCity.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        currentCity.text = @"当前城市-成都";
        [_tbHeaderView addSubview:currentCity];
        [currentCity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tbHeaderView).offset(10);
            make.centerY.equalTo(_tbHeaderView);
        }];
    }
    return _tbHeaderView;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [UIView new];
        UISearchBar *searchBar = [UISearchBar new];
        searchBar.placeholder = @"城市名/拼音";
        searchBar.backgroundColor = [UIColor clearColor];
        searchBar.barTintColor = [UIColor whiteColor];
        [_searchView addSubview:searchBar];
        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchView).offset(10);
            make.bottom.equalTo(_searchView).offset(-10);
            make.left.equalTo(_searchView).offset(5);
            make.right.equalTo(_searchView).offset(-5);
        }];
        for (UIView *subView in searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"城市/拼音"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                }
            }
        }
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithRed:250/255.0 green:240/255.0 blue:230/255.0 alpha:1.0];
        [_searchView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_searchView);
            make.height.mas_equalTo(1);
        }];
    }
    return _searchView;
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

#define LBTAG 100
#define CELLHEIGHT 219
@interface HotCityCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *datasource;
@end

@implementation HotCityCell

+(CGFloat)cellHeight
{
    return CELLHEIGHT;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.datasource = @[@"上海", @"北京", @"广州", @"深圳", @"成都", @"重庆", @"天津", @"杭州", @"南京", @"苏州", @"西安", @"台北"];
        [self.collectionView reloadData];
    }
    return self;
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


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView.scrollEnabled = NO;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [self colorFromHexString:@"#D6D5D9"];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


#pragma mark - CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *titleLb = [UILabel new];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    titleLb.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    titleLb.text = _datasource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 29)/ 3, (CELLHEIGHT - 3)/4);
}
@end
