//
//  MoreViewController.m
//  CWRD
//
//  Created by lanou on 15/9/17.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "MoreViewController.h"
#import "StatementViewController.h"
#import "VideoFunctionStatementViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"更多";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor],NSForegroundColorAttributeName, nil]];
    [self addView];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)addView{
    
    
    UIButton *user = [UIButton buttonWithType:UIButtonTypeCustom];
    user.frame = CGRectMake(0, 140, kWidth, 30);
    [user setTitle:@"免责声明" forState:UIControlStateNormal];
    [user addTarget:self action:@selector(user) forControlEvents:UIControlEventTouchUpInside];
    user.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [user setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    user.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:user];
    
    
    UIButton *function = [UIButton buttonWithType:UIButtonTypeCustom];
    function.frame = CGRectMake(0, 220, kWidth, 30);
    [function setTitle:@"视频功能声明" forState:UIControlStateNormal];
    [function addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];
    function.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [function setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    function.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:function];
    
    
    
    
}

//返回按钮
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//免责声明
- (void)user{
    StatementViewController *state = [[StatementViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:state];
    [self presentViewController:navC animated:YES completion:nil];
}

//视频功能
- (void)function{
    
    VideoFunctionStatementViewController *video = [[VideoFunctionStatementViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:video];
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
