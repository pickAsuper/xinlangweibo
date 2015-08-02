//
//  LCStatusFrame.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusFrame.h"

@implementation LCStatusFrame

-(void)setStatus:(LCStatus *)status{
    _status =status;
    
    //给LCStatusFrame的成员 frame 赋值
    CGFloat headW =30;
    CGFloat headH =20;
    self.headImageF =CGRectMake(MARGEN,MARGEN, headW, headH);

    
//    self.nameLabelF =CGRectMake(10, 10, 20,20 );
   self.contentLabelF =CGRectMake(20, 20, 20, 20);
}
 

@end
