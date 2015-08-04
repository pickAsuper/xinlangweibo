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

//用户登录后显示在首页的微博信息内容
@property (nonatomic ,copy)NSString *text;

//时间
@property (nonatomic ,assign)long long id;

//这条微博的信息
@property (nonatomic,strong)LCUser *user;

//创建时间
@property (nonatomic ,copy)NSString *created_at;

// 来源
@property (nonatomic, copy) NSString *source;

//缩略图
@property (nonatomic,copy) NSString *thumbnail_pic;


/**
 *  转发数
 */
@property (nonatomic,assign)NSInteger reposts_count;
/**
 *  评论数
 */
@property (nonatomic ,assign)NSInteger comments_count;
/**
 * 表态数
 */
@property (nonatomic ,assign)NSInteger attitudes_count;

//多张图片的集合 >>图片地址列表
@property (nonatomic,strong)NSArray *pic_urls;



@end
