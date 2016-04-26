//
//  TopListViewController.m
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "TopListViewController.h"
#import "TopListTableViewCell.h"
#import "DetailModel.h"
#import "WebViewViewController.h"
#import "ReadListViewController.h"

@interface TopListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *ListTableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic) CGPoint previousContentOffset;
@end

@implementation TopListViewController

#pragma mark --------- 请求并解析数据 ----------
//周排行
- (void)reloadListModelAndJson:(NSString *)url {
    self.modelArray = [[NSMutableArray alloc] init];
    [LORequestManger GET:url success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *videoListDic in dic[@"videoList"]) {
            DetailModel *model = [DetailModel shareListModelWithVideoList:videoListDic consumption:videoListDic[@"consumption"]];
            [self.modelArray addObject:model];
        }
        [self.ListTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpVideoTableView];

    [self reloadListModelAndJson:kWeeklyUrl];

    [self setUpsegmentedControl];
}

#pragma mark --------- 设置VideoTableView ---------

- (void)setUpVideoTableView {
    self.ListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, kWidth, kHeight - 99) style:(UITableViewStyleGrouped)];
    self.ListTableView.backgroundColor = [UIColor whiteColor];
    self.ListTableView.delegate = self;
    self.ListTableView.dataSource = self;
    self.ListTableView.separatorStyle = NO;
    [self.ListTableView registerClass:[TopListTableViewCell class] forCellReuseIdentifier:@"weekCell"];
    [self.view addSubview:self.ListTableView];
    
    //下拉刷新
    __block UITableView *tableView = self.ListTableView;
    [self.ListTableView addHeaderWithCallback:^{
        [tableView reloadData];
        [tableView headerEndRefreshing];
    }];
}

#pragma mark --------- 设置segmentedControl ---------

- (void)setUpsegmentedControl {
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"| 周排行 |", @"| 月排行 |", @"| 总排行 |"]];
    [segmentedControl setFrame:CGRectMake(0, 64, kWidth, 35)];

    segmentedControl.alpha = 0.9;
    segmentedControl.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14.0];
    segmentedControl.textColor = [UIColor whiteColor];
    segmentedControl.selectionIndicatorHeight = 2.0f;
    segmentedControl.selectionIndicatorColor = [UIColor cyanColor];
    segmentedControl.backgroundColor = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(actionSegmentControl:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:segmentedControl];
}

- (void)actionSegmentControl:(HMSegmentedControl *)segmentControl {
    switch (segmentControl.selectedIndex) {
        case 0:
            [self.modelArray removeAllObjects];
            [self.ListTableView reloadData];
            [self reloadListModelAndJson:kWeeklyUrl];
            break;
        case 1:
            [self.modelArray removeAllObjects];
            [self.ListTableView reloadData];
            [self reloadListModelAndJson:kMonthlyUrl];
            break;
        case 2:
            [self.modelArray removeAllObjects];
            [self.ListTableView reloadData];
            [self reloadListModelAndJson:kTotalUrl];
            break;
        default:
            break;
    }
}


#pragma mark --------- tableView 代理事件 --------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;

}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekCell" forIndexPath:indexPath];
    DetailModel *model = self.modelArray[indexPath.row];
    
    cell.rankLabel.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
    
    if (indexPath.row < 3) {
        cell.rankNoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rankno%d@3x", (int)indexPath.row + 1]];
        [cell addSubview:cell.rankNoView];
    }else {
        [cell.rankNoView removeFromSuperview];
    }
    [cell setValueForCellWithModel:model];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight/4;
}

#pragma mark --------- tableView点击 cell --------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WebViewViewController *webVC = [[WebViewViewController alloc]init];
    webVC.modelArray = self.modelArray;
    webVC.index = indexPath.row;

    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark --------- tableView设置表头 --------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


#pragma mark --------- tableView设置表尾 --------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 49;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    //设置label写the end
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kWidth, 30)];
    endLabel.text = @"━  The End  ━";
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:18];
    [footView addSubview:endLabel];
    return footView;
}


#pragma mark-----------------设置隐藏----------------------

//设置隐藏
//开始拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.ListTableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    self.previousContentOffset = self.ListTableView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.ListTableView.contentOffset.y >= self.previousContentOffset.y ) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    self.previousContentOffset = self.ListTableView.contentOffset;
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
