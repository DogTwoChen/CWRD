//
//  WebViewViewController.m
//  CWRD
//
//  Created by lanou on 15/9/19.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "WebViewViewController.h"
#import "DailySelectionModel.h"
#import "CollectHandle.h"
#import <ShareSDK/ShareSDK.h>

@interface WebViewViewController ()<UIScrollViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>

//滑动后当前页面的cell值
@property (nonatomic, assign) NSInteger p;

@property (nonatomic, strong) UIButton *collectbutton;

@property (nonatomic, strong) UIWebView *web;

@end

@implementation WebViewViewController

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftUIBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = YES;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kBounds];
    scrollView.contentSize = CGSizeMake(kWidth * self.modelArray.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];

    //在最后一张WebView后面贴一张view,用来写The End.
    UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(kWidth *self.modelArray.count, 0, kWidth, kHeight - 64)];
    endView.backgroundColor = [UIColor whiteColor];
    UILabel * endLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    endLabel.numberOfLines = 0;
    endLabel.text = @"- The End -";
    endLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:22];
    [endView addSubview:endLabel];
    [scrollView addSubview:endView];
    
    
    //显示点击的cell对应的webView
    [scrollView setContentOffset:CGPointMake(self.index * kWidth, 0) animated:YES];
    
    //解析点进来的webView
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(kWidth * self.index, 0, kWidth, kHeight - 103)];
    self.web.userInteractionEnabled = YES;
    self.web.multipleTouchEnabled = YES;
    self.web.delegate = self;
    DailySelectionModel *model = self.modelArray[self.index];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.rawWebUrl]]];
    [scrollView addSubview:self.web];

    
    [CollectHandle shareCollectVideo].modelArray = self.modelArray;
    [CollectHandle shareCollectVideo].index = self.index;
    self.p = self.index;
    //右边按钮设置
    [self setCollectButtonItem];
    
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor cyanColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor cyanColor]];
    
    //轻拍两次
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    tap.delegate = self;
    [self.web addGestureRecognizer:tap];
    
}

- (void)tapClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

//必须实现
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}

//设置返回按钮
- (void)setLeftUIBarButtonItem {
    UIImage *image = [UIImage imageNamed:@"btn_back_normal@2x"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:image style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftButton;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------ 设置收藏按钮 --------------

- (void)setCollectButtonItem {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kWidth * 4 / 5, 0, 75, 30)];
    
    //分享按钮
    UIButton *sharebutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    sharebutton.frame = CGRectMake(45, 0, 30, 30);
    [sharebutton setImage:[UIImage imageNamed:@"share1" ] forState:(UIControlStateNormal)];
    [sharebutton addTarget:self action:@selector(share:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:sharebutton];
    
    //收藏按钮
    self.collectbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectbutton.frame = CGRectMake(5, 0, 30, 30);
    [self.collectbutton addTarget:self action:@selector(collect:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //调用单例,看之前是否收藏过(设置收藏按钮图片)
    [[CollectHandle shareCollectVideo] yesOrNoCollect];
    if ([CollectHandle shareCollectVideo].isCollected == NO) {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect1" ] forState:(UIControlStateNormal)];
        
    }else {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect2" ] forState:(UIControlStateNormal)];
    }
    [view addSubview:self.collectbutton];
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = collectItem;
    
}

//点击收藏 方法
- (void)collect:(UIButton *)button {
    
    [CollectHandle shareCollectVideo].isCollected = ![CollectHandle shareCollectVideo].isCollected;
    if ([CollectHandle shareCollectVideo].isCollected == YES) {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect2" ] forState:(UIControlStateNormal)];
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        //放入单例收藏数组
        [[CollectHandle shareCollectVideo] collect];
        
    }else {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect1" ] forState:(UIControlStateNormal)];
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        //移出单例收藏数组
        [[CollectHandle shareCollectVideo] cancelCollect];
    }
}


#pragma mark ------------ scrollView滑动 --------------

//scrollView滑动结束的时候判断需不需要请求刷新
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.p != scrollView.contentOffset.x / kWidth ) {
        self.p = scrollView.contentOffset.x / kWidth;
        
        //滑动后判断是否收藏过,依此设置收藏按钮
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        [self setCollectButtonItem];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor cyanColor]];
        
        //改变webView的坐标
        DailySelectionModel *model = self.modelArray[self.p];
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.rawWebUrl]]];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
     self.web.frame = CGRectMake(kWidth * self.p, 0, kWidth, kHeight - 103);
}

#pragma mark ------------ scrollView滑动 --------------

- (void)share:(UIButton *)button {
    //测试shareSDK
    //        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"AC60A4890C6C6D8FF051C45F8E469B2E" ofType:@"jpeg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[self.modelArray[self.index] description]
                                       defaultContent:@"来自CWRD的分享"
                                                image:[ShareSDK imageWithUrl:[self.modelArray[self.index] coverForDetail]]
                                                title:[self.modelArray[self.index] title]
                                                  url:[self.modelArray[self.index] playUrl]
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:button arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
//                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
//                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
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
