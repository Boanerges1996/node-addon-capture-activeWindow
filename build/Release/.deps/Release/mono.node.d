cmd_Release/mono.node := c++ -bundle -framework CoreFoundation -framework IOKit -framework AppKit -undefined dynamic_lookup -Wl,-search_paths_first -mmacosx-version-min=10.15 -arch arm64 -L./Release -stdlib=libc++  -o Release/mono.node Release/obj.target/mono/three.o 
