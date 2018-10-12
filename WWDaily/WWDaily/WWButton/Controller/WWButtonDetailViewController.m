//
//  WWButtonDetailViewController.m
//  WWDaily
//
//  Created by wangyongwang on 2018/7/31.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWButtonDetailViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "WWConfiguration.h"
#import "WWButtonTableViewCell.h"

#import "WWButton.h"
#import "WWTouchCancelView.h"

#import "UIButton+touch.h"


static NSInteger kContentModeIndex = 0;
static NSInteger kCount = 0;
static NSInteger kAnimateCurrent = 0;
static NSInteger kKeyAnimateCurrent = 0;
static CGFloat kNavStatusH = 0.0;
static NSInteger kButtonEventTouchOrder = 0;

@interface WWButtonDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
/**TableView数据数组*/
@property (nonatomic,copy) NSArray *titleArray;
/** 按钮类型TableView */
@property (nonatomic,strong) UITableView *buttonTypeTableView;
/** 承载button的可变数组 */
@property (nonatomic,strong) NSMutableArray *buttonArrayM;
/** ContentModeButton */
@property (nonatomic,strong) UIButton *contentModeButton;
/** contentModeArray */
@property (nonatomic,copy) NSArray *contentModeArray;
/** 计数label */
@property (nonatomic,strong) UILabel *countLabel;
@end

@implementation WWButtonDetailViewController{
    UILabel *_enlargeButtonClickAreaContainerLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupButton];
//    return;
    [self prepareData];
    [self setupUI];
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

- (void)setupButton{
   
    
}



- (void)prepareData{
    self.titleArray = @[@"UIButton基础使用",@"UIButton ContentMode",@"UIButton 多个状态点击",@"UIButton 动画",
                        @"UIButton 扩大点击区域",@"UIButton 图片文字排列",@"UIButton image缓存",@"UIButton 自己实现"];
    self.buttonArrayM = [NSMutableArray arrayWithCapacity:9];
    _contentModeArray =     @[@"UIViewContentModeScaleToFill",@"UIViewContentModeScaleAspectFit",@"UIViewContentModeScaleAspectFill",@"UIViewContentModeRedraw",
                          @"UIViewContentModeCenter",@"UIViewContentModeTop",@"UIViewContentModeBottom",@"UIViewContentModeLeft",
                          @"UIViewContentModeRight",@"UIViewContentModeTopLeft",@"UIViewContentModeTopRight",@"UIViewContentModeBottomLeft",
                          @"UIViewContentModeBottomRight"];
    kCount = 0;
    kAnimateCurrent = 0;
    kNavStatusH =  self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    /*
     typedef NS_ENUM(NSInteger, UIViewContentMode) {
     UIViewContentModeScaleToFill,
     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     };
     */
}

