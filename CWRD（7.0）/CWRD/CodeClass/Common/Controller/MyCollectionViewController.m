//
//  MyCollectionViewController.m
//  CWRD
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ReadingTableViewCell.h"
#import "VideoTableViewCell.h"
#import "CollectHandle.h"
#import "DetailModel.h"
#import "PKModel.h"
#import "PlayerDataBase.h"
#import "WebViewViewController.h"
#import "ReadWebViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl *segmentControl;
@property(nonatomic,strong)UITableView *readingCollected;
@property(nonatomic,strong)UITableView *videoCollected;
//存储阅读收藏的数组
@property(nonatomic,strong)NSMutableArray *readingArray;
//存储视频收藏的数组
@property(nonatomic,strong)NSMutableArray *videoArray;

@end

@implementation MyCollectionViewController

- (NSMutableArray *)readingArray {
    if (!_readingArray) {
        _readingArray = [[NSMutableArray alloc] init];
    }
    return _readingArray;
}
- (NSMutableArray *)videoArray {
    if (!_videoArray) {
        _videoArray = [[NSMutableArray alloc] init];
    }
    return _videoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    //设置返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.tintColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //设置编辑按钮
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    editButton.tintColor = [UIColor cyanColor];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    [self addSegmentControl];
    [self addView];
    
    //注册cell
    [self.readingCollected registerClass:[ReadingTableViewCell class] forCellReuseIdentifier:@"readingCell"];
    [self.videoCollected registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"videoCell"];
    
    //单例赋值
    self.readingArray = [[PlayerDataBase shareDataBase] selegetAllReadingList];
    self.videoArray = [[PlayerDataBase shareDataBase] selegetAllVideoList];
    
}

//返回按钮
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ---------------- 初始化两个tableView -----------------

- (void)addView{
    BlurImageView *blur = [[BlurImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    blur.image = [UIImage imageNamed:@"blur"];

    self.readingCollected = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, kWidth, kHeight - 99 ) style:UITableViewStylePlain];
    self.readingCollected.hidden = NO;
    self.readingCollected.backgroundColor = [UIColor whiteColor];
    self.readingCollected.delegate = self;
    self.readingCollected.dataSource = self;
    self.readingCollected.tag = 20000;
    self.readingCollected.separatorStyle = NO;
    self.readingCollected.backgroundView = blur;
    [self.view addSubview:self.readingCollected];
    
    self.videoCollected = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, kWidth, kHeight - 99) style:UITableViewStylePlain];
    self.videoCollected.backgroundColor = [UIColor whiteColor];
    self.videoCollected.hidden = YES;
    self.videoCollected.delegate = self;
    self.videoCollected.dataSource = self;
    self.videoCollected.tag = 20001;
    self.videoCollected.separatorStyle = NO;
    [self.view addSubview:self.self.videoCollected];
    
}


#pragma mark ---------------- 设置segmentControl -----------------

- (void)addSegmentControl{
    self.segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"阅读收藏",@"视频收藏"]];
    self.segmentControl.selectedIndex = 0;
    [self.segmentControl setFrame:CGRectMake(0, 0, kWidth, 35)];
    self.segmentControl.selectionIndicatorColor = [UIColor cyanColor];
    self.segmentControl.selectionIndicatorHeight = 2.0f;
    self.segmentControl.backgroundColor = [UIColor blackColor];
    self.segmentControl.textColor = [UIColor whiteColor];
    self.segmentControl.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14.0];
    [self.segmentControl addTarget:self action:@selector(actionSegmentControl:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.alpha = 0.9;
    [self.view addSubview:self.segmentControl];
    
}
//分别隐藏"阅读收藏"与"视频收藏"
- (void)actionSegmentControl:(HMSegmentedControl *)segmentControl{
    switch (segmentControl.selectedIndex) {
        case 0:
            self.videoCollected.hidden = YES;
            self.readingCollected.hidden = NO;
            break;
        case 1:
            self.readingCollected.hidden = YES;
            self.videoCollected.hidden = NO;
            break;
        default:
            break;
    }
}


#pragma mark ----------------- 编辑cell (删除) ------------------

//改变编辑按钮标题
- (void)edit:(UIBarButtonItem *)button{
    [self.readingCollected setEditing:!self.readingCollected.editing animated:YES];
    [self.videoCollected setEditing:!self.videoCollected.editing animated:YES];
    
    if (self.readingCollected.editing == YES) {
        [button setTitle:@"完成"];
    }else{
        [button setTitle:@"编辑"];
    }
    
    if (self.videoCollected.editing == YES) {
         [button setTitle:@"完成"];
    }else{
         [button setTitle:@"编辑"];
    }
}

//设置哪些分区可以进行编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//指定分区添加删除的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//提交编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //阅读收藏删除
        if (tableView.tag == 20000) {
            //删除数据库里面的阅读
            DetailModel *model = self.readingArray[indexPath.row];
            [[PlayerDataBase shareDataBase] deleteCollectReadingModelWithTitle:model.title];
            
            [self.readingArray removeObjectAtIndex:indexPath.row];
            [self.readingCollected deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        
        //视频收藏删除
        }else{
            //删除数据库里面的视频
            PKModel *model = self.videoArray[indexPath.row];
            [[PlayerDataBase shareDataBase] deleteCollectVideoModelWithTitle:model.title];
            
            [self.videoArray removeObjectAtIndex:indexPath.row];
            [self.videoCollected deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        }
    }
}



#pragma mark ----------------- 实现tableView代理 ------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 20000) {
        return self.readingArray.count;
    }else{
        return self.videoArray.count;
    }
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //阅读收藏
    if (tableView.tag == 20000) {
        ReadingTableViewCell *readCell = [self.readingCollected dequeueReusableCellWithIdentifier:@"readingCell" forIndexPath:indexPath];
        PKModel *model = self.readingArray[indexPath.row];
        [readCell.post sd_setImageWithURL:[NSURL URLWithString:model.coverimg]placeholderImage:[UIImage imageNamed:@"placeholder"]];
        readCell.title.text = model.title;
        readCell.Info.text = model.content;
        readCell.selectionStyle = NO;
        return readCell;
    
    //视频收藏
    }else{
        VideoTableViewCell * videoCell = [self.videoCollected dequeueReusableCellWithIdentifier:@"videoCell"];
        videoCell.selectionStyle = NO;
        DetailModel *model = self.videoArray[indexPath.row];
        //赋值
        [videoCell setValueForCellWithModel:model];
        return videoCell;
    }
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight/4;
}


#pragma mark ----------------- 点击cell事件 ------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //阅读
    if (tableView.tag == 20000) {
        ReadWebViewController *readWebVC = [[ReadWebViewController alloc] init];
        readWebVC.modelArray = self.readingArray;
        readWebVC.index = indexPath.row;
        [self.navigationController pushViewController:readWebVC animated:YES];
    }else {
        WebViewViewController *videoWebVC = [[WebViewViewController alloc] init];
        videoWebVC.modelArray = self.videoArray;
        videoWebVC.index = indexPath.row;
        [self.navigationController pushViewController:videoWebVC animated:YES];
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
