//
//  ShowViewController.m
//  WebImageShow
//


#import "NewsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "JTSImageViewController.h"
#import "ZYImageViewController.h"
#import "MBProgressHUD.h"
#import "UIWebView+PUSharkWeb.h"

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// RGBCOLOR(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface NewsDetailViewController ()<UIGestureRecognizerDelegate,JTSImageViewControllerAnimationDelegate,JTSImageViewControllerOptionsDelegate,UIWebViewDelegate>
@property (nonatomic,retain) UIWebView *showWebView;
@end

@implementation NewsDetailViewController{
    ZYImageViewController* zyImageViewer;
    UIImageView *_showView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    _showWebView.delegate = self;
    _showWebView.scalesPageToFit = YES;
    [self.view addSubview:_showWebView];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_showWebView loadRequest:urlRequest];
    [self addTapOnWebView];
}

-(void)addTapOnWebView
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.showWebView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint pt = [sender locationInView:self.showWebView];
    NSString *imgURL = [self.showWebView elementImgUrlWithPoint:pt];
    if (imgURL) {
        NSLog(@"image url=%@", imgURL);
        [self showImageURL:imgURL Frame:[self.showWebView imgFrameWithPoint:pt]];
    }
}

//呈现图片
-(void)showImageURL:(NSString *)url Frame:(CGRect)rect
{
    _showView = [[UIImageView alloc] initWithFrame:rect];
    _showView.clipsToBounds = YES;
    _showView.contentMode = UIViewContentModeScaleAspectFit;
    _showView.backgroundColor = [UIColor blackColor];
    _showView.userInteractionEnabled = YES;
    [self.view addSubview:_showView];
    [_showView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_showView setImage:image];
        [self showImageWithOrimageView:_showView];
    }];
}

- (void)showImageWithOrimageView:(UIImageView*)orimageView{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = orimageView.image;
    imageInfo.referenceRect = orimageView.frame;
    imageInfo.referenceView = orimageView.superview;
    imageInfo.referenceContentMode = orimageView.contentMode;
    imageInfo.referenceCornerRadius = orimageView.layer.cornerRadius;
    
    //Setup view controller
    zyImageViewer = [[ZYImageViewController alloc]
                     initWithImageInfo:imageInfo
                     mode:JTSImageViewControllerMode_Image
                     backgroundStyle:JTSImageViewControllerBackgroundOption_None];
    
    zyImageViewer.animationDelegate = self;
    zyImageViewer.optionsDelegate = self;
    zyImageViewer.bottomType = ZYImageViewControllerBottom_none;
    // Present the view controller.
    [zyImageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}

#pragma mark- TapGestureRecognizer
/**
 *  3.允许多个手势识别器共同识别
 
    默认情况下，两个gesture recognizers不会同时识别它们的手势,但是你可以实现UIGestureRecognizerDelegate协议中的
    gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:方法对其进行控制。这个方法一般在一个手势接收者要阻止另外一个手势接收自己的消息的时候调用，如果返回YES,则两个gesture recognizers可同时识别，如果返回NO，则并不保证两个gesture recognizers必不能同时识别，因为另外一个gesture recognizer的此方法可能返回YES。也就是说两个gesture recognizers的delegate方法只要任意一个返回YES，则这两个就可以同时识别；只有两个都返回NO的时候，才是互斥的。默认情况下是返回NO。
 *
 *  @param gestureRecognizer      手势
 *  @param otherGestureRecognizer 其他手势
 *
 *  @return YES代表可以多个手势同时识别，默认是NO，不可以多个手势同时识别
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"gestureRecognizer : %@",gestureRecognizer);
    NSLog(@"otherGestureRecognizer : %@",otherGestureRecognizer);
    return YES;
}

#pragma mark
#pragma mark JTSImageViewControllerAnimationDelegate
- (void)imageViewerWillBeginPresentation:(JTSImageViewController *)imageViewer withContainerView:(UIView *)containerView{
    [zyImageViewer.bottomContainer setHidden:YES];
}

-(void)imageViewerDidAnimatePresentation:(JTSImageViewController *)imageViewer withContainerView:(UIView *)containerView duration:(CGFloat)duration{
    [zyImageViewer.bottomContainer setHidden:NO];
}

- (void)imageViewerWillBeginDismissal:(JTSImageViewController *)imageViewer withContainerView:(UIView *)containerView{
    [zyImageViewer.bottomContainer setHidden:YES];
    [_showView removeFromSuperview];
}

- (CGFloat)alphaForBackgroundDimmingOverlayInImageViewer:(JTSImageViewController *)imageViewer{
    return 1;
}

#pragma mark
#pragma mark UIViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    MBProgressHUD *_hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText=@"网络太慢或网络中断";
    _hud.mode=MBProgressHUDModeText;
    [_hud hide:YES afterDelay:1];
}
@end
