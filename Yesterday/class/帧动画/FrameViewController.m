//
//  FrameViewController.m
//  GPAnimation
//
//  Created by guiping on 2017/5/5.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import "FrameViewController.h"

@interface FrameViewController (){
    UIImageView *scanImage;
    NSTimer *timer;
}


@end

@implementation FrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAnimationView];
}

- (void)createAnimationView{
    NSMutableArray *images = [NSMutableArray array];
    for (int i=1; i<10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p03_icon_camera%d_n_01", i>6?12-i:i]];
        [images addObject:image];
    }
    
    UIImage *img = [UIImage imageNamed:@"p03_icon_camera1_n_01"];
    UIImageView *tempImage = [[UIImageView alloc] initWithImage:img];
    tempImage.frame = CGRectMake(200, 300, img.size.width, img.size.height);
    [self.view addSubview:tempImage];
    
    scanImage = [[UIImageView alloc]init];
    scanImage.frame = CGRectMake(200, 300, img.size.width, img.size.height);
    scanImage.animationImages = images;
    scanImage.animationDuration = 0.618;
    scanImage.animationRepeatCount = 1;
    [self.view addSubview:scanImage];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.8 target:self selector:@selector(scanImageStartAnimation) userInfo:nil repeats:YES];
    
    NSArray *scanNoticeArr = @[@"p03_img_qp1_n_01",@"p03_img_qp2_n_01"];
    UIImage *noticeImage = [UIImage imageNamed:scanNoticeArr[arc4random() % scanNoticeArr.count]];
    UIImageView *scanNotice = [[UIImageView alloc] initWithImage:noticeImage];
    scanNotice.frame = CGRectMake(70, 300, noticeImage.size.width, noticeImage.size.height);
    [self.view addSubview:scanNotice];
    
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationRepeatCount:HUGE_VALF];
    [UIView setAnimationRepeatAutoreverses:YES];
    
    CGPoint center = scanNotice.center;
    if(center.y > 30.0f) {
        center.y -= 15.0f;
        scanNotice.center = center;
    } else {
        center.y += 15.0f;
        scanNotice.center = center;
    }
    [UIView commitAnimations];
}

- (void)scanImageStartAnimation{
    [scanImage startAnimating];
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
