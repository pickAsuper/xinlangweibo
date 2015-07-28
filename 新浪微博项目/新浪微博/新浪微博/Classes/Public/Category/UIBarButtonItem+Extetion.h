//
//  UIBarButtonItem+Extetion.h
//  新浪微博
//
//  Created by lichao on 15/7/28.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extetion)

//导航栏上的按钮 设置
+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+(instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action titel:(NSString *)titel;
@end
