//
//  SDetailVc.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SDetailVc.h"
#import "ShareListView.h"
#import "ShareCollectionViewCell.h"
#import "SurroundDetailSecondTableViewCell.h"
#import "SurroundPresentAnimation.h"
#import <objc/runtime.h>
#import "NSString+Tools.h"
#import "BottomBuyView.h"


@interface SDetailVc ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;
//iconsArray
@property (nonatomic, strong)NSArray *iconsArray;


//tableView的headerView
@property (nonatomic, strong)UIView *headView;
//商品名称
@property (strong, nonatomic) UILabel *goodsNameLabel;
//快递信息
@property (strong, nonatomic) UILabel *deliveryLabel;
//headView底部的灰条
@property (nonatomic, strong)UIView *grayView;

//底部功能条
@property (nonatomic, strong)BottomBuyView *buyView;

@end

@implementation SDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    [self headView];
    [self bigImageView];
    [self goodsNameLabel];
    [self priceLabel];
    [self oldPriceLabel];
    [self tagImageView];
    [self soldCount];
    [self deliveryLabel];
    [self grayView];
    
    [self buyView];
}

//本页面快要显示时 隐藏navigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//本页面快要消失时 显示navigationBar
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SurroundDetailSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"surroundSecondCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SurroundDetailSecondTableViewCell" owner:self options:nil].firstObject;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 550;
}

#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-ysStatusBarHeight);
            make.left.right.bottom.mas_equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"SurroundDetailBigImageViewTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"surroundDetailCell"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SurroundDetailSecondTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"surroundSecondCell"];
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 525)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    if ([self.goodsNameString charNumber]  / 2.0> 14) {
        [_headView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 555)];
    }
    return _headView;
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        _bigImageView = [UIImageView new];
        [self.headView addSubview:_bigImageView];
        [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(_bigImageView.mas_width);
        }];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageString]];
        UIImage *image = [UIImage imageWithData:data];
        _bigImageView.image = image;
    }
    return _bigImageView;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [UILabel new];
        [self.headView addSubview:_goodsNameLabel];
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.bigImageView.mas_bottom).offset(20);
            make.right.mas_equalTo(-20);
        }];
        _goodsNameLabel.numberOfLines = 2;
        _goodsNameLabel.font = [UIFont boldSystemFontOfSize:24];
        _goodsNameLabel.textColor = [UIColor blackColor];
        _goodsNameLabel.text = self.goodsNameString;
    }
    NSLog(@"--商品名--%@",_goodsNameLabel);
    return _goodsNameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        [self.headView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNameLabel.mas_left);
            make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(15);
        }];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:19];
        _priceLabel.text = @"¥99";
    }
    return _priceLabel;
}

- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [UILabel new];
        [self.headView addSubview:_oldPriceLabel];
        [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.priceLabel.mas_right).offset(20);
            make.centerY.mas_equalTo(self.priceLabel.centerY);
        }];
        _oldPriceLabel.textColor = [UIColor lightGrayColor];
        _oldPriceLabel.text = @"原价 998";
        _oldPriceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _oldPriceLabel;
}

- (UIImageView *)tagImageView {
    if (!_tagImageView) {
        _tagImageView = [UIImageView new];
        [self.headView addSubview:_tagImageView];
        [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oldPriceLabel.mas_right).offset(20);
            make.centerY.mas_equalTo(self.priceLabel.centerY);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
    }
    return _tagImageView;
}

- (UILabel *)soldCount {
    if (!_soldCount) {
        _soldCount = [UILabel new];
        [self.headView addSubview:_soldCount];
        [_soldCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNameLabel.mas_left);
            make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(15);
        }];
        _soldCount.text = @"包邮  已售: 48";
        _soldCount.font = [UIFont systemFontOfSize:15];
        _soldCount.textColor = [UIColor lightGrayColor];
    }
    return _soldCount;
}

- (UILabel *)deliveryLabel {
    if (!_deliveryLabel ) {
        _deliveryLabel = [UILabel new];
        [self.headView addSubview:_deliveryLabel];
        [_deliveryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.soldCount.mas_centerY);
        }];
        _deliveryLabel.text = @"| 5个工作日内发货";
        _deliveryLabel.font = [UIFont systemFontOfSize:15];
        _deliveryLabel.textColor = [UIColor colorWithRed:253 / 255.0 green:159 / 255.0 blue:51 / 255.0 alpha:1];
    }
    return _deliveryLabel;
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [UIView new];
        [self.headView addSubview:_grayView];
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        _grayView.backgroundColor = BackgroundColor;
    }
    return _grayView;
}

- (BottomBuyView *)buyView {
    if (!_buyView) {
        _buyView = [[BottomBuyView alloc]init];
        [self.view addSubview:_buyView];
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(ysTabBarHeight);
        }];
    }
    return _buyView;
}
@end
