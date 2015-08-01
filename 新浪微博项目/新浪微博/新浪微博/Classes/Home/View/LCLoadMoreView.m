//
//  LCLoadMoreView.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCLoadMoreView.h"

@implementation LCLoadMoreView

+(instancetype)loadMoreView{
 
    return [[[NSBundle mainBundle]loadNibNamed:@"LCLoadMoreView" owner:nil options:nil]lastObject];

}
@end
