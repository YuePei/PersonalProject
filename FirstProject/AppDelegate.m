//
//  AppDelegate.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageVC.h"
#import "CommunityVC.h"
#import "PersonCenterVC.h"
#import "SurroundVM.h"
#import "SurroundMPVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [Bmob registerWithAppKey:@"da271e047204ec4a26f4137cc7237530"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tb = [[UITabBarController alloc]init];
    //首页
    MainPageVC *mpVC = [[MainPageVC alloc] init];
    CustomNavigationController *nav1 = [[CustomNavigationController alloc]initWithRootViewController:mpVC];
    [nav1 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"帽子(g)"] selectedImage:[UIImage imageNamed:@"帽子"]]];
    [tb addChildViewController:nav1];
    
    //社区
    CommunityVC *communityVC = [[CommunityVC alloc] init];
    CustomNavigationController *nav2 = [[CustomNavigationController alloc]initWithRootViewController:communityVC];
    [nav2 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"足迹" image:[UIImage imageNamed:@"拖鞋(g)"] selectedImage:[UIImage imageNamed:@"拖鞋"]]];
    [tb addChildViewController:nav2];
    
    //周边
    SurroundMPVC *sMPVC = [[SurroundMPVC alloc]init];
    CustomNavigationController *nav3 = [[CustomNavigationController alloc]initWithRootViewController:sMPVC];
//    SWRevealViewController *revealVC = [[SWRevealViewController alloc]initWithRearViewController:[LeftVC new] frontViewController:nav3];
//    revealVC.rearViewRevealWidth = 200;
//    [revealVC setFrontViewPosition:FrontViewPositionLeft animated:YES];
    [nav3 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"周边" image:[UIImage imageNamed:@"游泳圈(g)"] selectedImage:[UIImage imageNamed:@"游泳圈"]]];
    [tb addChildViewController:nav3];
    
    //个人中心
    PersonCenterVC *pcVC = [[PersonCenterVC alloc]init];
    CustomNavigationController *nav4 = [[CustomNavigationController alloc]initWithRootViewController:pcVC];
    [nav4 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"指南针(g)"] selectedImage:[UIImage imageNamed:@"指南针"]]];
    [tb addChildViewController:nav4];
    
    [tb.tabBar setBackgroundImage:[UIImage new]];
    [tb.tabBar setShadowImage:[UIImage new]];
//    [tb.tabBar setBackgroundImage:[UIImage imageNamed:@"底部条"]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:33 / 255.0 green:36 / 255.0 blue:41 / 255.0 alpha:1]];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.window.rootViewController = tb;
    [self.window makeKeyAndVisible];
    
    //启动广告页
    [self setUpAdvertisementView];
    
    //3DTouch
    if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //创建3D模型
        UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"type1" localizedTitle:@"Lucy" localizedSubtitle:@"She's Lucy" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"喜欢"] userInfo:nil];
        UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"type2" localizedTitle:@"Lucy" localizedSubtitle:@"She's Lucy" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"消息"] userInfo:nil];
        UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"type3" localizedTitle:@"Lucy" localizedSubtitle:@"She's Lucy" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"收藏"] userInfo:nil];
        [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3]];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSString *type = shortcutItem.type;
    //根据type来判断点击了哪一个快捷按钮
    if ([type isEqualToString:@"type1"]) {
        NSLog(@"Clicked the first item");
    }else if ([type isEqualToString:@"type2"]) {
        NSLog(@"Clicked the second item");
    }else {
        NSLog(@"Clicked the third item");
    }
}

- (void)setUpAdvertisementView {
    AdversementView *adView = [[AdversementView alloc]initWithFrame:self.window.bounds];
    [adView showAdvertisement];
}

//将要挂起
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

//已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//将要进入后台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

//进入活跃状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//将要终止
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
