//
//  LCStatusCell.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusCell.h"
#import "LCStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "LCUser.h"
#import "LCStatus.h"
@interface LCStatusCell ()

//头像
@property(nonatomic,strong)UIImageView *headImage;

//微博昵称
@property(nonatomic,strong)UILabel *nameLabel;

//微博内容
@property(nonatomic,strong)UILabel *contentLabel;


@end


@implementation LCStatusCell


- (void)setStatusFrame:(LCStatusFrame *)statusFrame{
   
    _statusFrame =statusFrame;
    // 给子控件赋值
     // 给子控件设置位置
    
    NSString *userProfile =self.statusFrame.status.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userProfile]];
    self.headImage.frame = statusFrame.headImageF;
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text =statusFrame.status.user.screen_name;
    
    self.contentLabel.text = statusFrame.status.text;
    self.contentLabel.frame =statusFrame.contentLabelF;
    
    
    

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      // 必须先初始化父控件 >>必须要有super init...
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      // 添加子控件
        
        //添加头像
        UIImageView *headImage =[[UIImageView alloc]init];
        [self.contentView addSubview:headImage];
        self.headImage =headImage;
        
        //添加名字控件
        UILabel *nameLabel =[UILabel new];
        //设置名字大小
        nameLabel.font =SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:nameLabel];
        self.nameLabel =nameLabel;
        
        //添加内容控件
        UILabel *contentLabel =[UILabel new];
        contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
        contentLabel.numberOfLines =0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        
    
        
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
   
    LCStatusCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
 
    
    return cell;
}



@end
