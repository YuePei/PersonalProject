//
//  NoPictureTVCell.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/24.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "NoPictureTVCell.h"

@implementation NoPictureTVCell
- (instancetype)init {
    if (self = [super init]) {
        [self userName];
        [self releaseTime];
        [self contentLabel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self userName];
    [self releaseTime];
    [self contentLabel];
    
    return self;
    
}


#pragma mark lazy
- (UILabel *)userName {
    if (_userName == nil) {
        _userName = [[UILabel alloc]init];
        [self.contentView addSubview:_userName];
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        _userName.numberOfLines = 0;
        _userName.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:18];
        [_userName sizeToFit];
    }
    return _userName;
}

- (UILabel *)releaseTime {
    if (_releaseTime == nil) {
        _releaseTime = [UILabel new];
        [self.contentView addSubview:_releaseTime];
        [_releaseTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userName.mas_left);
            make.top.equalTo(self.userName.mas_bottom).offset(10);
        }];
        _releaseTime.numberOfLines = 1;
        
        NSDate *date = [[NSDate alloc]init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _releaseTime.text = [formatter stringFromDate:date];
        _releaseTime.font = [UIFont systemFontOfSize:15];
        _releaseTime.textColor = [UIColor lightGrayColor];
    }
    return _releaseTime;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userName.mas_left);
            make.top.equalTo(self.releaseTime.mas_bottom).offset(15);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-15);
        }];
        _contentLabel.numberOfLines = 3;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont boldSystemFontOfSize:14];
        _contentLabel.textColor = [UIColor grayColor];
    }
    return _contentLabel;
}





@end
