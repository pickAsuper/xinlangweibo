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
    
    
    // 时间位置
    CGFloat createLabelX = CGRectGetMaxX(self.headImageF)+MARGIN;
    CGFloat createLabelY = CGRectGetMaxY(self.nameLabelF)+MARGIN *0.5;
    CGSize createLabelSize = [self.status.created_at sizeWithFont:SYS_FONT(CREATE_TIME_SIZE)];
    
    self.createLabelF = (CGRect){{createLabelX,createLabelY},createLabelSize};
    
    //来源的位置放在时间的后面
    CGFloat sourceLabelX =CGRectGetMaxX(self.createLabelF) + MARGIN;
    CGFloat sourceLabelY =createLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:SYS_FONT(CREATE_TIME_SIZE)];
    self.sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    
    
    //微博内容的位置
    CGFloat contentLabelX = headX;
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contentLabelSize = [self.status.text sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENW - 2 *MARGIN, MAXFLOAT)];
    
    self.contentLabelF =(CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    //底部工具条的Y值
    CGFloat statusToolBarY = CGRectGetMaxY(self.contentLabelF)+MARGIN;
    
    if (status.thumbnail_pic) {
        CGFloat photoViewX = headX;
        CGFloat photoViewY =CGRectGetMaxY(self.contentLabelF)+MARGIN;
        CGSize photoViewSize = CGSizeMake(70, 70);
        
        self.photoViewF =(CGRect){{photoViewX,photoViewY},photoViewSize};
        
        statusToolBarY =CGRectGetMaxY(self.photoViewF)+ MARGIN;
       // self.cellHeight =CGRectGetMaxY(self.photoViewF);
    
    }
    
        CGFloat statusToolBarX =0;
        CGSize statusToolBarSize = CGSizeMake(SCREENW, 35);
        self.statusToolBarF =(CGRect){{statusToolBarX,statusToolBarY},statusToolBarSize};
        
    
    //cell行高
    self.cellHeight = CGRectGetMaxY(self.statusToolBarF);
        
    
}

@end
