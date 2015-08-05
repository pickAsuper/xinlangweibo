//
//  LCUser.h
//  新浪微博
//
//  Created by lichao on 15/7/31.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUser : NSObject
//用户名
@property (nonatomic ,copy)NSString *screen_name;

//用户头像
@property (nonatomic ,copy)NSString *profile_image_url;
@property (nonatomic ,copy)NSString *created_at;

/**
 *  会员类型-->如果mbtype>2就代表是会员
 */
@property (nonatomic, assign) NSInteger mbtype;

/**
 *  会员等级
 */
@property (nonatomic, assign) NSInteger mbrank;

/**
 *  可能通过这个值直接判断是否是vip
 */
@property (nonatomic, assign,getter=isVip) BOOL vip;


@end
