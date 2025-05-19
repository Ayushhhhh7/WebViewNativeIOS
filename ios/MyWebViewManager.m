#import "MyWebViewManager.h"

@interface MyWebView : WKWebView
@property (nonatomic, copy) NSString *url;
@end

@implementation MyWebView

- (instancetype)initWithFrame:(CGRect)frame {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
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

RCT_EXPORT_MODULE(MyWebView)

- (UIView *)view {
    return [[MyWebView alloc] initWithFrame:CGRectZero];
}

RCT_EXPORT_VIEW_PROPERTY(url, NSString)

@end