- (void)setupUI{
    self.title = @"WWButtonDetail";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    [self.view addSubview:self.buttonTypeTableView];
    self.buttonTypeTableView.frame = self.view.bounds;
    self.buttonTypeTableView.delegate = self;
    self.buttonTypeTableView.dataSource = self;
    */
    
    NSLog(@"%zd",self.buttonType);
    switch (self.buttonType) {
        case WWButtonTypeNormal:
        {
            [self buttonBasicUse];
            break;
        }
        case WWButtonTypeContentMode:
        {
            [self buttonContentMode];
            break;
        }
        case WWButtonTypeClickState:
        {
            [self buttonClickState];
            break;
        }
        case WWButtonTypeAnimation:
        {
            [self buttonAnimate];
            break;
        }
        case WWButtonTypeEnlargeClickedArea:
        {
            [self buttonEnlargeClickArea];
            break;
        }
        case WWButtonTypeImageTextArrange:
        {
            [self buttonImageTextArrage];
            break;
        }
        case WWButtonTypeImageCache:
        {
            [self buttonImageCache];
            break;
        }
        case WWButtonTypeSelfRealize:
        {
            [self buttonSelfRealize];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 九宫格样式的button排列
- (void)buttonNinePalaceMap{
    NSInteger value = 0;
    CGFloat btnWH = 120.f;
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            value ++;
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            btn.frame = CGRectMake(col * btnWH, row * btnWH, btnWH, btnWH);
            [btn setTitle:[NSString stringWithFormat:@"%zd",value] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:48.f weight:UIFontWeightBold];
            btn.backgroundColor = [UIColor colorWithRed:((arc4random() % 256)/255.f) green:((arc4random() % 256)/255.f) blue:((arc4random() % 256)/255.f) alpha:1.f];
        }
    }
}

#pragma mark - UIButton 基础使用
- (void)buttonBasicUse{
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self buttonNinePalaceMap];
    NSArray *buttonTypeArr = @[@"UIButtonTypeCustom",
                         @"UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0)",
                         @"UIButtonTypeDetailDisclosure",
                         @"UIButtonTypeInfoLight",
                         @"UIButtonTypeInfoDark",
                         @"UIButtonTypeContactAdd",
                         @"UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos)",
                         @"UIButtonTypeRoundedRect = UIButtonTypeSystem"];
    NSInteger k = 0;
    CGFloat kButtonWidth = [UIScreen mainScreen].bounds.size.width / 3.f;
    CGFloat kButtonHeight = ([UIScreen mainScreen].bounds.size.height -self.navigationController.navigationBar.frame.size.height) / 3.f;
    
    
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            if (k > 7) {
                k = 7;
            }
            UIButton *btn = [UIButton buttonWithType:k];
            [self.buttonArrayM addObject:btn];
            btn.tag = k;
            [self.view addSubview:btn];
            btn.frame = CGRectMake(kButtonWidth *col, kButtonHeight * row, kButtonWidth, kButtonHeight);
            [btn setTitle:buttonTypeArr[k] forState:UIControlStateNormal];
            if (row == 2 && col == 2) {
                btn.tag = 8;
                [btn setTitle:@"复位" forState:UIControlStateNormal];
            }
            btn.titleLabel.numberOfLines = 0;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setBackgroundColor:[UIColor colorWithRed:(arc4random() % 256)/255.f green:(arc4random() % 256)/255.f blue:(arc4random() % 256)/255.f alpha:1.f]];
            k++;
            
            if (k == 4 || k == 5) {
                //此处看起来的 Dark 和 Light确实是一个暗一个亮，不过并不像是简单的理解的一个亮一个暗
                [btn setBackgroundColor:[UIColor blueColor]];
            }else{
                 [btn setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent: 1.0/9.0 * k]];
            }
        }
    }
    /**
     * 自带小图标的这种通常有的时候是放置在顶部的导航栏上的
     typedef enum UIButtonType : NSInteger {
     UIButtonTypeCustom = 0,    //自定义
     UIButtonTypeSystem,       //系统样式
     UIButtonTypeDetailDisclosure,  //详情发现 查看详情用的
     UIButtonTypeInfoLight, //信息亮点
     UIButtonTypeInfoDark,  //信息 暗
     UIButtonTypeContactAdd,    //添加联系人
     UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos), // standard system button without the blurred background view   //不适用iOS
     UIButtonTypeRoundedRect = UIButtonTypeSystem   //和系统内样式一样
     } UIButtonType;
     */
    
}

#pragma mark - buttonContentMode
- (void)buttonContentMode{
    
    NSInteger value = 0;
    CGFloat btnWH = 120.f;
    CGFloat margin = 8.f;
    for (NSInteger row = 0; row < 5; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            [btn setImage:[UIImage imageNamed:@"ninePalacePatch"] forState:UIControlStateNormal];
            btn.imageView.contentMode = value;
            btn.frame = CGRectMake(col * (btnWH + margin), row * (btnWH + margin), btnWH, btnWH);
            value ++;
            if (value >= 12) {
                value = 12;
            }
        }
    }
    
    return;
    
    UIButton *contentModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentModeButton = contentModeBtn;
    contentModeBtn.frame = CGRectMake(0, 0, 120.f, 120.f);
    contentModeBtn.center = self.view.center;
    [self.view addSubview:contentModeBtn];
    //oceanLove buttonSky ninePalacePatch
    [contentModeBtn setImage:[UIImage imageNamed:@"ninePalacePatch"] forState:UIControlStateNormal];
    //            btn.imageView.image = [UIImage imageNamed:@"ninePalacePatch"];
     contentModeBtn.imageView.contentMode = UIViewContentModeBottom;
    
    /**
     *
     typedef NS_ENUM(NSInteger, UIViewContentMode) {
     UIViewContentModeScaleToFill,
     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     };
     */
}

