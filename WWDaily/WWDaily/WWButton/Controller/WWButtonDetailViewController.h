//
//  WWButtonDetailViewController.h
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWConfiguration.h"
///**
// @[@"基础使用",@"Button ContentMode",@"Button多个状态点击",@"Button 动画",@"button 扩大点击区域",@"Button 图片文字排列",@"Button image缓存",@"Button 自己实现"];
// */
//typedef NS_ENUM(NSInteger,WWButtonType){
//    WWButtonTypeNormal,
//    WWButtonTypeContentMode,
//    WWButtonTypeClickState,
//    WWButtonTypeAnimation,
//    WWButtonTypeEnlargeClickedArea,
//    WWButtonTypeImageTextArrange,
//    WWButtonTypeImageCache,
//    WWButtonTypeSelfRealize,
//};

/**
 按钮详情VC
 */
@interface WWButtonDetailViewController : UIViewController

/*! Button类型 */
@property (nonatomic,assign) WWButtonType buttonType;



@end
