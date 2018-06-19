const waquire = require("../")
const fs = require("fs")

fs.writeFileSync("./boot.wast", waquire("./test.wast"))
