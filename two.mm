#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#include <napi.h>


Napi::ThreadSafeFunction tsfn;

// Trigger the JS callback when active space changes
void listenForActiveSpaceChange(const Napi::CallbackInfo &info)
{
    Napi::Env env = info.Env();

    // Create a ThreadSafeFunction
    tsfn = Napi::ThreadSafeFunction::New(
        env,
        info[0].As<Napi::Function>(), // JavaScript function called asynchronously
        "Active Space",               // Name
        0,                            // Unlimited queue
        1                             // Only one thread will use this initially
    );

    // Create a native callback function to be invoked by the TSFN
    auto callback = [](Napi::Env env, Napi::Function jsCallback)
    {
        // Call the JS callback
        jsCallback.Call({});
    };

    // Subscribe to macOS spaces change event
    [[[NSWorkspace sharedWorkspace] notificationCenter]
        addObserverForName:NSWorkspaceActiveSpaceDidChangeNotification
                    object:NULL
                     queue:NULL
                usingBlock:^(NSNotification *note) {
                  // Perform a blocking call
                  napi_status status =
                      tsfn.BlockingCall(callback);
                  if (status != napi_ok)
                  {
                      NSLog(@"Something went wrong, BlockingCall failed");
                  }
                }];
}

Napi::Object init(Napi::Env env, Napi::Object exports)
{
    exports.Set(Napi::String::New(env, "listenForActiveSpaceChange"),
                Napi::Function::New(env, listenForActiveSpaceChange));

    return exports;
};

NODE_API_MODULE(mac_helper, init);