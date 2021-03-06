//
//  BlogDetailViewController.m
//  Yesterday
//
//  Created by guiping on 2017/5/9.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "BlogDetailViewController.h"
#import <WebKit/WebKit.h>


#define WEBVIEWPROGRESS     @"estimatedProgress"

@interface BlogDetailViewController ()<WKUIDelegate, WKNavigationDelegate>
{
    UIProgressView *progressView;
    WKWebView *webView;
}

@end

@implementation BlogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = _author;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 1)];
    [progressView setValue:[UIColor redColor] forKey:@"progressTintColor"];
    [progressView setValue:[UIColor whiteColor] forKey:@"trackTintColor"];
    [self.view addSubview:progressView];
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 65, WIDTH, HEIGHT - 65)];
    [self.view addSubview:webView];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:WEBVIEWPROGRESS options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:WEBVIEWPROGRESS] && object == webView) {
        [progressView setAlpha:1.0f];
        [progressView setProgress:webView.estimatedProgress animated:YES];
        if(webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [webView removeObserver:self forKeyPath:WEBVIEWPROGRESS];
    webView.UIDelegate = nil;
    webView.navigationDelegate = nil;
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
