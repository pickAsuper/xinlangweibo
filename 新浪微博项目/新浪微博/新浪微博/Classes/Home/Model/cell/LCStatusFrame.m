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
#import "LCStatusPhotos.h"
#import "NSString+Extension.h"

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
    
    if (status.user.isVip) {
        CGFloat vipImageX = CGRectGetMaxX(self.nameLabelF) + MARGIN;
        CGFloat vipImageY = headY;
        CGSize vipImageSize = CGSizeMake(nameSize.height, nameSize.height);
     
        self.vipImageF = (CGRect){{vipImageX, vipImageY},vipImageSize};

    
    }
    
    
    
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
   // CGFloat statusToolBarY = CGRectGetMaxY(self.contentLabelF)+MARGIN;
    CGFloat originalViewH =CGRectGetMaxY(self.contentLabelF)+MARGIN;
    
    //根据是否有图片去计算frame
    if (status.pic_urls.count) {
        CGFloat photoViewX = headX;
        CGFloat photoViewY =CGRectGetMaxY(self.contentLabelF)+MARGIN;
        
        CGSize photoViewSize  =[LCStatusPhotos sizeWithCount:self.status.pic_urls.count];
       
        self.photoViewF = (CGRect){{photoViewX,photoViewY},photoViewSize};
       // statusToolBarY = CGRectGetMaxY(self.photoViewF)+MARGIN;
        originalViewH =CGRectGetMaxY(self.photoViewF)+MARGIN;
        
    }
    
    //计算原创微博整体view的大小
    CGFloat originalViewX =0;
    CGFloat originalViewY =MARGIN;
    CGSize originalViewSize = CGSizeMake(SCREENW, originalViewH);
    self.originalViewF =(CGRect){{originalViewX,originalViewY},originalViewSize};

    //底部工具条的Y值
    CGFloat statusToolBarY =CGRectGetMaxY(self.originalViewF);

  
    
    
    //计算转发微博的frame
    if (status.retweeted_status) {
        
        //1.计算转发微博正文的frame
           CGFloat retweetContentLabelX =MARGIN;
            CGFloat retweetContentLabelY =MARGIN;
           
            NSString *retweetContent =[NSString stringWithFormat:@"@%@%@",status.retweeted_status.user.screen_name,status.retweeted_status.text];
        
        CGSize retweetContentLabelSize = [retweetContent sizeWithFont:SYS_FONT(CONTENT_LABEL_SIZE) constrainedToSize:CGSizeMake(SCREENW -2 *MARGIN, MAXFLOAT)];

            //转发内容的位置
            self.retweetContentLabelF =(CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
         //第一次计算转发微博是相对于整体的View的高度 >> 相对于转发微博内容来说的
        CGFloat retweetViewH =CGRectGetMaxY(self.retweetContentLabelF)+MARGIN;
       
   
        
        //2.计算转发微博的 >>如果有配图
    if (status.retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotoX = MARGIN;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF)+MARGIN;
            CGSize retweetPhotoSize = [LCStatusPhotos sizeWithCount:status.retweeted_status.pic_urls.count];
            self.retweetPhotoF =(CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotoSize};

        //如果转发微博有配图,转发微博的整体View的高度要相对于转化微博配图view的最大y值去计算
            retweetViewH = CGRectGetMaxY(self.retweetPhotoF)+MARGIN;
        
          }
        
        //计算转发 整体微博的view 的大小
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF)-10;
        CGSize retweetViewSize = CGSizeMake(SCREENW, retweetViewH);
        self.retweetViewF = (CGRect){{retweetViewX,retweetViewY},retweetViewSize};
       
        //如果转发微博的话 ,这个statusToolBarY 的最大Y 就是转发微博view的最大Y值
        statusToolBarY =CGRectGetMaxY(self.retweetViewF);
    
        }

        CGFloat statusToolBarX =0;
        CGSize statusToolBarSize = CGSizeMake(SCREENW, 35);
        self.statusToolBarF =(CGRect){{statusToolBarX,statusToolBarY},statusToolBarSize};
        
    
    //cell行高
    self.cellHeight = CGRectGetMaxY(self.statusToolBarF);
        
    
}

@end
