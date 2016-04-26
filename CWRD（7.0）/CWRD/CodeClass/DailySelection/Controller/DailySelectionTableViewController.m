//
//  DailySelectionTableViewController.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "DailySelectionTableViewController.h"
#import "DailyTableViewCell.h"
#import "HeaderView.h"
#import "DailySelectionModel.h"
#import "WebViewViewController.h"
#import "ClassDeatilViewController.h"


@interface DailySelectionTableViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HeaderView *headView;
@property (nonatomic) CGPoint previousContentOffset;
@property (nonatomic) NSMutableArray *DailySelectionArray;
@property (nonatomic) NSMutableArray *TableViewArray;
@property (nonatomic) CGFloat previousX;
@end

@implementation DailySelectionTableViewController



#pragma mark---------------------数据解析---------------------------------
- (void)reloadDailySelection {
    
    
    //获取当前时间,转换成字符串
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSString *strCurentDate = [format stringFromDate:currentDate];

    //截取一下时间
    NSString *subStrCurrentDate = [strCurentDate substringToIndex:8];
    
    [LORequestManger GET:[NSString stringWithFormat: @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone",subStrCurrentDate] success:^(id response) {
        NSDictionary *dic = (NSMutableDictionary *)response;
        
        for (NSDictionary *dailyListDic in dic[@"dailyList"]) {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            
            for (NSDictionary *videoListDic in dailyListDic[@"videoList"]) {
                DailySelectionModel *dailySelectionModel = [DailySelectionModel shareJsonWithShowDictionary:dailyListDic DetailDictionary:videoListDic ConsumptionDictionary:videoListDic[@"consumption"]];
                [array addObject:dailySelectionModel];
                
            }
            
            [[self DailySelectionArray]addObject:array];
            [[self TableViewArray]addObject:array];
        }
        [_TableViewArray removeObjectAtIndex:0];
        
        [self setHeadView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//懒加载
-(NSMutableArray *)DailySelectionArray {
    if (_DailySelectionArray == nil) {
        _DailySelectionArray = [[NSMutableArray alloc]init];
    }
    return _DailySelectionArray;
}

-(NSMutableArray *)TableViewArray {
    if (_TableViewArray == nil) {
        _TableViewArray = [[NSMutableArray alloc]init];
    }
    return _TableViewArray;
}

#pragma mark-----------------viewDidLoad--------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadDailySelection];
    //去掉cell之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DailyTableViewCell class] forCellReuseIdentifier:@"DailyCell"];
    
    //下拉刷新
    __block DailySelectionTableViewController *dailyTVC = self;
    [self.tableView addHeaderWithCallback:^{
        [dailyTVC.tableView reloadData];
        [dailyTVC.tableView  headerEndRefreshing];
    }];
    
    //上拉刷新
    [self.tableView addFooterWithCallback:^{
        [dailyTVC footerRefresh];
        [dailyTVC.tableView footerEndRefreshing];
    }];
    
    //用来判断是否是第一次进入程序
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"firstTime" forKey:@"times"];
    
}


- (void)footerRefresh {
    static int count = 1;
    //获取时间戳
    NSArray *array = _DailySelectionArray[0];
    DailySelectionModel *model = array[0];
    NSString *date = [model.date stringValue];

    //减十天
    NSString *str = [date substringToIndex:10];

    int value = [str intValue] - 864000 * count;
    NSString *newdatestr = [NSString stringWithFormat:@"%d", value];
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:[newdatestr intValue]];
    [formate setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [formate stringFromDate:newDate];
    
    
    [LORequestManger GET:[NSString stringWithFormat: @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone",strDate] success:^(id response) {
        NSDictionary *dic = (NSMutableDictionary *)response;
        
        for (NSDictionary *dailyListDic in dic[@"dailyList"]) {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            
            for (NSDictionary *videoListDic in dailyListDic[@"videoList"]) {
                DailySelectionModel *dailySelectionModel = [DailySelectionModel shareJsonWithShowDictionary:dailyListDic DetailDictionary:videoListDic ConsumptionDictionary:videoListDic[@"consumption"]];
                [array addObject:dailySelectionModel];
                
            }
            
            //            [[self DailySelectionArray]addObject:array];
            [[self TableViewArray]addObject:array];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    count++;
}


#pragma mark-----------------设置HeadView(轮播图)-------------------------
- (void)setHeadView {

    self.headView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight/4) imageArray:_DailySelectionArray[0] delegate:self action:@selector(headViewClick) timer:3.5 selector:@selector(cyc)];
    self.headView.tag = 1122;
    self.tableView.tableHeaderView = self.headView;
    UILabel *todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
   
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.image = [UIImage imageNamed:@"new"];
    [self.view addSubview:imageView];
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kHeight/4 - 30, kWidth, 30)];
    pageControl.numberOfPages = [_DailySelectionArray[0] count];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.tag = 222;
    [self.view addSubview:pageControl];
    
    [self.view addSubview:todayLabel];
}

//tableView点击轮播图跳转方法
- (void)headViewClick {
    
     WebViewViewController *webVC = [[WebViewViewController alloc]init];

    //轮播数组传到webVC
    webVC.modelArray = _DailySelectionArray[0];
    
    //获取当前下标(起始下标为1)
    int index = self.headView.contentOffset.x / kWidth;
    index -= 1;
    webVC.index = index;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

//定时器方法
- (void)cyc {
    [self scrollViewDidCircularly];
    CGPoint newPoint = self.headView.contentOffset;
    newPoint.x += kWidth;
    [self.headView setContentOffset:newPoint animated:YES];
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:222];
    if (self.headView.contentOffset.x / kWidth > [self.DailySelectionArray[0] count] - 1) {
        pageControl.currentPage = 0;
    }else {
        pageControl.currentPage = self.headView.contentOffset.x / kWidth;
    }
}

//手动滑动滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidCircularly];

}

