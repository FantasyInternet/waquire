const waquire = require("../")
const fs = require("fs")

fs.writeFileSync("./bundle.wast", waquire("./test.wast"))
