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

//原创微博内容的字体
#define CONTENT_LABEL_SIZE 12

#define MARGIN 10



@interface LCStatusFrame : UITabBarItem
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

//cell的行高
@property (nonatomic ,assign)CGFloat cellHeight;



@end
