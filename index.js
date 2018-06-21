const fs = require("fs")
const path = require("path")

let namespaces = []

function waquire(filename) {
  namespaces = []
  return bundle(require.resolve(filename, { paths: [__dirname] }))
}
function bundle(filename) {
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
    let file = require.resolve(JSON.parse(req.substr(p)), { paths: [path.dirname(filename)] })
    let subwast = bundle(file)
    let subns = namespaces.indexOf(file)
    pos = wast.lastIndexOf("(import")
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

function parse(wast, pos) {
  pos = pos || wast.indexOf("(")
  let tree = []
  let token = ""
  pos++
  while (wast[pos] !== ")" || pos > wast.length) {
    if (wast.substr(pos, 2) === ";;") {
      if (token) tree.push(token)
      token = wast.substring(pos, pos = wast.indexOf("\n", pos))
    } else if (wast.substr(pos, 1) === '"') {
      if (token) tree.push(token)
      token = wast[pos]
      while (true) {
        pos++
        token += wast[pos]
        // pos = Math.min(wast.indexOf("\\", pos), wast.indexOf('"', pos))
        // if (pos < 0) break
        if (wast.substr(pos, 1) === "\\") {
          pos++
          token += wast[pos]
        } else if (wast.substr(pos, 1) === '"') {
          break
        }
      }
    } else if (wast[pos] === "$") {
      if (token) tree.push(token)
      token = wast[pos]
    } else if (wast[pos] === "(") {
      if (token) tree.push(token)
      token = ""
      let parsed = parse(wast, pos)
      tree.push(parsed.tree)
      pos = parsed.pos
    } else if (wast[pos] && wast[pos].trim()) {
      token += wast[pos]
    } else if (token) {
      tree.push(token)
      token = ""
    }
    pos++
  }
  if (token) tree.push(token)
  return {
    tree: tree,
    pos: pos
  }
}
//console.log(JSON.stringify(parse('(module(import"env""pri nt"(func$print)))'), null, 2))

module.exports = waquire