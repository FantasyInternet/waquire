const fs = require("fs")
const path = require("path")

let namespaces = []

function waquire(filename) {
  namespaces = []
  return bundle(filename)
}
function bundle(filename) {
  filename = path.resolve(filename)
  let ns = namespaces.indexOf(filename)
  if (ns >= 0) return ""
  ns = namespaces.length
  namespaces.push(filename)
  let wast = fs.readFileSync(filename)
  wast = renameVars(wast, "", "ns" + ns + ".")


  while (true) {
    let pos = wast.indexOf(";;@require ")
    if (pos < 0) break
    let req = wast.substring(pos, wast.indexOf("\n", pos))
    let p = 0
    let name = req.substring(p = req.indexOf("$") + 1, p = req.indexOf(" ", p))
    let file = path.resolve(path.dirname(filename), JSON.parse(req.substr(p)))
    let subwast = bundle(file)
    let subns = namespaces.indexOf(file)
    wast = renameVars(wast, "ns" + ns + "." + name + ".", "ns" + subns + ".")
    wast = wast.substr(0, pos) + subwast + wast.substr(pos = wast.indexOf("\n", pos))
  }

  return wast
}

function renameVars(wast, search, replace) {
  wast += "\n;;\"\\$\"\n"
  let pos = 0
  while (true) {
    pos = Math.min(wast.indexOf("$" + search, pos), wast.indexOf(";;", pos), wast.indexOf('"', pos))
    if (pos < 0) break
    if (wast.substr(pos, 2) === ";;") {
      pos = wast.indexOf("\n", pos)
    } else if (wast.substr(pos, 1) === '"') {
      while (true) {
        pos++
        pos = Math.min(wast.indexOf("\\", pos), wast.indexOf('"', pos))
        if (pos < 0) break
        if (wast.substr(pos, 1) === "\\") {
          pos++
        } else if (wast.substr(pos, 1) === '"') {
          break
        }
      }
      pos++
    } else if (wast.substr(pos, 1) === '$') {
      wast = wast.substr(0, pos + 1) + replace + wast.substr(pos + 1 + search.length)
      pos++
    }
  }
  return wast
}

module.exports = waquire