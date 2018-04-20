
//
//  Basic.h
//  FirstProject
//
//  Created by MacBook Air on 2018/1/25.
//  Copyright © 2018年 BJ. All rights reserved.
//

#ifndef Basic_h
#define Basic_h


#endif /* Basic_h */


/* !weak self*/
#define PRO_WEAKSELF typeof(self) __weak weakSelf = self
#define PRO_WeakSelf(type)  __weak typeof(type) weak##type = type;

/*Font size*/
#define PRO_FontSize(fontSize) [UIFont systemFontOfSize:fontSize]

/**
 *  获取iOS版本
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

//#define isiOS10 ([[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] stringByAppendingString:@"0"] intValue] == 10)

#define isiOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/*! 大于8.0 */
#define IOS8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define iPhone4_BOOL ([UIScreen mainScreen].bounds.size.height==480?YES:NO)
#define iPhone5_BOOL ([UIScreen mainScreen].bounds.size.height==568?YES:NO)

#define iPhone6_BOOL ([UIScreen mainScreen].bounds.size.height==667?YES:NO)
#define iPhone6_plus_BOOL ([UIScreen mainScreen].bounds.size.height==736?YES:NO)

//背景颜色，浅灰色
#define BacgroundColor [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1]

//RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define SetViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];



//如果支持横屏
// 当前Xcode支持iOS8及以上
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
//#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
//#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
//#else
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//#endif

