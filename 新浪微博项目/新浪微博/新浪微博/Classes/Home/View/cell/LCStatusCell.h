//
//  LCStatusCell.h
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define identifier @"LCStatusCell"

@class LCStatusFrame;

@interface LCStatusCell : UITableViewCell

@property (nonatomic,strong)LCStatusFrame *statusFrame;

//加载cell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
