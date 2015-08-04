//
//  LCStatusPhotos.h
//  新浪微博
//
//  Created by lichao on 15/8/3.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCStatusPhotos : UIView


//为了获取图片张数
@property (nonatomic ,strong)NSArray *pic_url;




/**
 *  根据自己的显示个数,返回自己的大小
 */
+(CGSize)sizeWithCount:(NSInteger)count;



@end
