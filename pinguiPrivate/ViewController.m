//
//  ViewController.m
//  pinguiPrivate
//
//  Created by guiping on 2018/8/16.
//  Copyright © 2018年 pingui. All rights reserved.
//

#import "ViewController.h"
#import "RealViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
{
    UIButton *btn3;
    NSUInteger clickCount;
    NSDate *optDate;
    NSUInteger goCount;
    NSDate *gaDate;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self createSubViews];
    [self login];
    //[self loginright];
    
    UIButton *btns = [[UIButton alloc] initWithFrame:CGRectMake(270, 30, 40, 40)];
    [self.view addSubview:btns];
    btns.backgroundColor = [UIColor whiteColor];
    [btns addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClicked:(UIButton *) sender
{
    clickCount++;
    if (optDate && [[NSDate date] timeIntervalSinceDate:optDate] > 3) {
        clickCount = 1;
    }
    optDate = [NSDate date];
    if (clickCount > 7) {
        clickCount = 0;
        [self inputKeyWords];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) presentYanhuaVC:(UIButton *) sender{
    goCount++;
    if (gaDate && [[NSDate date] timeIntervalSinceDate:gaDate] > 3) {
        goCount = 1;
    }
    gaDate = [NSDate date];
    if (goCount > 7) {
        goCount = 1;
        RealViewController *vc = [[RealViewController alloc] init];
        vc.goddess = @"XX，我爱你";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) inputKeyWords{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你想说什么呢？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *userEmail = alert.textFields.firstObject;
        if (userEmail.text.length > 0) {
            if (userEmail.text.length < 8) {
                RealViewController *vc = [[RealViewController alloc] init];
                vc.goddess = @"XX，我爱你";
                vc.yuyxin = userEmail.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UIAlertController *cant = [UIAlertController alertControllerWithTitle:@"！！！言简意赅！！！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [cant addAction:okAction];
                [self presentViewController:cant animated:YES completion:nil];
            }
        }else{
            UIAlertController *cant = [UIAlertController alertControllerWithTitle:@"不带这么懒的~" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新来" style:UIAlertActionStyleDefault handler:nil];
            [cant addAction:okAction];
            [self presentViewController:cant animated:YES completion:nil];
        }
    }];
    [alert addAction:okAction];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIButton *)defaultButtonWithNormalImage:(UIImage *)normalImage
                          highlightedImage:(UIImage *)highlightedImage
                             disabledImage:(UIImage *)disabledImage
                             selectedImage:(UIImage *)selectedImage
                                     frame:(CGRect)frame
                                    target:(id)target
                                  selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (!button) {
        return nil;
    }
    
    button.backgroundColor = [UIColor clearColor];
    button.frame = frame;
    
    /* 在此之前，也许需要将Highlighted和Selected的图片设置成Normal的 */
    if (normalImage) {
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    if (disabledImage) {
        [button setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    }
    
    if (selectedImage) {
        [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
    }
    
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

- (void)addBarItemRightButton:(UIButton*)btn
{
    UIBarButtonItem* bi;
    bi = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -12;
    [self.navigationItem setRightBarButtonItems:@[negativeSeperator,bi]];
}

- (void) loginright{
    btn3.hidden = NO;
}


- (void) login{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //这个设置的使用密码的字体，当text=@""时，按钮将被隐藏
    context.localizedFallbackTitle=@"";
    //这个设置的取消按钮的字体
    context.localizedCancelTitle=@"取消";
    //错误对象
    NSError* error = nil;
    NSString* result = @"请验证已有的指纹，用于启动App";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loginright];
                });
            }else {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self alertPasswordagin:NO];
                        });
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择其他验证方式，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [self alertPasswordagin:NO];
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self alertPasswordagin:NO];
                });
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self alertPasswordagin:NO];
                });
                break;
            }
        }
        //NSLog(@"%@",error.localizedDescription);
    }
}

- (void) createSubViews{
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(self.view.bounds.size.width - 80, self.view.bounds.size.height - 80, 80, 80);
    [btn3 setTitle:@"🍊" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(presentYanhuaVC:) forControlEvents:UIControlEventTouchUpInside];
    btn3.hidden = YES;
}

- (void) alertPasswordagin:(BOOL) agin{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:agin?@"密码错误，请重新输入":@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //配置textField的属性
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *userEmail = alert.textFields.firstObject;
        if ([userEmail.text isEqualToString:@"654321"]) {
            [self loginright];
        }else{
            [self alertPasswordagin:YES];
        }
    }];
    [alert addAction:okAction];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end





