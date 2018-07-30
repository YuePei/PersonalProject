

//
//  CustomNavigationController.m
//  CustomNavigationController
//
//  Created by Peyton on 2018/3/19.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)initialize {
    
    // 设置导航items数据主题
    [self setupNavigationItemsTheme];
    // 设置导航栏主题
    [self setupNavigationBarTheme];
}


#pragma mark -  设置导航items数据主题
+ (void)setupNavigationItemsTheme {
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    // 设置字体颜色
    //normal
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    //Highlighted
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]} forState:UIControlStateHighlighted];
    //disabled
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
}

#pragma mark -  设置导航栏主题
+ (void)setupNavigationBarTheme {
    UINavigationBar * navBar = [UINavigationBar appearance];
    // 设置导航栏颜色
    [navBar setBarTintColor:[UIColor whiteColor]];
    // 设置导航栏title属性
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    //下面是设置导航栏透明
//    [navBar setTranslucent:YES];
//    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage new]];
    
    //设置导航栏为白色背景
    UIImage *image = [UIImage imageNamed:@"white"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //隐藏导航栏底部的横线
    [navBar setShadowImage:[UIImage new]];
}


#pragma mark -  拦截所有push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    //注意这个方法每次push进入某个页面都会调用, 所以此处的self.viewControllers.count可以用来大致识别是否为rootViewController
    if (self.viewControllers.count > 0) {
        if (self.viewControllers.count == 1) {
            // 如果navigationController的字控制器个数大于两个就隐藏
            viewController.hidesBottomBarWhenPushed = YES;
        }
        //设置返回按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        //1.解决了自定义的返回按钮导致屏幕左侧的右滑手势失效的bug,但是首页右滑会导致crash
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = nil;
        }
        //2.解决首页右滑会导致crash的bug
        UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftGesture)];
        leftEdgeGesture.edges = UIRectEdgeLeft;
        [self.viewControllers[0].view addGestureRecognizer:leftEdgeGesture];
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark -  拦截所有pop方法
- (void)back {
    [super popViewControllerAnimated:YES];
    //这里就可以自行修改返回按钮的各种属性等
}

- (void)handleLeftGesture {
    NSLog(@"-------右滑------");
}
@end
