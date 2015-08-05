//
//  LCUser.m
//  新浪微博
//
//  Created by lichao on 15/7/31.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCUser.h"

@implementation LCUser

//是否是会员
// 因为是否是vip这个属性是通过mbtype来决定 ,所以说可以在setMbTYPE的时候去设置isVip
-(void)setMbtype:(NSInteger)mbtype{
    _mbrank=mbtype;
    _vip =mbtype >2;
    

}


@end
