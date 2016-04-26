//
//  ClassDeatilViewController.m
//  CWRD
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ClassDeatilViewController.h"
#import "TimeTableViewCell.h"
#import "DetailModel.h"
#import "WebViewViewController.h"
#import "ClassificationViewController.h"
@interface ClassDeatilViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl *segmentControl;
//按时间排序数组
@property(nonatomic,strong)NSMutableArray *timeArray;


@end

@implementation ClassDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = self.classTitle;
    
    //设置segmentControl
    self.segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"按时间排序",@"分享排行榜"]];
    self.segmentControl.selectedIndex = 0;
    [self.segmentControl setFrame:CGRectMake(0, 64, kWidth, 35)];
    self.segmentControl.selectionIndicatorColor = [UIColor cyanColor];
    self.segmentControl.selectionIndicatorHeight = 2.0f;
    self.segmentControl.backgroundColor = [UIColor blackColor];
    self.segmentControl.textColor = [UIColor whiteColor];
    self.segmentControl.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14.0];
    [self.segmentControl addTarget:self action:@selector(actionSegmentControl:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.alpha = 0.9;
    [self.view addSubview:self.segmentControl];
    
    [self addView];
    
    //按时间排序解析数据
    [self reloadDataForDetail:self.timeAndShare[0]];
    //分享排行榜解析数据
    [self reloadDataForDetail:self.timeAndShare[1]];
    
    
    
    //注册cell
    [self.timeView registerClass:[TimeTableViewCell class] forCellReuseIdentifier:@"timeCell"];
    
    
    
    //实现下拉刷新
    __block ClassDeatilViewController *class = self;
    [self.timeView addHeaderWithCallback:^{
        [class.timeView headerEndRefreshing];
    }];
    [self.shareView addHeaderWithCallback:^{
        [class.shareView headerEndRefreshing];
    }];
    
   
}


//实现返回按钮的方法
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--------数据解析--------
- (void)reloadDataForDetail:(NSString *)url{
    self.timeArray = [[NSMutableArray alloc] init];
    [LORequestManger GET: url success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *videoList in dic[@"videoList"]) {
            DetailModel *model = [DetailModel shareListModelWithVideoList:videoList consumption:videoList[@"consumption"]];
            [self.timeArray addObject:model];
        }
        [self.timeView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

//加载视图
- (void)addView{
    self.timeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 99, kWidth, kHeight - 99) style:UITableViewStyleGrouped];
    self.timeView.hidden = NO;
    self.timeView.backgroundColor = [UIColor whiteColor];
    self.timeView.delegate = self;
    self.timeView.dataSource = self;
    
    self.timeView.separatorStyle = NO;
    [self.view addSubview:self.timeView];
    
}



//设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


//设置表尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 49;
}


//自定义表尾
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

//分别隐藏"按时间排序"与"分享排行榜"
- (void)actionSegmentControl:(HMSegmentedControl *)segmentControl{
    switch (segmentControl.selectedIndex) {
        case 0:
            [self.timeArray removeAllObjects];
            [self.timeView reloadData];
            [self reloadDataForDetail:self.timeAndShare[0]];
            break;
        case 1:
            [self.timeArray removeAllObjects];
            [self.timeView reloadData];
            [self reloadDataForDetail:self.timeAndShare[1]];
            break;
        default:
            break;
    }
    
}

//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//设置一个分区内的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.timeArray.count;
    
}



//cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeTableViewCell *timeCell = [self.timeView dequeueReusableCellWithIdentifier:@"timeCell"forIndexPath:indexPath];
    DetailModel *model = self.timeArray[indexPath.row];
    timeCell.classLabel.text = [NSString stringWithFormat:@"#%@/ %@",model.category, [self setTimeWithInterval:[model.duration intValue]]];
    
    timeCell.nameLabel.text = model.title;
    [timeCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]placeholderImage:[UIImage imageNamed:@"placeholder_square"]];
    
    
    return timeCell;
    
    
}

//时长转化成分钟类型
- (NSString *)setTimeWithInterval:(int )interval
{
    //分钟
    int minutes = interval / 60;
    //秒
    int seconds = interval % 60;
    return [NSString stringWithFormat:@"%d'%02d''",minutes,seconds];
}



//设置每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight/4;
}






#pragma mark ---------跳转到详情页面--------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewViewController *webVC = [[WebViewViewController alloc]init];
    webVC.modelArray = self.timeArray;
    webVC.index = indexPath.row;
    [self.navigationController pushViewController:webVC animated:YES];
}


//设置滑动屏幕时tabBar隐藏
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self.timeView.contentOffset.y > 0) {
        
        self.tabBarController.tabBar.hidden = YES;
    }else {
        
        self.tabBarController.tabBar.hidden = YES;
    }
    
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
