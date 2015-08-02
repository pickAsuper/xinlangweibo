//
//  LCStatusFrame.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusFrame.h"
#import "LCStatus.h"
#import "LCUser.h"

@implementation LCStatusFrame

-(void)setStatus:(LCStatus *)status{
    _status =status;
    
    //给LCStatusFrame的成员 frame 赋值
    // 头像的位置
    CGFloat headX =MARGIN;
    CGFloat headY =MARGIN;
    CGFloat headWH = 30;
    self.headImageF =CGRectMake(headX, headY, headWH, headWH);
    
    //微博昵称的位置
    CGFloat nameLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGFloat nameLabelY = headY;
    //根据字体大小算出 size
    CGSize nameSize = [self.status.user.screen_name sizeWithFont:SYS_FONT(NAME_LABEL_SIZE)];
    self.nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameSize};
    
    CGFloat contentLabelX = headX;
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contentLabelSize = [self.status.text sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENW - 2 *MARGIN, MAXFLOAT)];
    
    self.contentLabelF =(CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    //cell行高
    self.cellHeight = CGRectGetMaxY(self.contentLabelF);
}
 

@end
