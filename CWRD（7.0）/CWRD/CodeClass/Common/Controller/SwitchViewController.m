//
//  SwitchViewController.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "SwitchViewController.h"
#import "CoreStatus.h"
#import "CALayer+Transition.h"
#import "CollectHandle.h"
@interface SwitchViewController ()<UIAlertViewDelegate, CoreStatusProtocol>

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"功能开关";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor],NSForegroundColorAttributeName, nil]];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self addView];
}

- (void)addView{
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWidth , 30)];
    name.text = @"| 使用流量时通知我 |";
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont boldSystemFontOfSize:17.0];
    [self.view addSubview:name];
    
    NYSegmentedControl *nameSwitch = [[NYSegmentedControl alloc] initWithItems:@[@"打开",@"关闭"]];
    nameSwitch.backgroundColor = [UIColor grayColor];
    nameSwitch.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    nameSwitch.titleTextColor = [UIColor whiteColor];
    nameSwitch.selectedTitleTextColor = [UIColor blackColor];
    [nameSwitch sizeToFit];
    //添加委托方法
    [nameSwitch addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
    
    nameSwitch.frame = CGRectMake(kWidth / 4, 100, kWidth / 2 , 30);
    nameSwitch.center = CGPointMake(kWidth / 2, 100);
    [self.view addSubview:nameSwitch];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, kWidth , 30)];
    label.text = @"|     清除所有缓存     |";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17.0];
    [self.view addSubview:label];

    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    clear.frame = CGRectMake(kWidth / 4, 190, kWidth / 2 , 30);
    [clear.layer setMasksToBounds:YES];
    [clear.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    [clear.layer setBorderWidth:1.0];   //边框宽度
    [clear.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor grayColor])];
    [clear setTitle:@" 清除 " forState:UIControlStateNormal];
    clear.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    clear.backgroundColor = [UIColor grayColor];
    [clear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clear];
    
    
    
    
    UILabel *touch = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, kWidth , 30)];
    touch.text = @"| 是否开启Touch ID |";
    touch.textAlignment = NSTextAlignmentCenter;
    touch.font = [UIFont boldSystemFontOfSize:17.0];
    [self.view addSubview:touch];

    NYSegmentedControl *touchSwitch = [[NYSegmentedControl alloc] initWithItems:@[@"打开",@"关闭"]];
    touchSwitch.backgroundColor = [UIColor grayColor];
    touchSwitch.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    touchSwitch.titleTextColor = [UIColor whiteColor];
    touchSwitch.selectedTitleTextColor = [UIColor blackColor];
    [touchSwitch sizeToFit];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"TouchID"] integerValue] == 0) {
        //打开
        touchSwitch.selectedSegmentIndex = 0;
    }else {
        //关闭
        touchSwitch.selectedSegmentIndex = 1;
    }
    //添加委托方法
    [touchSwitch addTarget:self action:@selector(touchAction:) forControlEvents:(UIControlEventValueChanged)];
    
    touchSwitch.frame = CGRectMake(kWidth / 4, 300, kWidth / 2 , 30);
    touchSwitch.center = CGPointMake(kWidth / 2, 300);
    [self.view addSubview:touchSwitch];
  
}

#pragma mark ----------------- segment代理(touch ID验证) ------------------

- (void)touchAction:(NYSegmentedControl *)segment {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index = segment.selectedSegmentIndex;
    [userDefault setObject:[NSNumber numberWithInteger:index] forKey:@"TouchID"];
    
    if ([[userDefault objectForKey:@"TouchID"] integerValue] == 0) {
        //打开
        [CollectHandle shareCollectVideo].isPassTouchID = NO;
    }else {
        //关闭
        [CollectHandle shareCollectVideo].isPassTouchID = YES;
    }
}

#pragma mark -------------------- segment代理(流量监测) --------------------

- (void)segmentAction:(NYSegmentedControl *)segment {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger index = segment.selectedSegmentIndex;
    [userDefault setObject:[NSNumber numberWithInteger:index] forKey:@"ONOFF"];
    
//    NSLog(@"%ld", index);
//    NSLog(@"++++%ld", [[userDefault objectForKey:@"ONOFF"] integerValue]);
    if ([[userDefault objectForKey:@"ONOFF"] integerValue] == 0) {
//        NSLog(@"打开");
        [self showText];
        //开始监听网络
        [CoreStatus beginNotiNetwork:self];
    }else {
//        NSLog(@"关闭");
        [CoreStatus endNotiNetwork:self];
    }
}

//当网络状态改变的时候被调用
-(void)coreNetworkChangeNoti:(NSNotification *)noti{
    //获取当前状态字符串
//    NSString * statusString = [CoreStatus currentNetWorkStatusString];
//    NSLog(@"%@",statusString);
    
    [self showText];
}

-(void)showText{
    //获取当前网络字符串
    NSString * statusString = [CoreStatus currentNetWorkStatusString];
//    NSLog(@"%@", statusString);
    
    if ([statusString isEqualToString:@"2G"] || [statusString isEqualToString:@"3G"] || [statusString isEqualToString:@"4G"] || [statusString isEqualToString:@"蜂窝网络"]) {

         UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"正在使用流量" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
 
        UIAlertAction*otherAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//                    NSLog(@"Okay");
                }];
        // Add the actions.
        [alertC addAction:otherAction];
        
        [self presentViewController:alertC animated:YES completion:nil];
        
    }
}


#pragma mark -------------------- 清除缓存 --------------------

//清除缓存
- (void)clear{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除所有缓存?" message:@"将删除所有已缓存的文件" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

//如果点的是确定键进行缓存清理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
//            NSLog(@"files : %lu",(unsigned long)files.count);
            for (NSString *p in files) {
                NSError *error = nil;
                NSString *path = [cachPath stringByAppendingString:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            [self performSelectorOnMainThread:@selector(clearSuccess) withObject:nil waitUntilDone:YES];
            
        });
        
//        NSLog(@"~~~~~~~~~~%ld", [[SDImageCache sharedImageCache]getSize]);
        //清除SDWebImage缓存
        [[SDImageCache sharedImageCache]clearDisk];
        [[SDImageCache sharedImageCache]clearMemory];
//        NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(9, 1, 1) lastObject]);
//        NSLog(@"~~~~~~~~~~%ld", [[SDImageCache sharedImageCache]getSize]);
    }
}


//清理成功
- (void)clearSuccess{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理成功" message:nil
delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//返回按钮
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
