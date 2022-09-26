{
    "targets": [
        {
            "target_name": "hello",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            # myModule is the name of your native addon
            "target_name": "hello",
            "sources": ["one.cc"],
            "include_dirs": [
                "<!@(node -p \"require('node-addon-api').include\")"
            ],
            'defines': ['NAPI_DISABLE_CPP_EXCEPTIONS'],
        },
        {
            "target_name": "listen",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            'xcode_settings': {
                'DEFINES_MODULE': 'YES',
                'MACOSX_DEPLOYMENT_TARGET': '10.15',
                'GCC_OPTIMIZATION_LEVEL': '0',
                'CLANG_ENABLE_MODULES': 'YES',
                'CLANG_ENABLE_OBJC_ARC': 'YES',
                "OTHER_CPLUSPLUSFLAGS": ["-std=c++11", "-stdlib=libc++", "-mmacosx-version-min=10.10"],
                "OTHER_LDFLAGS": ["-framework CoreFoundation -framework IOKit -framework AppKit"]
            },
            # myModule is the name of your native addon
            "target_name": "listen",
            "sources": ["two.mm"],
            "include_dirs": [
                "<!@(node -p \"require('node-addon-api').include\")"
            ],
            'defines': ['NAPI_DISABLE_CPP_EXCEPTIONS'],
        },
        {
            "target_name": "mono",
            "cflags!": ["-fno-exceptions"],
            "cflags_cc!": ["-fno-exceptions"],
            'xcode_settings': {
                'DEFINES_MODULE': 'YES',
                'MACOSX_DEPLOYMENT_TARGET': '10.15',
                'GCC_OPTIMIZATION_LEVEL': '0',
                'CLANG_ENABLE_MODULES': 'YES',
                'CLANG_ENABLE_OBJC_ARC': 'YES',
                "OTHER_CPLUSPLUSFLAGS": ["-std=c++11", "-stdlib=libc++", "-mmacosx-version-min=10.10"],
                "OTHER_LDFLAGS": ["-framework CoreFoundation -framework IOKit -framework AppKit"]
            },
            # myModule is the name of your native addon
            "target_name": "mono",
            "sources": ["three.mm"],
            "include_dirs": [
                "<!@(node -p \"require('node-addon-api').include\")"
            ],
            'defines': ['NAPI_DISABLE_CPP_EXCEPTIONS'],
        }
    ]
}