#pragma mark - button 点击状态
- (void)buttonClickState{
    //学习网址：https://www.jianshu.com/p/57b2c41448bf
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    UIButton *stateBtn = [UIButton new];
    stateBtn.timeInterval = 2.f;
    [self.view addSubview:stateBtn];
    stateBtn.frame = CGRectMake(0.f, 0.f, 300.f, 300.f);
//    stateBtn.center = self.view.center;
    stateBtn.backgroundColor = [UIColor lightGrayColor];
    [stateBtn setImage:
     [UIImage imageNamed:@"praise_normal"]
              forState:UIControlStateNormal];
    [stateBtn setImage:[UIImage imageNamed:@"praise_sel"]
              forState:UIControlStateSelected];
    //UIControlStateSelected
    //设置选中状态的高亮状态
       [stateBtn setImage:[UIImage imageNamed:@"praise_highlighted"]
                 forState:UIControlStateSelected|UIControlStateHighlighted];
    [stateBtn setImage:[UIImage imageNamed:@"praise_highlighted"]
              forState:UIControlStateHighlighted];
    [stateBtn addTarget:self
                 action:@selector(stateButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    
    //这个按钮没有做处理 点击间隔时间的控制
    UIButton *stateBtn2 = [UIButton new];
    [self.view addSubview:stateBtn2];
    stateBtn2.frame = CGRectMake(0.f, 350.f, 300.f, 300.f);
//    stateBtn2.center = self.view.center;
    stateBtn2.backgroundColor = [UIColor lightGrayColor];
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_normal"] forState:UIControlStateNormal];
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_sel"] forState:UIControlStateSelected];
    //UIControlStateSelected
    //设置选中状态的高亮状态
    [stateBtn2 setImage:[UIImage imageNamed:@"praise_highlighted"] forState:UIControlStateHighlighted];
    [stateBtn2 addTarget:self action:@selector(stateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _countLabel = [UILabel new];
    _countLabel.backgroundColor = [UIColor darkGrayColor];
    _countLabel.text = @"0";
    _countLabel.font = [UIFont systemFontOfSize:32.f];
    [self.view addSubview:_countLabel];
    _countLabel.frame = CGRectMake(0, 0, 300.f, 40.f);
    _countLabel.center = self.view.center;
    
    
    
    return;
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btnAdd];
    btnAdd.center = self.view.center;
    
    
    return;
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:btnAdd attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:btnAdd attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
    [self.view addConstraint:centerXConstraint];
    [self.view addConstraint:centerYConstraint];
    
}


#pragma mark - button 动画
- (void)buttonAnimate{
    
    /*
     NSInteger value = 0;
    NSArray *arr = @[@"scale rotate move",@"layer animate",@"",@"",@"",@"",@"",@"",@""];
    CGFloat btnWH = 120.f;
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            value ++;
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            btn.frame = CGRectMake(col * btnWH, row * btnWH, btnWH, btnWH);
            [btn setTitle:[NSString stringWithFormat:@"%zd",value] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:48.f weight:UIFontWeightBold];
            btn.backgroundColor = [UIColor colorWithRed:((arc4random() % 256)/255.f) green:((arc4random() % 256)/255.f) blue:((arc4random() % 256)/255.f) alpha:1.f];
        }
    }
    return;
     */
    CGFloat navStatusH =  self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    UIButton *animateBtn = [UIButton new];
    [animateBtn setTitle:@"scale move rotate" forState:UIControlStateNormal];
//    [animateBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    [self.view addSubview:animateBtn];
    animateBtn.backgroundColor = [UIColor blueColor];
    animateBtn.frame = CGRectMake(0, 0, 150.f, 150.f);
    
    CGPoint animateBtnCenter = self.view.center;
    animateBtnCenter.y -= navStatusH/2.f;
    ////(总的高度 - 导航的高度)/2
//    animateBtnCenter.y =((self.view.frame.size.height - navStatusH)/2.f);
    animateBtn.center = animateBtnCenter;
    [animateBtn addTarget:self
                action:@selector(animateButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
//    [animateBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    
    UIButton *basicAnimateBtn = [UIButton new];
    [self.view addSubview:basicAnimateBtn];
    basicAnimateBtn.frame = CGRectMake(0.0, 0.0, 150.0, 150.0);
    basicAnimateBtn.backgroundColor = [UIColor purpleColor];
    [basicAnimateBtn setTitle:@"opacity position transform.scale.x" forState:UIControlStateNormal];
    basicAnimateBtn.titleLabel.numberOfLines = 0;
    [basicAnimateBtn addTarget:self action:@selector(basicAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *keyAnimateBtn = [UIButton new];
    [keyAnimateBtn setTitle:@"KeyAnimate" forState:UIControlStateNormal];
    [keyAnimateBtn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    [self.view addSubview:keyAnimateBtn];
    keyAnimateBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 300.0, CGRectGetMaxY(self.view.frame) - navStatusH - 150.0 - 34.0,300.0, 150.0);
    
    keyAnimateBtn.backgroundColor = [UIColor redColor];
    [keyAnimateBtn addTarget:self action:@selector(keyAnimateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - button扩大点击区域
- (void)buttonEnlargeClickArea{
    NSLog(@"%s",__FUNCTION__);
    
    
    _enlargeButtonClickAreaContainerLabel = [UILabel new];
    _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor grayColor];
    _enlargeButtonClickAreaContainerLabel.frame = CGRectMake(0, 0, 200.0, 200.0);
    [self.view addSubview:_enlargeButtonClickAreaContainerLabel];
    _enlargeButtonClickAreaContainerLabel.center = self.view.center;
    _enlargeButtonClickAreaContainerLabel.userInteractionEnabled = YES;
    
    WWButton *enlargeClickAreaBtn = [WWButton new];
    enlargeClickAreaBtn.backgroundColor = [UIColor redColor];
    [_enlargeButtonClickAreaContainerLabel addSubview:enlargeClickAreaBtn];
    enlargeClickAreaBtn.frame = CGRectMake(.0, .0, 6.0, 6.0);
//    enlargeClickAreaBtn.center = containerV.center;
    enlargeClickAreaBtn.center = CGPointMake(_enlargeButtonClickAreaContainerLabel.bounds.size.width / 2.0, _enlargeButtonClickAreaContainerLabel.bounds.size.height / 2.0);
    [enlargeClickAreaBtn addTarget:self action:@selector(enlargeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    WWButton *reduceClickAreaBtn = [WWButton new];
    reduceClickAreaBtn.ww_expandValue = 40.0;
    [self.view addSubview:reduceClickAreaBtn];
    
    reduceClickAreaBtn.frame = CGRectMake(0, 0, 100.0, 100.0);
    [reduceClickAreaBtn addTarget:self action:@selector(enlargeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    reduceClickAreaBtn.backgroundColor = [UIColor cyanColor];
    
    WWTouchCancelView *touchCancelV = [WWTouchCancelView new];
    [reduceClickAreaBtn addSubview:touchCancelV];
    touchCancelV.frame = CGRectMake(0, 0, 20.0, 20.0);
    [reduceClickAreaBtn addSubview:touchCancelV];
    touchCancelV.backgroundColor = [UIColor yellowColor];
    touchCancelV.center = reduceClickAreaBtn.center;
    
    
    
    
    
    return;
    UIView *view = [UIView new];
    [self.view addSubview:view];
    view.frame = self.view.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor yellowColor];
    
}

#pragma mark - 按钮图片文字排列
- (void)buttonImageTextArrage{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    
    //如果是图片和文字的俯视图比较大的时候是可以
    btn.frame = CGRectMake(0, 0, 300.f, 300.f);
    //    btn.frame = CGRectMake(0, 0, 200.f, 200.f);
    [btn setTitle:@"QiShare" forState:UIControlStateNormal];
    btn.titleLabel.backgroundColor = [UIColor redColor];
//    btn.center = self.view.center;
    
    /**
     NSLog(@"%@",NSStringFromUIEdgeInsets(btn.imageEdgeInsets));
     NSLog(@"%@",NSStringFromUIEdgeInsets(btn.titleEdgeInsets));
     btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, )
     *  {0, 0, 0, 0}
     *  {0, 0, 0, 0}
     *
     */
    //需要先设置titleEdgeinsets 然后设置 imageEdgeinses 才行 因为知道这行代码 titleLabel的size才显示的是正常值 之前位置是有了但是size还是0
    //EdgeInsets的这种方式主要是靠的是 通过的测试得出来的结果
    btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView.frame.size.height, -btn.imageView.frame.size.width, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, btn.titleLabel.frame.size.height, -btn.titleLabel.frame.size.width);
    
//    return;
    
    UIButton *btn2 = [UIButton new];
    btn2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn2];
    [btn2 setImage:[UIImage imageNamed:@"QiShareLogo"] forState:UIControlStateNormal];
    
    //如果是图片和文字的俯视图比较大的时候是可以
    btn2.frame = CGRectMake(50.0, 320.0, 300.0, 300.0);
    //    btn.frame = CGRectMake(0, 0, 200.f, 200.f);
    [btn2 setTitle:@"QiShare" forState:UIControlStateNormal];
    btn2.titleLabel.backgroundColor = [UIColor cyanColor];
    //直接使用坐标系的方式 但是不能用这种方式因为一点击后马上恢复成了原来的样子
    //中心点平移多少和x平移多少都一样
    CGRect btnImgVRect = btn2.imageView.frame;
    btnImgVRect.origin.y = 0;
    btnImgVRect.origin.x += (CGRectGetMidX(btn2.bounds) - CGRectGetMidX(btn2.imageView.frame));
    btn2.imageView.frame = btnImgVRect;
    
    CGRect titleRect = btn2.titleLabel.frame;
    titleRect.origin.x -= (CGRectGetMidX(btn2.titleLabel.frame) - CGRectGetMidX(btn2.bounds));
    titleRect.origin.y = CGRectGetMaxY(btn2.imageView.frame);
    btn2.titleLabel.frame = titleRect;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:addBtn];
    addBtn.center = self.view.center;
}

#pragma mark - button image 缓存
- (void)buttonImageCache{
    UIButton *imgCacheBtn = [UIButton new];
    [imgCacheBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
    
}


- (void)buttonTest{
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100.f, 100.f);
    btn.center = self.view.center;
    NSURL *btnUrl = [NSURL URLWithString:@"http://seopic.699pic.com/photo/40000/8526.jpg_wh1200.jpg"];
    NSURL *highlightedURL = [NSURL URLWithString: @"http://seopic.699pic.com/photo/50021/5682.jpg_wh1200.jpg"];
    NSURL *selectedUrl = [NSURL URLWithString:@"http://seopic.699pic.com/photo/40009/0806.jpg_wh1200.jpg"];
    
//    [btn sd_setImageWithURL:btnUrl forState:UIControlStateNormal];
//    [btn sd_setImageWithURL:highlightedURL forState:UIControlStateHighlighted];
//    [btn sd_setImageWithURL:selectedUrl forState:UIControlStateSelected];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    /**场景有
     * 设置button的设置图片的contentMode的问题
     * 控制UIButton的图片和文字的间距问题 比如说上下 左右排列问题
     * button的设置点击的多个状态的时候的问题
     * 关于button的点击位置的区域 扩大点击区域
     * 给按钮添加动画 变大 缩小 或者是旋转的动画 亦或是 添加一个图片 之后做旋转的动画
     * 控制button的image的问题 缓存相关问题
     * 关于自己实现一个UIButton的问题
     */
    
}

#pragma mark - Action ----------

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.buttonType == WWButtonTypeContentMode) {
        if (kContentModeIndex == _contentModeArray.count) {
            kContentModeIndex = 0;
        }
        _contentModeButton.imageView.contentMode = (UIViewContentMode)_contentModeArray[kContentModeIndex];
        
        
        /**
         *
         typedef NS_ENUM(NSInteger, UIViewContentMode) {
         UIViewContentModeScaleToFill,
         UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
         UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
         UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
         UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         };
         */
        
    }
    kContentModeIndex++;
}

- (void)btnClicked:(UIButton *)sender{
    if (sender.tag == 8) {
        [self.buttonArrayM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((UIButton *)obj).enabled = YES;
        }];
        return;
    }
    sender.enabled = !sender.enabled;
}

- (void)handleButtonClicked{
    kCount ++;
    _countLabel.text = [NSString stringWithFormat:@"点击次数%zd",kCount];
}

- (void)stateButtonClicked:(UIButton *)sender{
    //
//    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleButtonClicked) object:sender];
//    [self performSelector:@selector(handleButtonClicked) withObject:sender afterDelay:2.f];
    sender.selected = !sender.selected;
    kCount ++;
    _countLabel.text = [NSString stringWithFormat:@"点击次数%zd",kCount];
    return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Loading...";
//    [hud showAnimated:YES];
    
    /*
    return;
    [[[UIAlertView alloc]initWithTitle:@"警告" message:@"message" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]show];
    
    return;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"警告" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertC animated:YES completion:nil];
    return;
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD dismissWithDelay:2.f];
    
    return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Loading...";
    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:3.f];
    
   */
    
}

#pragma mark - 按钮基础动画
- (void)basicAnimationButtonClicked:(UIButton *)sender{
    //,@"backgroundColor",@"rotation.y"
    NSArray *propertyArr = @[@"opacity",@"position",@"transform.scale.x"];
    // position center的位置
    NSArray *valueArr = @[@(1.0),@(0.0),[NSValue valueWithCGPoint:CGPointMake(300.0,300.0)],[NSValue valueWithCGPoint:sender.center],@(1.0),@(0.0),[UIColor redColor],[UIColor yellowColor],@(M_PI_2 / 3.f),@(M_PI_2 / 2.f)];
    
    
//    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:propertyArr[kCount]];
     CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:propertyArr[(kCount % propertyArr.count)]];
    
//    basicAnimation.removedOnCompletion = NO;
    basicAnimation.autoreverses = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    basicAnimation.duration = 1.0;
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        if(kCount >= propertyArr.count){
            kCount = 0;
        }
        basicAnimation.fromValue = valueArr[2 * (kCount)];
        basicAnimation.toValue = valueArr[2 * kCount + 1];
        
        
        
//        return;
//        basicAnimation.fromValue = valueArr[kCount];
//        basicAnimation.toValue = valueArr[kCount+1];
//        kCount ++;
//        basicAnimation.fromValue = [NSNumber numberWithInteger:1];
//        basicAnimation.toValue = [NSNumber numberWithInteger:0];
    }else{
        basicAnimation.fromValue = valueArr[2 * kCount + 1];
        basicAnimation.toValue = valueArr[2 * kCount];
        kCount ++;
        if(kCount >= propertyArr.count){
            kCount = 0;
        }
//        return;
//        basicAnimation.fromValue = valueArr[kCount];
//        basicAnimation.toValue = valueArr[kCount-1];
        
//        basicAnimation.fromValue = [NSNumber numberWithInteger:0];
//        basicAnimation.toValue = [NSNumber numberWithInteger:1];
    }
    
//    [sender.layer addAnimation:basicAnimation forKey:propertyArr[kCount]];
    [sender.layer addAnimation:basicAnimation forKey:propertyArr[(kCount % propertyArr.count)]];
    basicAnimation.fillMode = kCAFillModeForwards;
    
}

#pragma mark -
- (void)keyAnimateButtonClicked:(UIButton *)sender{
//    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@""];
//
//    keyAnim.duration = 2.0;
//
//    [sender.imageView.layer addAnimation:keyAnim forKey:@""];
    
    if (kKeyAnimateCurrent ++ % 2) {
        // create a CGPath that implements two arcs (a bounce)
        CGMutablePathRef thePath = CGPathCreateMutable();
        CGPathMoveToPoint(thePath,NULL,74.0,74.0);
//        CGPathAddCurveToPoint(thePath,NULL,74.0,500.0,
//                              320.0,500.0,
//                              320.0,74.0);
//        CGPathAddCurveToPoint(thePath,NULL,320.0,500.0,
//                              566.0,500.0,
//                              566.0,74.0);
        CGPathAddCurveToPoint(thePath,NULL,74.0,500.0,
                              120.0,500.0,
                              170.0,74.0);
        CGPathAddCurveToPoint(thePath,NULL,120.0,500.0,
                              200.0,500.0,
                              340.0,74.0);
        
        CAKeyframeAnimation * theAnimation;
        
        // Create the animation object, specifying the position property as the key path.
        theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        theAnimation.path=thePath;
        theAnimation.duration=5.0;
        
        // Add the animation to the layer.
        [sender.layer addAnimation:theAnimation forKey:@"position"];

        return;
    }
    
    
    // Animation 1
    CAKeyframeAnimation* widthAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderWidth"];
    NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @10.0, @5.0, @30.0, @0.5, @15.0, @2.0, @50.0, @0.0, nil];
    widthAnim.values = widthValues;
    widthAnim.calculationMode = kCAAnimationPaced;
    
    // Animation 2
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    colorAnim.values = colorValues;
    colorAnim.calculationMode = kCAAnimationPaced;
    
    // Animation group
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:colorAnim, widthAnim, nil];
    group.duration = 5.0;
    
    [sender.layer addAnimation:group forKey:@"BorderChanges"];
    
}

#pragma mark - animateButtonClicked
- (void)animateButtonClicked:(UIButton *)sender{
    NSLog(@"%s",__FUNCTION__);
    
//    [self basicAnimation:sender];
//    return;
    sender.selected = !sender.selected;
    NSInteger animateNum = kAnimateCurrent % 6;
    if (animateNum == 0 || animateNum == 1) {
        if (sender.selected) {
            [UIView animateWithDuration:1.f animations:^{
                
//                sender.transform = CGAffineTransformMakeScale(2.f, 2.f);
                sender.transform = CGAffineTransformScale(sender.transform, 2.f, 2.f);
            }];
        }else{
            [UIView animateWithDuration:1.f animations:^{
                sender.transform = CGAffineTransformIdentity;
            }];
            
        }
    }else if(animateNum == 2 || animateNum == 3){
        if (sender.selected) {
           sender.transform = CGAffineTransformMakeTranslation(100.f, 100.f);
            
        }else{
            sender.transform = CGAffineTransformIdentity;
            
        }
        
    }else{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI_2/3.f);
//        sender.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 0.4);
//        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI_2 * 0.4);
//        if (sender.selected) {
//            sender.transform = CGAffineTransformRotate(sender.transform, M_PI_4);
//        }else{
//            sender.transform = CGAffineTransformRotate(sender.transform, M_PI_4);
//        }
    }
    
    kAnimateCurrent ++;
}

#pragma mark - EnlargeButtonClicked
- (void)enlargeButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
//        _enlargeButtonClickAreaContainerLabel.text = @"已选中";
        _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor yellowColor];
        sender.backgroundColor = [UIColor blueColor];
        
    }else{
//        _enlargeButtonClickAreaContainerLabel.text = @"未选中";
        _enlargeButtonClickAreaContainerLabel.backgroundColor = [UIColor grayColor];
        sender.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case WWButtonTypeNormal:
            return 8;
            break;
            
        default:
            return 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WWButtonTableViewCell *btnCell = [[WWButtonTableViewCell alloc]initWithReuseIdentifier:@"reuseIdentifier" buttonType:indexPath.row];
    return btnCell;
    
    WWButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
         cell = [[WWButtonTableViewCell alloc]initWithReuseIdentifier:@"reuseIdentifier" buttonType:indexPath.row];
//        cell = [[WWButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
//
//        cell.buttonType = (UIButtonType)indexPath.row;
    }
    return cell;
