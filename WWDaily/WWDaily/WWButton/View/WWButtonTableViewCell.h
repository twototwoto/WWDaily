//
//  WWButtonTableViewCell.h
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class WWConfiguration;
//#import "WWConfiguration.h"

extern NSString* const WWButtonTableViewCellReuseIDString;
@interface WWButtonTableViewCell : UITableViewCell

/*! @brief 按钮类型 */
@property (nonatomic,assign) UIButtonType buttonType;

- (WWButtonTableViewCell *)initWithReuseIdentifier:(NSString *)reuseId buttonType:(UIButtonType)buttonType;
@end
