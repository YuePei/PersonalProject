//
//  PCTableViewCell.m
//  FirstProject
//
//  Created by Peyton on 2018/4/26.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "PCTableViewCell.h"

@implementation PCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, BackgroundColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height - 0.5, rect.size.width - 20, 0.5));
}
@end