//设置轮播效果
- (void)scrollViewDidCircularly {
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:222];
    if (self.headView.contentOffset.x == 0) {
        [self.headView setContentOffset:CGPointMake(kWidth * [_DailySelectionArray[0] count], 0) animated:NO];
    }
    if (self.headView.contentOffset.x == kWidth * ([_DailySelectionArray[0] count] + 1)) {
        [self.headView setContentOffset:CGPointMake(kWidth, 0) animated:NO];
    }
    pageControl.currentPage = self.headView.contentOffset.x / kWidth - 1;
    
}




#pragma mark -----------------表头----------------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//获取时间戳,进行转换
    NSArray *array = _TableViewArray[section];
    DailySelectionModel *model = array[1];
    NSString *date = [model.date stringValue];
    NSString *str = [date substringToIndex:10];

    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:[str intValue]];
    [formate setDateFormat:@"yyyy-MM-dd"];
    NSString *headDate = [formate stringFromDate:newDate];
    
//表头上的view,再加一个Label上去显示数字
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.9;
   
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    headLabel.text = headDate;
    headLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:17.0];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = [UIColor cyanColor];
    [view addSubview:headLabel];
    
    
    
    
    return view;
}

//表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------- tableView代理 -----------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _TableViewArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_TableViewArray[section] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyCell"];
    NSArray *array = _TableViewArray[indexPath.section];
    [cell setValueForCellWithModel:array[indexPath.row]];
    return cell;
}

//添加每个cell出现时的3D动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;//3D旋转
    rotation = CATransform3DMakeRotation( (180.0*M_PI)/180, 0.0, 0.7, 0.4);
    //逆时针旋转
    rotation.m34 = 1.0/ 600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}


//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight/4;
}

#pragma mark -------------- 点击cell -----------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebViewViewController *webVC = [[WebViewViewController alloc]init];
    NSMutableArray *array = _TableViewArray[indexPath.section];
    webVC.modelArray = array;
    webVC.index = indexPath.row;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark------------------------设置隐藏------------------------------

//设置隐藏
//开始拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    [self addTimer];
    self.previousContentOffset = self.tableView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.tableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    [self removeTimer];
    self.previousContentOffset = self.tableView.contentOffset;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    self.tabBarController.tabBar.hidden = NO;
    
}



- (void)removeTimer {
    HeaderView *header = (HeaderView *)[self.view viewWithTag:1122];
    [header.aTimer invalidate];
}

- (void)addTimer {
    HeaderView *header = (HeaderView *)[self.view viewWithTag:1122];
    [header addTimerDelegate:self timer:3.5 selector:@selector(cyc)];
    
}




@end
