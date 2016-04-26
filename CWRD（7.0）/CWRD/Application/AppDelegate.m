//
//  AppDelegate.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "PlayerDataBase.h"
#import "MineViewController.h"
#import "WXApi.h"
#import "CoreStatus.h"
#import "CALayer+Transition.h"
#import "ZWIntroductionViewController.h"
#import "XGPush.h"
#import "SVProgressHUD.h"
#import "MineViewController.h"
#import "MyCollectionViewController.h"

@interface AppDelegate ()<CoreStatusProtocol, UITabBarControllerDelegate>
{
    TabBarViewController *tabVC;
}
@property(nonatomic,assign) NSInteger time;
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    

    tabVC = [[TabBarViewController alloc] init];
    tabVC.delegate = self;
    MineViewController *mine = [[MineViewController alloc] init];
    
    
    //抽屉视图
    self.deck = [[IIViewDeckController alloc] initWithCenterViewController:tabVC leftViewController:mine];
    self.deck.leftSize = kWidth * 2 / 3;
  
    //建表
    [[PlayerDataBase shareDataBase] createCollectList];
    
#pragma mark--------------------shareSDK----------------------
    //ShareSDK
    [ShareSDK registerApp:@"aa3dfa50e988"];
    
    //分享到QQ
    [ShareSDK connectQQWithQZoneAppKey:@"1104803445" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    //分享到QQ空间
    [ShareSDK connectQZoneWithAppKey:@"1104803445" appSecret:@"NJJokSU36l1ZgJUD" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //分享到微信
    //微信收藏
    [ShareSDK connectWeChatFavWithAppId:@"wx1ec8a4f63662330b" appSecret:@"411a7f737ceb53489a15c80e3662e2a8" wechatCls:[WXApi class]];
    //微信好友
    [ShareSDK connectWeChatSessionWithAppId:@"wx1ec8a4f63662330b" appSecret:@"411a7f737ceb53489a15c80e3662e2a8" wechatCls:[WXApi class]];
    //微信朋友圈
    [ShareSDK connectWeChatTimelineWithAppId:@"wx1ec8a4f63662330b" appSecret:@"411a7f737ceb53489a15c80e3662e2a8" wechatCls:[WXApi class]];
    //拷贝
    [ShareSDK connectCopy];
    //邮件
    [ShareSDK connectMail];
    //短信
    [ShareSDK connectSMS];
    
#pragma mark------------------引导页-----------------------------
    //判断是否是第一次进入程序,决定是否加载引导页
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"times"] == nil) {
        //引导动画
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        self.window.rootViewController = self.introductionView;
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            //        weakSelf.introductionView = nil;
            [weakSelf.introductionView removeFromParentViewController];
            weakSelf.window.rootViewController = weakSelf.deck;
            [weakSelf XGTSapplication:application];
        };
    }else {
        [self.introductionView removeFromParentViewController];
        self.window.rootViewController = self.deck;
        [self XGTSapplication:application];
    }
    //
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    if ([[userdefault objectForKey:@"ONOFF"] integerValue] == 0) {
        [CoreStatus beginNotiNetwork:self];
    }else {
        [CoreStatus endNotiNetwork:self];
    }
    
    //3DTouch
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc]initWithType:@"每日精选" localizedTitle:@"每日精选"];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc]initWithType:@"分类" localizedTitle:@"分类"];
    UIApplicationShortcutItem *shortItem3 = [[UIApplicationShortcutItem alloc]initWithType:@"排行榜" localizedTitle:@"排行榜"];
    UIApplicationShortcutItem *shortItem4 = [[UIApplicationShortcutItem alloc]initWithType:@"我的收藏" localizedTitle:@"我的收藏"];
    
    NSArray *shortItemArray = [[NSArray alloc]initWithObjects:shortItem1, shortItem2, shortItem3, shortItem4 , nil];
    [[UIApplication sharedApplication]setShortcutItems:shortItemArray];
    
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark-----------------点击TabBar触发(代理)------------------
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 0) {
        [SVProgressHUD dismiss];
    }else if (tabBarController.selectedIndex == 2) {
        [SVProgressHUD dismiss];
    }
}


#pragma mark--------------------信鸽推送-----------------------
- (void)XGTSapplication:(UIApplication *)application{
    [XGPush startApp:2200152863 appKey:@"I2WB89MN82UT"];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
        //如果设备系统在8.0以上 推送服务用以下方式注册
        UIUserNotificationSettings *Settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:Settings];
    }else{
        //如果在8.0以下 用之前的方法注册
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    }

}

#pragma mark --------------- 流量监测 ----------------

//当网络状态改变的时候被调用
-(void)coreNetworkChangeNoti:(NSNotification *)noti{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"alertView" object:nil];
    
}

//获取我们的Token的方法(token用户的唯一标识)
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //将token发送给我们的信鸽服务器
    [XGPush registerDevice:deviceToken];
    NSLog(@"-------------------%@", [XGPush registerDevice:deviceToken]);
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.localizedTitle isEqual:@"每日精选"]) {
        AppDelegate *leftDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [leftDelegate.deck closeLeftView];
        [tabVC dismissViewControllerAnimated:YES completion:nil];
        tabVC.selectedIndex = 0;
    }else if ([shortcutItem.localizedTitle isEqual:@"分类"]) {
        tabVC.selectedIndex = 1;
    }else if ([shortcutItem.localizedTitle isEqual:@"排行榜"]){
        tabVC.selectedIndex = 2;
    }else if ([shortcutItem.localizedTitle isEqual:@"我的收藏"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TouchID" object:nil];
    }
}

@end
