#import "MyWebViewManager.h"
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>
#import <React/RCTConvert.h>

@interface MyWebView : WKWebView
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) RCTDirectEventBlock onLoadError;
@end

@implementation MyWebView

- (instancetype)initWithFrame:(CGRect)frame {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;
    self = [super initWithFrame:frame configuration:config];
    if (self) {
        self.navigationDelegate = self;
    }
    return self;
}

- (void)setUrl:(NSString *)url {
    if (![_url isEqualToString:url]) {
        _url = [url copy];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self loadRequest:request];
    }
}

@end

@implementation MyWebViewManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(MyWebView)

- (UIView *)view {
    return [[MyWebView alloc] initWithFrame:CGRectZero];
}

RCT_EXPORT_VIEW_PROPERTY(url, NSString)
RCT_EXPORT_VIEW_PROPERTY(onLoadError, RCTDirectEventBlock)

RCT_EXPORT_METHOD(goBack:(nonnull NSNumber *)reactTag) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
        UIView *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[MyWebView class]]) {
            [(MyWebView *)view goBack];
        }
    }];
}

RCT_EXPORT_METHOD(goForward:(nonnull NSNumber *)reactTag) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
        UIView *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[MyWebView class]]) {
            [(MyWebView *)view goForward];
        }
    }];
}

@end