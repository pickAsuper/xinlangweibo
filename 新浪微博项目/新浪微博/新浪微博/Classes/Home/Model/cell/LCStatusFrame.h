//
//  LCStatusFrame.h
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCStatus;


//原创微博昵称的字体
#define NAME_LABEL_SIZE 14

// 原创微博内容的字体
#define CONTENT_LABEL_SIZE 12

// 创建时间字体的大小
#define CREATE_TIME_SIZE 10

#define MARGIN 10



@interface LCStatusFrame : UITabBarItem


//1.要包含其对应的cell里面子控件的frame
@property (nonatomic, assign) CGRect originalViewF;


//基本数据模型
@property (nonatomic,strong)LCStatus *status;

/**
 *  头像
 */
@property (nonatomic ,assign)CGRect headImageF;
/**
 *  名字
 */
@property (nonatomic ,assign)CGRect nameLabelF;
/**
 *  原创微博的内容
 */
@property (nonatomic ,assign)CGRect contentLabelF;

/**
 *  创建时间
 */
@property (nonatomic ,assign)CGRect sourceLabelF;
/** vip图标 */
@property (nonatomic, assign) CGRect vipImageF;

//微博内容里面的图片
@property (nonatomic ,assign)CGRect photoViewF;

//发布时间
@property (nonatomic ,assign)CGRect createLabelF;


//底部的工具条(转发 评论 赞)
@property (nonatomic ,assign)CGRect statusToolBarF;


//转发微博视图
@property (nonatomic ,assign)CGRect retweetViewF;

//转发微博的相册
@property (nonatomic ,assign)CGRect retweetPhotoF;

//转发微博的整体内容的高度
@property (nonatomic ,assign)CGRect retweetContentLabelF;




//cell的行高
@property (nonatomic ,assign)CGFloat cellHeight;



@end