//    return nil;
    WWButtonTableViewCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:WWButtonTableViewCellReuseIDString forIndexPath:indexPath];
    if (self.buttonType == WWButtonTypeNormal) {
        //
        buttonCell.buttonType = (UIButtonType)indexPath.row;
        /**
         typedef NS_ENUM(NSInteger, UIButtonType) {
         UIButtonTypeCustom = 0,                         // no button type
         UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0),  // standard system button
         
         UIButtonTypeDetailDisclosure,
         UIButtonTypeInfoLight,
         UIButtonTypeInfoDark,
         UIButtonTypeContactAdd,
         
         UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos), // standard system button without the blurred background view
         
         UIButtonTypeRoundedRect = UIButtonTypeSystem   // Deprecated, use UIButtonTypeSystem instead
         };
         */
    }
    
    return buttonCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.f;
}


#pragma mark - lazy load

- (UITableView *)buttonTypeTableView{
    if (!_buttonTypeTableView) {
        _buttonTypeTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [_buttonTypeTableView registerClass:[WWButtonTableViewCell class] forCellReuseIdentifier:WWButtonTableViewCellReuseIDString];
    }
    return _buttonTypeTableView;
}


- (void)eventOrderBtnTouchDown:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchDownRepeat:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchDragInside:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchDragOutside:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchDragEnter:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchDragExit:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchUpInside:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchUpOutside:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnTouchCancel:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnValueChanged:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventPrimaryActionTriggered:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventEditingDidBegin:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventEditingChanged:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventEditingDidEnd:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventEditingDidEndOnExit:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventAllTouchEvents:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventAllEditingEvents:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventApplicationReserved:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventSystemReserved:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}
- (void)eventOrderBtnEventAllEvents:(UIButton *)sender{
    WWLog(@"%zd",kCount ++);
}

