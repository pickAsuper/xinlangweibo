//
//  LCStatus.h
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCUser;

@interface LCStatus : NSObject

//用户登录后显示在首页的名称
@property (nonatomic ,copy)NSString *text;

//时间
@property (nonatomic ,assign)long long id;

//这条微博的信息
@property (nonatomic,strong)LCUser *user;


@end
