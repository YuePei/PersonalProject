//
//  LeftVC.m
//  AnimationPractice
//
//  Created by MacBook Air on 17/11/16.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "LeftVC.h"

@interface LeftVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *manualArr;
@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    //获取uuid
    CFUUIDRef  personUUId = CFUUIDCreate(NULL);
    CFStringRef personUUIdString = CFUUIDCreateString(NULL, personUUId);
    NSLog(@"%@",personUUIdString);
    CFRelease(personUUId);
    //转换成NSString
    NSString *uuidString = [NSString stringWithString:(__bridge NSString * _Nonnull)(personUUIdString)];
    //获取iOS版本
    NSString *sysVersionStr = [UIDevice currentDevice].systemVersion;
    NSLog(@"%@",sysVersionStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.manualArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.manualArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRevealViewController *revealVC = self.revealViewController;
    switch (indexPath.row) {
            case 0:
            [revealVC pushFrontViewController:[[UINavigationController alloc]initWithRootViewController:[SurroundMPVC new]] animated:YES];
            break;
            case 1:
            [revealVC pushFrontViewController:[[UINavigationController alloc]initWithRootViewController:[BasicAnimationVC new]] animated:YES];
            break;
        case 2:
            [revealVC pushFrontViewController:[[UINavigationController alloc]initWithRootViewController:[KeyFrameAnimationVC new]] animated:YES];

            break;
        case 3:
            [revealVC pushFrontViewController:[GroupAnimationVC new] animated:YES];
            break;
        case 4:
            [revealVC pushFrontViewController:[TransitionAnimationVC new] animated:YES];
            break;
        case 5:
            
            break;
        case 6:
            [revealVC pushFrontViewController:[ComprehensiveAnimationVC new] animated:YES];
            break;
        default:
            break;
    }
}



#pragma mark lazy
- (NSArray *)manualArr {
    return @[@"基础动画",@"关键帧动画",@"组动画",@"过渡动画",@"仿射变换",@"综合案例"];
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

@end
