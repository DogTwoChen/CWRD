//
//  ReadListViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadListViewController.h"
#import "TopListViewController.h"
#import "PKModel.h"
#import "ReadingTableViewCell.h"
#import "ReadWebViewController.h"
#import "SVProgressHUD.h"

@interface ReadListViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *readScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) HMSegmentedControl *readSegment;
@property (nonatomic, strong) NSMutableArray *classArray;
//当前是哪个tableView
@property (nonatomic, assign) int nowNum;

@property (nonatomic) CGPoint previousContentOffset;

@end

@implementation ReadListViewController

#pragma mark ------------------- 解析数据 --------------------

//滑动后移动tableView 并解析数据
- (void)reloadReadModelAndJson:(int)i {
    NSArray *typeidArray = @[@"1", @"27", @"10", @"14", @"6", @"18", @"12", @"11", @"7"];
    self.classArray = [[NSMutableArray alloc] init];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:typeidArray[i], @"typeid", @"hot", @"sort", nil];
    [LORequestManger POST:@"http://api2.pianke.me/read/columns_detail" params:postDic success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *dataDic = dic[@"data"];
        for (NSDictionary *listDic in dataDic[@"list"]) {
            PKModel *model = [PKModel shareJsonWithColumnsDictionary:dataDic[@"columnsInfo"] listDictionary:listDic];
            [self.classArray addObject:model];
        }
        [SVProgressHUD dismiss];
        self.tableView.frame = CGRectMake(kWidth * i, 0, kWidth, kHeight - 99);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//刚进去最先创建一个tableView 并解析数据
- (void)reloadFirstAndSecondReadModelAndJson:(int)i {
    NSArray *typeidArray = @[@"1", @"27", @"10", @"14", @"6", @"18", @"12", @"11", @"7"];
    self.classArray = [[NSMutableArray alloc] init];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObject:typeidArray[i] forKey:@"typeid"];
    [LORequestManger POST:@"http://api2.pianke.me/read/columns_detail" params:postDic success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *dataDic = dic[@"data"];
        for (NSDictionary *listDic in dataDic[@"list"]) {
            PKModel *model = [PKModel shareJsonWithColumnsDictionary:dataDic[@"columnsInfo"] listDictionary:listDic];
            [self.classArray addObject:model];
        }
        [SVProgressHUD dismiss];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * i, self.readScrollView.bounds.origin.y, kWidth, kHeight - 99)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[ReadingTableViewCell class] forCellReuseIdentifier:@"readCell"];
        self.tableView.separatorStyle = NO;
        [self.readScrollView addSubview:self.tableView];
        
        //下拉刷新
        __block UITableView *tableView = self.tableView;
        [self.tableView addHeaderWithCallback:^{
            [tableView reloadData];
            [tableView headerEndRefreshing];
        }];
        
        //上拉刷新
        __block ReadListViewController *readListVC = self;
        [self.tableView addFooterWithCallback:^{
            //刷新的话会解析新的数据
            [readListVC footerRefresh];
            [tableView footerEndRefreshing];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//上拉刷新数据
- (void)footerRefresh {
    static int count = 10;
    
    NSArray *typeidArray = @[@"1", @"27", @"10", @"14", @"6", @"18", @"12", @"11", @"7"];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:typeidArray[self.nowNum], @"typeid", @"hot", @"sort", [NSString stringWithFormat:@"%d", count], @"start", nil];
    [LORequestManger POST:@"http://api2.pianke.me/read/columns_detail" params:postDic success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *dataDic = dic[@"data"];
        for (NSDictionary *listDic in dataDic[@"list"]) {
            PKModel *model = [PKModel shareJsonWithColumnsDictionary:dataDic[@"columnsInfo"] listDictionary:listDic];
            [self.classArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    count += 10;
}


#pragma mark ------------ viewDidLoad ------------

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.view.backgroundColor = [UIColor whiteColor];
    
    BlurImageView *blur = [[BlurImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    blur.image = [UIImage imageNamed:@"blur"];
    self.view = blur;
    
    self.readScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 99, kWidth, kHeight - 50)];
    self.readScrollView.backgroundColor = [UIColor clearColor];
    self.readScrollView.contentSize = CGSizeMake(kWidth * 9, 0);
    self.readScrollView.pagingEnabled = YES;
    self.readScrollView.bounces = NO;
    self.readScrollView.delegate = self;
    [self.view addSubview:self.readScrollView];
    
    //风火轮开始
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
    [SVProgressHUD show];
    
    //创建一个tableView用来复用 并解析数据
    self.nowNum = 0;
    [self reloadFirstAndSecondReadModelAndJson:self.nowNum];
    
    [self setUpReadSegmentedControl];

}


//左右滑动scrollView的时候segment跟随的滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int scorllCount = self.readScrollView.contentOffset.x / kWidth;
    printf("%d", scorllCount);
    //如果之前的位置和滚动后的位置不同(表示不是上下滑动单个tableView)
    if (self.readSegment.selectedIndex != scorllCount) {
        [SVProgressHUD show];
        self.readSegment.selectedIndex = scorllCount;
        
        if (scorllCount > 2 && scorllCount < 8) {
            //刷新新的数据并设置tableView新的位置
            [self reloadReadModelAndJson:scorllCount];
            [self.segmentScrollView setContentOffset:CGPointMake((self.readSegment.selectedIndex - 2)* (kWidth / 4.0), 0)];
        }else if (scorllCount >= 8) {
            [self reloadReadModelAndJson:scorllCount];
            [self.segmentScrollView setContentOffset:CGPointMake(5 * (kWidth / 4.0), 0)];
        }else {
            [self reloadReadModelAndJson:scorllCount];
            [self.segmentScrollView setContentOffset:CGPointMake(0, 0)];
        }
    }
}


#pragma mark --------- 设置segmentedControl ---------

- (void)setUpReadSegmentedControl {
    //设置scrollView
    _segmentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 35)];
    _segmentScrollView.contentSize = CGSizeMake(kWidth / 4.0 * 9, 0);
    _segmentScrollView.showsHorizontalScrollIndicator = NO;
    _segmentScrollView.bounces = NO;
    
    //设置segmentedControl
    NSArray *array = @[@"| 早安 |", @"| 晚安 |", @"| 读书 |", @"| 万相 |", @"| 影视 |", @"| 心理 |", @"| 访谈 |", @"| 任务 |", @"| 旅游 |"];
    _readSegment = [[HMSegmentedControl alloc] initWithSectionTitles:array];
    [_readSegment setFrame:CGRectMake(0, 0, kWidth / 4.0 * 9, 35)];
    _readSegment.alpha = 0.9;
    _readSegment.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14.0];
    _readSegment.textColor = [UIColor whiteColor];
    _readSegment.selectionIndicatorHeight = 2.0f;
    _readSegment.selectionIndicatorColor = [UIColor cyanColor];
    _readSegment.backgroundColor = [UIColor blackColor];
    [_readSegment addTarget:self action:@selector(chooseType:) forControlEvents:(UIControlEventValueChanged)];
    
    //将segmentedControl贴到scrollView上
    [_segmentScrollView addSubview:_readSegment];
    [self.view addSubview:_segmentScrollView];
}
//点击segmented(改变segmented的值就调用)
- (void)chooseType:(HMSegmentedControl *)segmentedControl {

    //如果segment的位置和当前scrollview的位置不同,表示是点击跳转的
    if (segmentedControl.selectedIndex != (int)(self.readScrollView.contentOffset.x / kWidth)) {
        [self.classArray removeAllObjects];
        [self.tableView reloadData];
        [SVProgressHUD show];
        [self reloadReadModelAndJson:(int)segmentedControl.selectedIndex];
        //滑动readScrollview
        [self.readScrollView setContentOffset:CGPointMake(kWidth * segmentedControl.selectedIndex, 0) animated:NO];

    }
}


#pragma mark ----------- 设置TableView属性 -----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.classArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readCell" forIndexPath:indexPath];
    PKModel *model = self.classArray[indexPath.row];
    cell.title.text = model.title;
    [cell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"loading"]];
    cell.Info.text = model.content;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight/4;
}


#pragma mark ----------- 点击cell跳转 -----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [SVProgressHUD dismiss];
    ReadWebViewController *readWebVC = [[ReadWebViewController alloc] init];
    readWebVC.modelArray = self.classArray;
    readWebVC.index = indexPath.row;
    [self.navigationController pushViewController:readWebVC animated:YES];
}



//设置隐藏
//开始拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (self.tableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    self.previousContentOffset = self.tableView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.tableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    self.previousContentOffset = self.tableView.contentOffset;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    self.tabBarController.tabBar.hidden = NO;
    //    self.navigationController.navigationBar.hidden = NO;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
