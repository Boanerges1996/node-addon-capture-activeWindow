#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include <node_api.h>
#include "napi.h"

@interface MDAppController : NSObject <NSApplicationDelegate>
{
    NSRunningApplication *currentApp;
}
@property(retain) NSRunningApplication *currentApp;
@end

@implementation MDAppController
@synthesize currentApp;

- (id)init
{
    if ((self = [super init]))
    {
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                               selector:@selector(activeAppDidChange:)
                                                                   name:NSWorkspaceDidActivateApplicationNotification
                                                                 object:nil];
    }
    return self;
}
- (void)dealloc
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    //    [super dealloc];
}
- (void)activeAppDidChange:(NSNotification *)notification
{
    self.currentApp = [[notification userInfo] objectForKey:NSWorkspaceApplicationKey];
    NSLog(@"currentApp == %@", currentApp.localizedName);
}
@end

int main(int argc, const char *argv[])
{
    @autoreleasepool
    {
        [NSApplication sharedApplication];
        MDAppController *appController = [[MDAppController alloc] init];
        [NSApp setDelegate:appController];
        [NSApp run];

        return 0;
    }
}
