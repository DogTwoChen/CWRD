//
//  TabBarViewController.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TabBarViewController.h"
#import "DailySelectionTableViewController.h"
#import "TotalClassViewController.h"
#import "SelectListViewController.h"
//#import "TopListViewController.h"
#import "MineTableViewController.h"
#import "MineViewController.h"
#import "IIViewDeckController.h"
#import "CoreStatus.h"

@interface TabBarViewController ()
{
    int openValue;
}

@property (nonatomic,strong)IIViewDeckController *deckViewClass;
@property (nonatomic,strong)IIViewDeckController *deckViewDaily;
@property (nonatomic,strong)IIViewDeckController *deckViewTop;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //每日精选
    DailySelectionTableViewController *dailyTVC = [[DailySelectionTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    
    UIBarButtonItem *settingDaily = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"Entypo_2630(0)_32"] style:UIBarButtonItemStylePlain target:self action:@selector(skipToMine)];
    [settingDaily setTintColor:[UIColor cyanColor]];
    dailyTVC.navigationItem.leftBarButtonItem = settingDaily;

    //=====================================================================
    
    
    //分类
    TotalClassViewController *classVC = [[TotalClassViewController alloc]init];
    
    //我的按钮
    UIBarButtonItem *settingClass = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"Entypo_2630(0)_32"] style:UIBarButtonItemStylePlain target:self action:@selector(skipToMine)];
    classVC.navigationItem.leftBarButtonItem = settingClass;
    [settingClass setTintColor:[UIColor cyanColor]];
    
    //=====================================================================

    
    SelectListViewController *selectListVC = [[SelectListViewController alloc]init];
    
    UIBarButtonItem *settingTop = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"Entypo_2630(0)_32"] style:UIBarButtonItemStylePlain target:self action:@selector(skipToMine)];
    selectListVC.navigationItem.leftBarButtonItem = settingTop;
    [settingTop setTintColor:[UIColor cyanColor]];
    
    [self addChildVC:dailyTVC title:@"每日精选" imageName:@"daily" selectedImage:@""];
    [self addChildVC:classVC title:@"分类" imageName:@"class" selectedImage:@""];
    [self addChildVC:selectListVC title:@"排行榜" imageName:@"rank" selectedImage:@""];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAlert) name:@"alertView" object:nil];
    
    
}

- (void)showAlert {
//    //获取当前网络字符串
    NSString * statusString = [CoreStatus currentNetWorkStatusString];
//    NSLog(@"%@", statusString);
    if ([statusString isEqualToString:@"2G"] || [statusString isEqualToString:@"3G"] || [statusString isEqualToString:@"4G"] || [statusString isEqualToString:@"蜂窝网络"]) {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"正在使用流量" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*otherAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//                NSLog(@"Okay");
            }];
    // Add the actions.
    [alertC addAction:otherAction];
    
    [self presentViewController:alertC animated:YES completion:nil];

//        NSLog(@"~~~~~~~跳啦");
    }
}


- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage {
   
    //设置字体颜色
    self.tabBar.tintColor = [UIColor cyanColor];
    self.tabBar.barTintColor = [UIColor blackColor];
    
    //设置默认图标
    childVC.tabBarItem.image = [UIImage imageNamed: imageName];
        
    //设置选中图标
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //设置导航控制器
    UINavigationController *childNVC = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    //设置导航栏文本内容
    childVC.navigationItem.title = title;
    
    
    //设置导航栏文本和填充色
    childNVC.navigationBar.barTintColor = [UIColor clearColor];
    //修改navgation的字体,大小,颜色
    
    [childNVC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15.0], NSFontAttributeName, [UIColor clearColor], NSBackgroundColorAttributeName, nil]];
//    childNVC.navigationBar.alpha = 0.5;
    
    //设置文本
    childNVC.tabBarItem.title = title;
    
    childNVC.navigationBar.translucent = YES;
//    //修改导航栏颜色
    
    //将我们设置好的视图控制器添加到TabBarController
    [self addChildViewController:childNVC];
}


//跳到"我的"界面
- (void)skipToMine{
    openValue += 1;
    AppDelegate *leftDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (openValue % 2 == 1) {
        [leftDelegate.deck openLeftView];
    }else
    {
        [leftDelegate.deck closeLeftView];
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
