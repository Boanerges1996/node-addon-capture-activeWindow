#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include <napi.h>

Napi::ThreadSafeFunction tsfn;
extern Napi::Env myEnv;
extern Napi::Function cb;

@interface MDAppController : NSObject <NSApplicationDelegate> {
    NSRunningApplication    *currentApp;
}
@property (retain) NSRunningApplication *currentApp;
@end

@implementation MDAppController
@synthesize currentApp;

- (id)init {
    if ((self = [super init])) {
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                      selector:@selector(activeAppDidChange:)
               name:NSWorkspaceDidActivateApplicationNotification object:nil];
    }

    return self;
}
- (void)dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}
- (void)activeAppDidChange:(NSNotification *)notification {

    self.currentApp = [[notification userInfo] objectForKey:NSWorkspaceApplicationKey];
    NSLog(@"currentApp == %@", currentApp.localizedName);
    cb.Call(myEnv.Global(),{Napi::String::New(myEnv,"currentApp.localizedName")});
}

void startOne(const Napi::CallbackInfo &info){

     myEnv = info.Env();
     cb = info[0].As<Napi::Function>();
     @autoreleasepool {
        [NSApplication sharedApplication];
        MDAppController *appController = [[MDAppController alloc] init];
        [NSApp setDelegate:appController];
        [NSApp run];
    }
}
@end

Napi::Object init(Napi::Env env,Napi::Object exports){
    exports.Set(Napi::String::New(env,"init"), Napi::Function::New(env,startOne));
    return exports;
}


NODE_API_MODULE(currentContext, init);

