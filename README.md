waquire
=======
A tool to bundle multiple .wa(s)t-files together.

Usage
-----
To require a wast-file from another wast-file:

    (module
      ;;@require $mem "./_memory.wast"

      (func $init
        (call $mem.alloc (i32.const 1024))
      )
      (export "init" (func $init))
    )

To bundle from command line:

    $ sudo npm install -g waquire
    $ waquire main.wast > main.bundle.wast

To bundle from JavaScript:

    const waquire = require("waquire");
    const fs = require("fs");

    fs.writeFileSync("./main.bundle.wast", waquire("./main.wast"));
