//
//  RAYTableViewCell.m
//  RAYTableView
//
//  Created by 党磊 on 15/9/22.
//  Copyright (c) 2015年 党磊. All rights reserved.
//

#import "RAYTableViewCell.h"
#import "Masonry.h"

@interface RAYTableViewCell()



@end

@implementation RAYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        
        [self setupConstraint];
    }
    return self;
}

- (void)setupView {
    
    UIImageView *customImageView = [[UIImageView alloc] init];
    customImageView.layer.cornerRadius = 15.0f;
    customImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:customImageView];
    _customImageView = customImageView;
    
    // 重点1
    CGFloat preferredWidth = [UIScreen mainScreen].bounds.size.width - 75;
    
    UILabel *title = [[UILabel alloc] init];
    title.numberOfLines = 0;
    // 重点1
    title.preferredMaxLayoutWidth = preferredWidth;
    title.textColor = [UIColor grayColor];
    [self.contentView addSubview:title];
    _title = title;
    
    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.numberOfLines = 3;
    // 重点1
    subtitle.preferredMaxLayoutWidth = preferredWidth;
    [self.contentView addSubview:subtitle];
    _subTitle = subtitle;
}

- (void)setupConstraint {
    [self.customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15.0f);
        make.right.equalTo(self.title.mas_left).with.offset(-15.0f);
        make.left.equalTo(self.contentView).with.offset(15.0f);
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        // 重点2
        make.top.equalTo(self.contentView).with.offset(20.0f).with.priority(751);
        make.right.equalTo(self.contentView).with.offset(-15.0f);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(15.0f);
        make.right.equalTo(self.title);
        make.bottom.equalTo(self.contentView).with.offset(-15.0f).with.priority(749);
        make.left.equalTo(self.title);
    }];
}



@end
