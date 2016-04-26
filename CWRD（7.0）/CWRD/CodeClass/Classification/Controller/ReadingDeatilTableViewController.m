//
//  ReadingDeatilTableViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "ReadingDeatilTableViewController.h"
#import "ReadingTableViewCell.h"
#import "PKModel.h"
#import "ReadingViewController.h"
#import "ReadWebViewController.h"

@interface ReadingDeatilTableViewController ()

@end

@implementation ReadingDeatilTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    
    BlurImageView *blur = [[BlurImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    blur.image = [UIImage imageNamed:@"blur"];
    self.tableView.backgroundView = blur;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = self.name;
    [self.tableView registerClass:[ReadingTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //下拉刷新
    __block ReadingDeatilTableViewController *readDetailTVC = self;
    [self.tableView addHeaderWithCallback:^{
        [readDetailTVC.tableView reloadData];
        [readDetailTVC.tableView headerEndRefreshing];
    }];
    
    //上拉刷新
    [self.tableView addFooterWithCallback:^{
        [readDetailTVC footerRefresh];
        [readDetailTVC.tableView footerEndRefreshing];
    }];
    
   
}

- (void)footerRefresh {
    static int count = 10;
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithObject:self.typeid forKey:@"typeid"];
    [postDic setValue:@"addtime" forKey:@"sort"];
    [postDic setValue:[NSString stringWithFormat:@"%d", count] forKey:@"start"];
    [LORequestManger POST:@"http://api2.pianke.me/read/columns_detail" params:postDic success:^(id response) {
        NSDictionary *pkDic = (NSDictionary *)response;
        NSDictionary *dataDic = pkDic[@"data"];
        NSArray *listArray = dataDic[@"list"];
        
        for (NSDictionary *listDic in listArray) {
            PKModel *pkModel = [PKModel shareJsonWithColumnsDictionary:dataDic[@"columnsInfo"] listDictionary:listDic];
            [self.articleArray addObject:pkModel];
            
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    count += 10;
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//设置每个分区内的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleArray.count;
}

//自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadingTableViewCell *readCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PKModel *model = self.articleArray[indexPath.row];
    readCell.title.text = model.title;
    [readCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    readCell.Info.text = model.content;
    return readCell;
    
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight/4;
}

//跳转到界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   ReadWebViewController *webVC = [[ReadWebViewController alloc]init];
    webVC.modelArray = self.articleArray;
    webVC.index = indexPath.row;
    
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
