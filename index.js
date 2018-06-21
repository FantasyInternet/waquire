const fs = require("fs")
const path = require("path")

let namespaces = []

function waquire(filename) {
  namespaces = []
  return wastify(bundle(require.resolve(filename, { paths: [__dirname] })))
}
function bundle(filename) {
  let ns = namespaces.indexOf(filename)
  if (ns >= 0) return ["module"]
  ns = namespaces.length
  namespaces.push(filename)
  let tree = parse("(\n" + fs.readFileSync(filename)).tree
  while (tree.length === 1 && typeof tree[0] !== "string") tree = tree[0]
  tree = renameVars(tree, "", "ns" + ns + ".")

  let newtree = ["module"]
  let importEnd = newtree.length
  let token
  while (token = tree.shift()) {
    if (typeof token === "string") {
      if (token.trim().substr(0, 10) === ";;@require") {
        let args = token.trim().split(/\s+/)
        let name = args[1].substr(1)
        let file = require.resolve(JSON.parse(args[2]), { paths: [path.dirname(filename)] })
        let subtree = bundle(file)
        let subns = namespaces.indexOf(file)
        tree = renameVars(tree, "ns" + ns + "." + name + ".", "ns" + subns + ".")
        tree.splice(0, 0, ...subtree)
      }
    } else if (token[0] === "import") {
      newtree.splice(importEnd++, 0, token)
    } else {
      newtree.push(token)
    }
  }

  return newtree
}

function renameVars(tree, search, replace) {
  let out = []
  for (let token of tree) {
    if (typeof token === "string") {
      if (token.substr(0, 1 + search.length) === "$" + search) {
        token = "$" + replace + token.substr(1 + search.length)
      }
    } else {
      token = renameVars(token, search, replace)
    }
    out.push(token)
  }
  return out
}

function parse(wast, pos) {
  pos = pos || wast.indexOf("(")
  let tree = []
  let token = ""
  pos++
  while (wast[pos] !== ")" && pos < wast.length) {
    if (wast.substr(pos, 3) === "(;;") {
      if (token) tree.push(token)
      token = wast.substring(pos, 1 + (pos = wast.indexOf(";;)", pos) + 2))
    } else if (wast.substr(pos, 2) === ";;") {
      if (token) tree.push(token)
      token = wast.substring(pos, 1 + (pos = wast.indexOf("\n", pos)))
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
function wastify(tree, indent) {
  indent = indent || "  "
  let str = "("
  for (let token of tree) {
    if (typeof token === "string") {
      str += token + " "
    } else {
      str += "\n" + indent + wastify(token, indent + "  ")
    }
  }
  return str + ")"
}
// console.log(wastify(parse(""+fs.readFileSync("./test/boot.wast")).tree))

module.exports = waquire