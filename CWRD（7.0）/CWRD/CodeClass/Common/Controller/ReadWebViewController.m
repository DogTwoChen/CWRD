//
//  ReadWebViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadWebViewController.h"
#import "ArticleModel.h"
#import "PKModel.h"
#import "CollectHandle.h"
#import <ShareSDK/ShareSDK.h>
#import "SVProgressHUD.h"

@interface ReadWebViewController ()<UIScrollViewDelegate,UIWebViewDelegate, UIGestureRecognizerDelegate>

//用来解析url的model
@property (nonatomic, strong) ArticleModel *articleModel;
@property (nonatomic) NSInteger p;
@property (nonatomic, strong) UIButton *collectbutton;
@property (nonatomic, strong) UIWebView *web;

@end

@implementation ReadWebViewController

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}


#pragma mark ---- 根据传进来的model解析出对应的articleModel (包含WeiViewUrl) ----

- (void)reloadArticle {
    PKModel *model = self.modelArray[self.p];
    NSDictionary *articleDic = [NSDictionary dictionaryWithObject:model.id forKey:@"contentid"];
    
    [LORequestManger POST:@"http://api2.pianke.me/article/info" params:articleDic success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *dataDic = dic[@"data"];
        self.articleModel = [ArticleModel shareJsonWithDictionary:dataDic[@"shareinfo"]];
        
        [self.web reload];
        //取出articleModel的url解析uiWebView(解析完成的代理方法里改变web坐标)
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleModel.url]]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark ------ viewDidLoad ------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    [self setLeftUIBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kBounds];
    scrollView.contentSize = CGSizeMake(kWidth * self.modelArray.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //在最后一张WebView后面贴一张view,用来写The End.
    UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(kWidth *self.modelArray.count, 0, kWidth, kHeight)];
    endView.backgroundColor = [UIColor whiteColor];
    UILabel * endLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    endLabel.numberOfLines = 0;
    endLabel.text = @"- The End -";
    endLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:22];
    [endView addSubview:endLabel];
    [scrollView addSubview:endView];
 
    //当前页面的位置给单例
    [CollectHandle shareCollectVideo].modelArray = self.modelArray;
    [CollectHandle shareCollectVideo].index = self.index;
    self.p = self.index;
    
    //初始化一个webView
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(kWidth * self.index, -100 + 64, kWidth, kHeight + 90-64)];
    //风火轮开始
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
    [SVProgressHUD show];
    //解析当前webView
    [self reloadArticle];
    self.web.delegate = self;
    //显示点击的cell对应的webView
    [scrollView setContentOffset:CGPointMake(self.index * kWidth, 0) animated:YES];
    [scrollView addSubview:self.web];
    
    //收藏按钮
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


//手势方法
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
    [SVProgressHUD dismiss];
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
    [self.collectbutton addTarget:self action:@selector(collect) forControlEvents:(UIControlEventTouchUpInside)];
    //调用单例,看之前是否收藏过
    [[CollectHandle shareCollectVideo] yesOrNoCollectRead];
    if ([CollectHandle shareCollectVideo].isCollectedRead == NO) {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect1" ] forState:(UIControlStateNormal)];
        
    }else {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect2" ] forState:(UIControlStateNormal)];
    }
    [view addSubview:self.collectbutton];
    
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = collectItem;
}



//点击收藏
- (void)collect {
    [CollectHandle shareCollectVideo].isCollectedRead = ![CollectHandle shareCollectVideo].isCollectedRead;
    if ([CollectHandle shareCollectVideo].isCollectedRead == YES) {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect2" ] forState:(UIControlStateNormal)];
//        NSLog(@"收藏");
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        //放入单例收藏数组
        [[CollectHandle shareCollectVideo] collectRead];
    }else {
        [self.collectbutton setImage:[UIImage imageNamed:@"collect1" ] forState:(UIControlStateNormal)];
//        NSLog(@"取消收藏");
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        //移出单例收藏数组
        [[CollectHandle shareCollectVideo] cancelCollectRead];
    }
}


#pragma mark ------------ scrollView滑动 --------------

//scrollView滑动结束的时候判断需不需要请求刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.p != scrollView.contentOffset.x / kWidth) {
        self.p = scrollView.contentOffset.x / kWidth;
        
        //滑动后判断是否收藏过,依此设置收藏按钮
        [CollectHandle shareCollectVideo].modelArray = self.modelArray;
        [CollectHandle shareCollectVideo].index = self.p;
        [self setCollectButtonItem];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor cyanColor]];
        
        
        [SVProgressHUD show];
        //解析
        [self reloadArticle];
    }

}
//webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    self.web.frame = CGRectMake(kWidth * self.p, -100, kWidth, kHeight + 90);
}



#pragma mark ------------ 分享 --------------

- (void)share:(UIButton *)button {
    //测试shareSDK
    //        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"AC60A4890C6C6D8FF051C45F8E469B2E" ofType:@"jpeg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.articleModel.text
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithUrl:[self.modelArray[self.index] coverimg]]
                                                title:self.articleModel.title
                                                  url:self.articleModel.url
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
