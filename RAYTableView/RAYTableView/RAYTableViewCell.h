//
//  RAYTableViewCell.h
//  RAYTableView
//
//  Created by 党磊 on 15/9/22.
//  Copyright (c) 2015年 党磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAYTableViewCell : UITableViewCell


/** 显示头像 */
@property (weak, nonatomic) UIImageView *customImageView;
/** 显示昵称 */
@property (weak, nonatomic) UILabel *title;
/** 显示内容 */
@property (weak, nonatomic) UILabel *subTitle;
@end
