//
//  FirstKindTableViewCell.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/24.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "FirstKindTableViewCell.h"

@implementation FirstKindTableViewCell
- (instancetype)init {
    if(self = [super init]) {
        
        [self userName];
        [self releaseTime];
        [self contentLabel];
        [self contentIV];
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
    [self contentIV];
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
            make.left.mas_equalTo(self.userName.mas_left);
            make.top.mas_equalTo(self.userName.mas_bottom).offset(10);
            make.right.mas_equalTo(-20);
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
            make.left.mas_equalTo(self.userName.mas_left);
            make.top.mas_equalTo(self.releaseTime.mas_bottom).offset(15);
            make.right.mas_equalTo(-20);
        }];
        _contentLabel.numberOfLines = 3;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.font = [UIFont fontWithName:@"AppleGothic" size:15];
        _contentLabel.textColor = [UIColor darkGrayColor];
    }
    return _contentLabel;
}

- (UIImageView *)contentIV {
    
    if (_contentIV == nil) {
        _contentIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_contentIV];
        [_contentIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
            make.centerX.equalTo(self.contentView);
            make.bottom.mas_equalTo(-15);
//            make.width.mas_equalTo(SCREEN_WIDTH - 20 * 2);
//            make.height.mas_equalTo(_contentIV.frame.size.width * 1.2);
        }];
//        _contentIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _contentIV;
}

@end
