//
//  BlogTableViewController.m
//  Yesterday
//
//  Created by guiping on 2017/5/9.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "BlogTableViewController.h"
#import "BlogDetailViewController.h"

@interface BlogTableViewController (){
    NSArray *titlesArray;
    NSMutableArray *urlsArray;
}

@end

@implementation BlogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titlesArray = @[@"唐巧",
                    @"王巍",
                    @"文顶顶",
                    @"池建强",
                    @"CocoaChina",
                    @"Code4App",
                    @"Git@OSC",
                    @"开源中国社区",
                    @"GitHub",
                    @"苹果Library"];
    
    urlsArray = [@[@"http://blog.devtang.com/blog/archives/",
                        @"http://www.onevcat.com",
                        @"http://www.cnblogs.com/wendingding/p/",
                        @"http://macshuo.com",
                        @"http://www.cocoachina.com",
                        @"http://www.code4app.com",
                        @"http://git.oschina.net",
                        @"http://www.oschina.net/code/list",
                        @"https://github.com",
                        @"https://developer.apple.com/library/mac/navigation/"] copy];
    
    
    //添加长按手势
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGR.minimumPressDuration = 0.5;
    [self.tableView addGestureRecognizer:longPressGR];
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        // 复制功能
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = urlsArray[indexPath.row];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"复制成功" message:pasteboard.string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *new = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:new];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titlesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mainCellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.text = titlesArray[indexPath.row];
    cell.detailTextLabel.text = urlsArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogDetailViewController *vc = [[BlogDetailViewController alloc] init];
    vc.author = titlesArray[indexPath.row];
    vc.url = urlsArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