#pragma mark - button 自己实现
- (void)buttonSelfRealize{
    kButtonEventTouchOrder = 0;
    UIButton *eventOrderBtn = [UIButton new];
    [self.view addSubview:eventOrderBtn];
    eventOrderBtn.frame = CGRectMake(100.0, 100.0, 200.0, 200.0);
    eventOrderBtn.backgroundColor = [UIColor redColor];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnValueChanged:) forControlEvents:UIControlEventValueChanged];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventPrimaryActionTriggered:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventAllTouchEvents:) forControlEvents:UIControlEventAllTouchEvents];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventAllEditingEvents:) forControlEvents:UIControlEventAllEditingEvents];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventApplicationReserved:) forControlEvents:UIControlEventApplicationReserved];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventSystemReserved:) forControlEvents:UIControlEventSystemReserved];
    [eventOrderBtn addTarget:self action:@selector(eventOrderBtnEventAllEvents:) forControlEvents:UIControlEventAllEvents];
    
    //一般都会调用的是 UIControlEventTouchDown 如果是拖拽的话 会调用UIControlEventTouchDragInside 之后可能有UIControlEventTouchUpInside 等
    
    /*
     typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
     UIControlEventTouchDown                                         = 1 <<  0,      // on all touch downs
     UIControlEventTouchDownRepeat                                   = 1 <<  1,      // on multiple touchdowns (tap count > 1)
     UIControlEventTouchDragInside                                   = 1 <<  2,
     UIControlEventTouchDragOutside                                  = 1 <<  3,
     UIControlEventTouchDragEnter                                    = 1 <<  4,
     UIControlEventTouchDragExit                                     = 1 <<  5,
     UIControlEventTouchUpInside                                     = 1 <<  6,
     UIControlEventTouchUpOutside                                    = 1 <<  7,
     UIControlEventTouchCancel                                       = 1 <<  8,
     
     UIControlEventValueChanged                                      = 1 << 12,     // sliders, etc.
     UIControlEventPrimaryActionTriggered NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 13,     // semantic action: for buttons, etc.
     
     UIControlEventEditingDidBegin                                   = 1 << 16,     // UITextField
     UIControlEventEditingChanged                                    = 1 << 17,
     UIControlEventEditingDidEnd                                     = 1 << 18,
     UIControlEventEditingDidEndOnExit                               = 1 << 19,     // 'return key' ending editing
     
     UIControlEventAllTouchEvents                                    = 0x00000FFF,  // for touch events
     UIControlEventAllEditingEvents                                  = 0x000F0000,  // for UITextField
     UIControlEventApplicationReserved                               = 0x0F000000,  // range available for application use
     UIControlEventSystemReserved                                    = 0xF0000000,  // range reserved for internal framework use
     UIControlEventAllEvents                                         = 0xFFFFFFFF
     };
     */
}

- (void)readMe{
    /**
     * 控制设置约束的时候 从哪里开始 是导航栏的地步开始 还是整个屏幕的顶部开始
     * 关键代码
     view.translatesAutoresizingMaskIntoConstraints = NO;
     * self.edgesForExtendedLayout = UIRectEdgeNone;
     * 上下左右的那种约束 添加到父视图上边
     * 高度宽度 的那种约束添加到自己的身上
     */
}


@end
