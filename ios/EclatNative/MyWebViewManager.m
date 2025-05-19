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
    if (![_url isEqualToString:url] && url.length > 0) {
        _url = [url copy];
        NSURL *nsUrl = [NSURL URLWithString:url];
        
        if (nsUrl && nsUrl.scheme && nsUrl.host) {
            NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl];
            [self loadRequest:request];
        } else if (self.onLoadError) {
            self.onLoadError(@{
                @"error": @"Invalid URL format",
                @"url": url ?: @""
            });
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (self.onLoadError) {
        self.onLoadError(@{
            @"error": error.localizedDescription,
            @"url": webView.URL.absoluteString ?: @""
        });
    }
}

@end

@implementation MyWebViewManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(MyWebView)

- (UIView *)view {
    MyWebView *webView = [[MyWebView alloc] initWithFrame:CGRectZero];
    return webView;
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