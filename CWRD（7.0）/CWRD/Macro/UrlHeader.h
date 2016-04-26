//
//  UrlHeader.h
//  CWRD
//
//  Created by lanou on 15/9/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#ifndef CWRD_UrlHeader_h
#define CWRD_UrlHeader_h

#define kDailySelectionUrl @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=20150915&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone"

#define kWeeklyUrl @"http://baobab.wandoujia.com/api/v1/ranklist?strategy=weekly&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone"

#define kMonthlyUrl @"http://baobab.wandoujia.com/api/v1/ranklist?strategy=monthly&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone"

#define kTotalUrl @"http://baobab.wandoujia.com/api/v1/ranklist?strategy=historical&vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone"
//分类页面
#define kClass @"http://baobab.wandoujia.com/api/v1/categories?vc=67&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&v=1.8.0&f=iphone"
//创意
#define kOriginalityTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%88%9B%E6%84%8F&strategy=date&vc=67&t=MjAxNTA5MTUyMjQ2NTk1NDEsMTk5MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kOriginalityShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%88%9B%E6%84%8F&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzA0MDkxNTksMTg0MQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//运动
#define kSportTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E8%BF%90%E5%8A%A8&strategy=date&vc=67&t=MjAxNTA5MTUyMjUxMTU2MDMsMTc4OQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kSportShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E8%BF%90%E5%8A%A8&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzEwMDAwODAsMTcxMQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//旅行
#define kTravelTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E6%97%85%E8%A1%8C&strategy=date&vc=67&t=MjAxNTA5MTUyMjUxNTI3NTUsNTE5Mg%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kTravelShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E6%97%85%E8%A1%8C&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzEyMzAwODgsNjgxOA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"

//剧情
#define kStoryTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%89%A7%E6%83%85&strategy=date&vc=67&t=MjAxNTA5MTUyMjUyMjQyMzcsNDE4MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kStoryShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%89%A7%E6%83%85&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE0Mjg4NDksNTA5NA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//动画
#define kAnimationTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%8A%A8%E7%94%BB&strategy=date&vc=67&t=MjAxNTA5MTUyMjUyNTAxNjcsMzY4MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kAnimationShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%8A%A8%E7%94%BB&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE1MjY0NDYsMzQzOQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//广告
#define kADTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%B9%BF%E5%91%8A&strategy=date&vc=67&t=MjAxNTA5MTUyMjUzMjA2MTMsNjMzOQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kADShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%B9%BF%E5%91%8A&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE2MTYyODgsMTY5MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//音乐
#define kMusicTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E9%9F%B3%E4%B9%90&strategy=date&vc=67&t=MjAxNTA5MTUyMjU0MTExMzgsMzM1MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kMusicShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E9%9F%B3%E4%B9%90&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE2NTk3MjMsNjQ1Mw%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"

//开胃
#define kEatTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%BC%80%E8%83%83&strategy=date&vc=67&t=MjAxNTA5MTUyMjU0MzYzODYsMzc1MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kEatShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E5%BC%80%E8%83%83&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE3MjIwNjgsMzc2OQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//预告
#define kPreTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E9%A2%84%E5%91%8A&strategy=date&vc=67&t=MjAxNTA5MTUyMjU1MDEwMzEsMTg2MA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kPreShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E9%A2%84%E5%91%8A&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE4MDk3OTIsMzE2NQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
//综合
#define kAllTime @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E7%BB%BC%E5%90%88&strategy=date&vc=67&t=MjAxNTA5MTUyMjU1MzM3MTcsNTkwMQ%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"
#define kAllShare @"http://baobab.wandoujia.com/api/v1/videos?num=100&categoryName=%E7%BB%BC%E5%90%88&strategy=shareCount&vc=67&t=MjAxNTA5MTUyMzE4NTU0NjQsNDUyNA%3D%3D&u=96fc193ed9e524b0b8102396210c8e7149fdeff5&net=wifi&v=1.8.0&f=iphone"

#endif
