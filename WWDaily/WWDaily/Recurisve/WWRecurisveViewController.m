//
//  WWRecurisveViewController.m
//  WWDaily
//
//  Created by wangyongwang on 2018/8/18.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWRecurisveViewController.h"

@interface WWRecurisveViewController ()

@end

@implementation WWRecurisveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"recursive";
    self.view.backgroundColor = [UIColor whiteColor];
    if ((arc4random() % 2) % 2) {
        [self tailRecurisveDemo];
    } else {
        [self recursiveDemo];
    }
    
}


#pragma mark - Private functions

- (void)recursiveDemo {

    //261412 开始崩溃 普通的递归的方式
    NSInteger normalSum = [self recurisveNum:261411];
    NSLog(@"normalSum = %ld", (long)normalSum);

    NSLog(@"%d", (0x01 << 31) - 1); //21 4748 3647
}

- (NSInteger)tailRecurisveDemo {
    
    NSInteger sum = [self tailRecurisveNum:1000000];
    NSLog(@"sum = %ld", (long)sum);
    return sum;
}

- (NSInteger)recurisveNum:(NSInteger)n {
    if (n <= 1) {
        return n;
    }
    return [self recurisveNum:(n-1)] + n;
}

- (NSInteger)tailRecurisveNum:(NSInteger)n {
    
    // https://zh.wikipedia.org/wiki/尾调用
    return [self tailRecurisveNum:n current:0];
}

- (NSInteger)tailRecurisveNum:(NSInteger)n current:(NSInteger)current {
    
    if (n == 0) {
        return current;
    } else {
         return [self tailRecurisveNum:(n - 1) current: (n + current)];
    }
}

- (void)openGLCLMetal {
    /**
     * https://developer.apple.com/metal/
     * http://www.cocoachina.com/cms/tags.php?/Metal/
     * https://www.oschina.net/news/96794/apple-deprecation-opencl
     *
     */
}

- (void)stackDemo {
    
    /**
     * http://wufawei.com/2014/03/symbolicating-ios-crash-logs/
     * https://blog.csdn.net/jasonblog/article/details/49909209
     * https://blog.csdn.net/jasonblog/article/details/49909163
     * https://toutiao.io/posts/aveig6/preview
     * https://segmentfault.com/a/1190000002711621
     * https://blog.csdn.net/SeanHuang1661/article/details/56488719
     * http://djs66256.github.io/2018/01/21/2018-01-21-运行时获取函数调用栈/
     * https://elliotsomething.github.io/2017/06/28/thread学习/
     * https://blog.csdn.net/mybelief321/article/details/9046955
     */
    
    [NSThread callStackSymbols];
    [NSThread callStackReturnAddresses];
    
}

- (void)memoryShare {
    /**
     * https://baike.baidu.com/item/堆栈/1682032
     */
    // 栈 2.000000--0x7ffee4905408 0.000000--0x7ffee4905410
    CGFloat a = 2.0;
    NSLog(@"%f--%p",a,&a);
    CGFloat b;
    NSLog(@"%f--%p", b, &b);
    
    NSString *str;
    
    // 初始化的数据 str3=str-0x1097b5850 str11=str11-0x1097b5870
    NSString *str1 = @"str";
    NSString *str2 = @"str";
    NSString *str11 = @"str11";
    NSString *str3 = [[NSString alloc]initWithString:str1];
    //未初始化的数据   strnew=-0x10b2eb338
    NSString *strnew = [NSString new];
    
    // 堆 str4=str-0xa000000007274733 str5=str11-0xa000031317274735
    NSString *str4 = [[NSString alloc]initWithFormat:@"%@",str1];
    NSString *str5 = [[NSString alloc]initWithFormat:@"%@",str11];
    
    NSLog(@"str=%@-%p",str,str);
    
    NSLog(@"str1=%@-%p",str1,str1);
    NSLog(@"str11=%@-%p",str11,str11);
    NSLog(@"str2=%@-%p",str2,str2);
    NSLog(@"str3=%@-%p",str3,str3);
    
    NSLog(@"strnew=%@-%p",strnew,strnew);
    
    NSLog(@"str4=%@-%p",str4,str4);
    NSLog(@"str5=%@-%p",str5,str5);
    
    NSObject *obj = [NSObject new];
    NSObject *obj2 = [NSObject new];
    NSLog(@"obj=%@--%p",obj,obj);
    NSLog(@"obj2=%@--%p",obj2,obj2);
    
    UIView *view1 = [UIView new];
    UIView *view2 = [UIView new];
    NSLog(@"%@--%p",view1,view1);
    NSLog(@"%@--%p",view2,view2);
}




@end
