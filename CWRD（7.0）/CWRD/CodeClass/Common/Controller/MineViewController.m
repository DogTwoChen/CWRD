//
//  MineViewController.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "MineViewController.h"
#import "MyView.h"
#import "MyCollectionViewController.h"
#import "SwitchViewController.h"
#import "MoreViewController.h"
#import "CollectHandle.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    BlurImageView *blur = [[BlurImageView alloc] initWithFrame:kBounds];
    MyView *myView = [[MyView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [blur addSubview:myView];
    [self.view addSubview:blur];
    
    //我的界面里面的按钮添加方法
    [myView.myCollection addTarget:self action:@selector(myCollection) forControlEvents:UIControlEventTouchUpInside];
    
    [myView.mySwitch addTarget:self action:@selector(mySwitch) forControlEvents:UIControlEventTouchUpInside];
    
    [myView.more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myCollection) name:@"TouchID" object:nil];
}

//我的收藏界面
- (void)myCollection{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"TouchID"] integerValue] == 0) {
        
        //如果没有通过touchID验证
        if ([CollectHandle shareCollectVideo].isPassTouchID == NO) {
            
            //初始化
            LAContext *content = [[LAContext alloc] init];
            //  content.localizedFallbackTitle =LAPolicyDeviceOwnerAuthentication;
            NSError *error = nil;
            //设备支持TouchID
            if ([content canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                
                // Authenticate User
                [content evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请验证指纹" reply:^(BOOL success, NSError *error) {
                    
                    if (success) { //身份验证符合
                        //身份验证成功,跳转页面
                        MyCollectionViewController *myCollection = [[MyCollectionViewController alloc] init];
                        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:myCollection];
                        [self presentViewController:navC animated:YES completion:nil];
                        //单例存储
                        [CollectHandle shareCollectVideo].isPassTouchID = YES;
                        
                    }else { //身份验证不符合
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"身份验证未通过" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction*otherAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                            //NSLog(@"Okay");
                        }];
                        [alert addAction:otherAction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }];
                
                //设备不支持TouchID
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"您的设备不支持指纹验证" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    //NSLog(@"Okay");
                }];
                [alert addAction:otherAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            
            //如果已经通过touchID
        }else {
            MyCollectionViewController *myCollection = [[MyCollectionViewController alloc] init];
            UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:myCollection];
            [self presentViewController:navC animated:YES completion:nil];
        }
        
        
    }else {//(开关关闭)
        MyCollectionViewController *myCollection = [[MyCollectionViewController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:myCollection];
        [self presentViewController:navC animated:YES completion:nil];
    }
    
    
}



//开关界面
- (void)mySwitch{
    SwitchViewController *mySwitch = [[SwitchViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:mySwitch];
    [self presentViewController:navC animated:YES completion:nil];
}


//更多界面
- (void)more{
    MoreViewController *more = [[MoreViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:more];
    [self presentViewController:navC animated:YES completion:nil];
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
