(module


  ;; Push memory range to buffer stack.
  (import "env" "pushFromMemory" (func $ns1.pushFromMemory (param $ns1.offset i32) (param $ns1.length i32)))
  ;; Pop one buffer off the buffer stack and store in memory.
  (import "env" "popToMemory" (func $ns1.popToMemory (param $ns1.offset i32)))
  (import "env" "getBufferSize" (func $ns1.getBufferSize (result i32)))

  ;; Pop API function name off the buffer stack and return index or 0 if not found.
  (import "env" "getApiFunctionIndex" (func $ns1.getApiFunctionIndex (result i32)))
  ;; Call API function by index. Use any number of parameters and return values.
  (import "env" "callApiFunction" (func $ns1.callApiFunction (param $ns1.index i32) (param $ns1.a i32) (result i32)))
  (import "env" "callApiFunction" (func $ns1.api_i32i32_i32 (param $ns1.index i32) (param $ns1.a i32) (param $ns1.b i32) (result i32)))

  ;; Pop string from buffer stack and log it to the console.
  (import "env" "log" (func $ns1.log ))
  ;; Log numbers to the console. Use any number of parameters.
  (import "env" "logNumber" (func $ns1.log1Number  (param $ns1.a i32) ))
  (import "env" "logNumber" (func $ns1.log2Numbers (param $ns1.a i32) (param $ns1.b i32) ))
  (import "env" "logNumber" (func $ns1.log2floats  (param $ns1.a f32) (param $ns1.b f32) ))
  (import "env" "logNumber" (func $ns1.log3Numbers (param $ns1.a i32) (param $ns1.b i32) (param $ns1.c i32) ))
  ;; Pop string from buffer stack and print it to text display.
  (import "env" "print" (func $ns1.print ))

  ;; Set the display mode(0=text,1=pixel), resolution and (optionally) display size (for overscan).
  (import "env" "setDisplayMode" (func $ns1.setDisplayMode (param $ns1.mode i32) (param $ns1.width i32) (param $ns1.height i32)))
  ;; Copy memory range to display buffer ($destOffset optional) and commit display buffer.
  (import "env" "displayMemory" (func $ns1.displayMemory (param $ns1.offset i32) (param $ns1.length i32) (param $ns1.destOffset i32)))

  ;; Pop URL from buffer stack and connect to it.
  (import "env" "connectTo" (func $ns1.connectTo ))
  ;; Shut down this connection
  (import "env" "shutdown" (func $ns1.shutdown ))
  ;; Push base URL to buffer stack and return its length in bytes.  
  (import "env" "getBaseUrl" (func $ns1.getBaseUrl (result i32)))
  ;; Pop URL from buffer stack and set it as base URL.
  (import "env" "setBaseUrl" (func $ns1.setBaseUrl ))

  ;; Pop path from buffer stack, read it and push the contents to buffer stack. Returns a request ID.
  ;; Callback can expect success boolean, length in bytes and same request ID as parameters.
  (import "env" "read" (func $ns1.read (param $ns1.tableIndex i32) (result i32)))
  ;; Pop path from buffer stack, read it and push the pixel data to buffer stack. Returns a request ID.
  ;; Callback can expect success boolean, width and height in pixels and same request ID as parameters.
  ;; (import "env" "readImage" (func $readImage (param $tableIndex i32) (result i32)))
  ;; Pop data and path from buffer stack and write it to file. Returns a request ID.
  ;; Callback can expect success boolean and same request ID as parameters.
  (import "env" "write" (func $ns1.write (param $ns1.tableIndex i32) (result i32)))
  ;; Pop path from buffer stack and delete the file. Returns a request ID.
  ;; Callback can expect success boolean and same request ID as parameters.
  (import "env" "delete" (func $ns1.delete (param $ns1.tableIndex i32) (result i32)))
  ;; Pop path from buffer stack and retrieve directory contents. Returns a request ID.
  ;; Callback can expect success boolean, length in bytes and same request ID as parameters.
  (import "env" "list" (func $ns1.list (param $ns1.tableIndex i32) (result i32)))

  (import "env" "head" (func $ns1.head (param $ns1.tableIndex i32) (result i32)))
  (import "env" "post" (func $ns1.post (param $ns1.tableIndex i32) (result i32)))

  ;; Prioritize  given type of input. 1=text, 2=mouse, 3=game.
  (import "env" "focusInput" (func $ns1.focusInput (param $ns1.input i32)))

  ;; Push text input text to buffer stack and return its length in bytes.
  (import "env" "getInputText" (func $ns1.getInputText (result i32)))
  ;; Get character position of carret in text input.
  (import "env" "getInputPosition" (func $ns1.getInputPosition (result i32)))
  ;; Get number of characters selected in text input.
  (import "env" "getInputSelected" (func $ns1.getInputSelected (result i32)))
  ;; Get key code of key that was just pressed this step.
  (import "env" "getInputKey" (func $ns1.getInputKey (result i32)))
  ;; Set the type of text input. 0=multiline, 1=singleline, 2=password, 3=number, 4=url, 5=email, 6=phone
  (import "env" "setInputType" (func $ns1.setInputType (param i32)))
  ;; Pop text from buffer stack and set text of text input.
  (import "env" "setInputText" (func $ns1.setInputText))
  ;; Set position and (optionally) selection of text input.
  (import "env" "setInputPosition" (func $ns1.setInputPosition (param $ns1.position i32) (param $ns1.selected i32)))
  ;; Pop replacement and search substrings from buffer stack and
  ;; replace first occurence in text input.
  (import "env" "replaceInputText" (func $ns1.replaceInputText (param $ns1.fromIndex i32)))

  ;; Get X coordinate of mouse input.
  (import "env" "getMouseX" (func $ns1.getMouseX (result i32)))
  ;; Get Y coordinate of mouse input.
  (import "env" "getMouseY" (func $ns1.getMouseY (result i32)))
  ;; Check if mouse button is pressed.
  (import "env" "getMousePressed" (func $ns1.getMousePressed (result i32)))

  ;; Get X coodinate of game input. (-1 to 1)
  (import "env" "getGameAxisX" (func $ns1.getGameAxisX (result f32)))
  ;; Get Y coodinate of game input. (-1 to 1)
  (import "env" "getGameAxisY" (func $ns1.getGameAxisY (result f32)))
  ;; Check if game button A is pressed.
  (import "env" "getGameButtonA" (func $ns1.getGameButtonA (result i32)))
  ;; Check if game button B is pressed.
  (import "env" "getGameButtonB" (func $ns1.getGameButtonB (result i32)))
  ;; Check if game button X is pressed.
  (import "env" "getGameButtonX" (func $ns1.getGameButtonX (result i32)))
  ;; Check if game button Y is pressed.
  (import "env" "getGameButtonY" (func $ns1.getGameButtonY (result i32)))

  ;; Start generating a tone.
  (import "env" "startTone" (func $ns1.startTone (param $ns1.channel i32) (param $ns1.frequency i32) (param $ns1.volume f32) (param $ns1.type i32)))
  ;; Stop generating a tone.
  (import "env" "stopTone" (func $ns1.stopTone (param $ns1.channel i32)))

  ;; Set step interval. Set to -1 to only step on input.
  (import "env" "setStepInterval" (func $ns1.setStepInterval (param $ns1.milliseconds f64)))
  ;; Pop wasm binary code from buffer stack and load it. Returns new process ID.
  ;; All exports from boot.wasm starting with "api." are forwarded to the process.
  (import "env" "loadProcess" (func $ns1.loadProcess (result i32)))
  ;; Step a process, keeping it alive.
  (import "env" "stepProcess" (func $ns1.stepProcess (param $ns1.pid i32)))
  ;; Call back a process. Any parameters beyond the first two will be forwarded to the callback function.
  (import "env" "callbackProcess" (func $ns1.callbackProcess (param $ns1.pid i32) (param $ns1.tableIndex i32) (param $ns1.param i32)))
  ;; Kill a process.
  (import "env" "killProcess" (func $ns1.killProcess (param $ns1.pid i32)))
  ;; Transfer a chunk of memory from one process to another
  (import "env" "transferMemory" (func $ns1.transferMemory (param $ns1.srcPid i32) (param $ns1.srcOffset i32) (param $ns1.length i32) (param $ns1.destPid i32) (param $ns1.destOffset i32)))

  ;; transpile wa(s)t into wasm on the buffer stack and return byte length.
  ;; (import "env" "wabt" (func $wabt (result i32)))

  ;; All JavaScript Math functions are available.
  (import "Math" "random" (func $ns1.random (result f32)))


  (import "env" "getNativeDisplayWidth" (func $ns1.getNativeDisplayWidth (result i32)))
  (import "env" "getNativeDisplayHeight" (func $ns1.getNativeDisplayHeight (result i32)))

;;"\$"



  ;; Memory management

  (data (i32.const 0) "\00\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00")
  (global $ns3.nextPartId (mut i32) (i32.const 1))
  (global $ns3.parentPart (mut i32) (i32.const 0))

  (func $ns3.getPartIndex (param $ns3.id i32) (result i32)
    (local $ns3.indexOffset i32)
    (local $ns3.indexLength i32)
    (local $ns3.p i32)
    (set_local $ns3.indexOffset (i32.const 0x00))
    (set_local $ns3.indexLength (i32.const 0x10))
    (set_local $ns3.p (get_local $ns3.indexOffset))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $ns3.p) (i32.add (get_local $ns3.indexOffset) (get_local $ns3.indexLength))))
      (if (i32.eq (i32.load (get_local $ns3.p)) (get_local $ns3.id)) (then
        (return (get_local $ns3.p))
      ))
      (if (i32.eq (i32.load (get_local $ns3.p)) (i32.const 0)) (then
        (set_local $ns3.indexOffset (i32.load (i32.add (get_local $ns3.p) (i32.const 0x8))))
        (set_local $ns3.indexLength (i32.load (i32.add (get_local $ns3.p) (i32.const 0xc))))
        (set_local $ns3.p (get_local $ns3.indexOffset))
      )(else
        (set_local $ns3.p (i32.add (get_local $ns3.p) (i32.const 0x10)))
      ))
      (br 0)
    ))
    (i32.const -1)
  )
  (func $ns3.getPartParent (param $ns3.id i32) (result i32)
    (local $ns3.i i32)
    (set_local $ns3.i (call $ns3.getPartIndex (get_local $ns3.id)))
    (if (i32.ne (get_local $ns3.i) (i32.const -1)) (then
      (set_local $ns3.i (i32.load (i32.add (get_local $ns3.i) (i32.const 0x4))))
    ))
    (get_local $ns3.i)
  )
  (func $ns3.getPartOffset (param $ns3.id i32) (result i32)
    (local $ns3.i i32)
    (set_local $ns3.i (call $ns3.getPartIndex (get_local $ns3.id)))
    (if (i32.ne (get_local $ns3.i) (i32.const -1)) (then
      (set_local $ns3.i (i32.load (i32.add (get_local $ns3.i) (i32.const 0x8))))
    ))
    (get_local $ns3.i)
  )
  (func $ns3.getPartLength (param $ns3.id i32) (result i32)
    (local $ns3.i i32)
    (set_local $ns3.i (call $ns3.getPartIndex (get_local $ns3.id)))
    (if (i32.ne (get_local $ns3.i) (i32.const -1)) (then
      (set_local $ns3.i (i32.load (i32.add (get_local $ns3.i) (i32.const 0xc))))
    ))
    (get_local $ns3.i)
  )

  (func $ns3.getNextPart (param $ns3.fromOffset i32) (result i32)
    (local $ns3.indexOffset i32)
    (local $ns3.indexLength i32)
    (local $ns3.id i32)
    (local $ns3.offset i32)
    (local $ns3.bestId i32)
    (local $ns3.bestIdOffset i32)
    (local $ns3.p i32)
    (set_local $ns3.indexOffset (i32.const 0x00))
    (set_local $ns3.indexLength (i32.const 0x10))
    (set_local $ns3.bestId (i32.const -1))
    (set_local $ns3.bestIdOffset (i32.const -1))
    (set_local $ns3.p (get_local $ns3.indexOffset))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $ns3.p) (i32.add (get_local $ns3.indexOffset) (get_local $ns3.indexLength))))
      (set_local $ns3.id (i32.load (get_local $ns3.p)))
      (set_local $ns3.offset (i32.load (i32.add (get_local $ns3.p) (i32.const 0x8))))
      (if (i32.and (i32.ge_u (get_local $ns3.offset) (get_local $ns3.fromOffset)) (i32.lt_u (get_local $ns3.offset) (get_local $ns3.bestIdOffset))) (then
        (set_local $ns3.bestId (get_local $ns3.id))
        (set_local $ns3.bestIdOffset (get_local $ns3.offset))
      ))
      (if (i32.eq (i32.load (get_local $ns3.p)) (i32.const 0)) (then
        (set_local $ns3.indexOffset (i32.load (i32.add (get_local $ns3.p) (i32.const 0x8))))
        (set_local $ns3.indexLength (i32.load (i32.add (get_local $ns3.p) (i32.const 0xc))))
        (set_local $ns3.p (get_local $ns3.indexOffset))
      )(else
        (set_local $ns3.p (i32.add (get_local $ns3.p) (i32.const 0x10)))
      ))
      (br 0)
    ))
    (get_local $ns3.bestId)
  )

  (func $ns3.alloc (param $ns3.len i32) (result i32)
    (local $ns3.offset i32)
    (local $ns3.nextId i32)
    (local $ns3.nextOffset i32)
    (set_local $ns3.offset (i32.const 0x10))
    (block(loop
      (set_local $ns3.nextId (call $ns3.getNextPart (get_local $ns3.offset)))
      (if (i32.eq (get_local $ns3.nextId) (i32.const -1))(then
        (set_local $ns3.nextOffset (i32.mul (current_memory) (i32.const 65536)))
      )(else
        (set_local $ns3.nextOffset (call $ns3.getPartOffset (get_local $ns3.nextId)))
      ))
      (br_if 1 (i32.gt_u (i32.sub (get_local $ns3.nextOffset) (get_local $ns3.offset)) (get_local $ns3.len)))
      (br_if 1 (i32.eq (get_local $ns3.nextId) (i32.const -1)))
      (set_local $ns3.offset (i32.add (get_local $ns3.nextOffset) (i32.add (call $ns3.getPartLength (get_local $ns3.nextId)) (i32.const 1))))
      (br 0)
    ))
    (if (i32.le_u (i32.sub (get_local $ns3.nextOffset) (get_local $ns3.offset)) (get_local $ns3.len)) (then
      (if (i32.lt_s (grow_memory (i32.add (i32.div_u (get_local $ns3.len) (i32.const 65536)) (i32.const 1))) (i32.const 0)) (then
        (unreachable)
      ))
      (set_local $ns3.offset (call $ns3.alloc (get_local $ns3.len)))
    ))
    (get_local $ns3.offset)
  )
  (func $ns3.resizePart (param $ns3.id i32) (param $ns3.newlen i32)
    (local $ns3.offset i32)
    (local $ns3.len i32)
    (set_local $ns3.offset (call $ns3.getPartOffset (get_local $ns3.id)))
    (set_local $ns3.len (call $ns3.getPartLength (get_local $ns3.id)))
    (if (i32.le_u (get_local $ns3.newlen) (get_local $ns3.len)) (then
      (i32.store (i32.add (call $ns3.getPartIndex (get_local $ns3.id)) (i32.const 0xc)) (get_local $ns3.newlen))
    )(else
      (i32.store (i32.add (call $ns3.getPartIndex (get_local $ns3.id)) (i32.const 0x8)) (call $ns3.alloc (get_local $ns3.newlen)))
      (i32.store (i32.add (call $ns3.getPartIndex (get_local $ns3.id)) (i32.const 0xc)) (get_local $ns3.newlen))
      (call $ns3.copyMem (get_local $ns3.offset) (call $ns3.getPartOffset (get_local $ns3.id)) (get_local $ns3.len))
    ))
  )
  (func $ns3.copyMem (param $ns3.fromOffset i32) (param $ns3.toOffset i32) (param $ns3.len i32)
    (local $ns3.delta i32)
    (if (i32.eqz (get_local $ns3.len)) (return))
    (if (i32.gt_u (get_local $ns3.fromOffset) (get_local $ns3.toOffset)) (then
      (set_local $ns3.delta (i32.const 1))
    )(else
      (set_local $ns3.delta (i32.const -1))
      (set_local $ns3.len (i32.sub (get_local $ns3.len) (i32.const 1)))
      (set_local $ns3.fromOffset (i32.add (get_local $ns3.fromOffset) (get_local $ns3.len)))
      (set_local $ns3.toOffset   (i32.add (get_local $ns3.toOffset  ) (get_local $ns3.len)))
      (set_local $ns3.len (i32.add (get_local $ns3.len) (i32.const 1)))
    ))
    (block (loop
      (br_if 1 (i32.eqz (get_local $ns3.len)))
      (i32.store8 (get_local $ns3.toOffset) (i32.load8_u (get_local $ns3.fromOffset)))
      (set_local $ns3.fromOffset (i32.add (get_local $ns3.fromOffset) (get_local $ns3.delta)))
      (set_local $ns3.toOffset   (i32.add (get_local $ns3.toOffset  ) (get_local $ns3.delta)))
      (set_local $ns3.len        (i32.sub (get_local $ns3.len)        (i32.const 1)))
      (br 0)
    ))
  )
  (func $ns3.createPart (param $ns3.len i32) (result i32)
    (local $ns3.offset i32)
    (call $ns3.resizePart (i32.const 0) (i32.add (call $ns3.getPartLength (i32.const 0)) (i32.const 0x10)))
    (set_local $ns3.offset (i32.sub (i32.add (call $ns3.getPartOffset (i32.const 0)) (call $ns3.getPartLength (i32.const 0))) (i32.const 0x10)))
    (i32.store (i32.add (get_local $ns3.offset) (i32.const 0x0)) (get_global $ns3.nextPartId))
    (i32.store (i32.add (get_local $ns3.offset) (i32.const 0x4)) (get_global $ns3.parentPart))
    (i32.store (i32.add (get_local $ns3.offset) (i32.const 0x8)) (call $ns3.alloc (get_local $ns3.len)))
    (i32.store (i32.add (get_local $ns3.offset) (i32.const 0xc)) (get_local $ns3.len))
    (get_global $ns3.nextPartId)
    (set_global $ns3.nextPartId (i32.add (get_global $ns3.nextPartId) (i32.const 1)))
  )

  (func $ns3.deletePart (param $ns3.id i32)
    (local $ns3.indexOffset i32)
    (local $ns3.indexLength i32)
    (local $ns3.p i32)
    (set_local $ns3.indexOffset (call $ns3.getPartOffset (i32.const 0)))
    (set_local $ns3.indexLength (call $ns3.getPartLength (i32.const 0)))
    (set_local $ns3.p (get_local $ns3.indexOffset))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $ns3.p) (i32.add (get_local $ns3.indexOffset) (get_local $ns3.indexLength))))
      (if (i32.eq (i32.load (get_local $ns3.p)) (get_local $ns3.id)) (then
        (call $ns3.copyMem (i32.sub (i32.add (get_local $ns3.indexOffset) (get_local $ns3.indexLength)) (i32.const 0x10)) (get_local $ns3.p) (i32.const 0x10))
        (set_local $ns3.indexLength (i32.sub (get_local $ns3.indexLength) (i32.const 0x10)))
        (call $ns3.resizePart (i32.const 0) (get_local $ns3.indexLength))
        (set_local $ns3.p (i32.sub (get_local $ns3.p) (i32.const 0x10)))
      ))
      (if (i32.eq (i32.load (i32.add (get_local $ns3.p) (i32.const 0x4))) (get_local $ns3.id)) (then
        (call $ns3.deletePart (i32.load (get_local $ns3.p)))
        (set_local $ns3.indexOffset (call $ns3.getPartOffset (i32.const 0)))
        (set_local $ns3.indexLength (call $ns3.getPartLength (i32.const 0)))
        (set_local $ns3.p (i32.sub (get_local $ns3.indexOffset) (i32.const 0x10)))
      ))
      (set_local $ns3.p (i32.add (get_local $ns3.p) (i32.const 0x10)))
      (br 0)
    ))
    (if (i32.eq (get_global $ns3.parentPart) (get_local $ns3.id))(then
      (call $ns3.exitPart)
    ))
  )
  (func $ns3.movePartUp (param $ns3.id i32)
    (local $ns3.p i32)
    (set_local $ns3.p (call $ns3.getPartIndex (get_local $ns3.id)))
    (i32.store (i32.add (get_local $ns3.p) (i32.const 0x4)) (call $ns3.getPartParent (call $ns3.getPartParent (get_local $ns3.id))))
  )
  (func $ns3.enterPart (param $ns3.id i32)
    (set_global $ns3.parentPart (get_local $ns3.id))
  )
  (func $ns3.exitPart
    (set_global $ns3.parentPart (call $ns3.getPartParent (get_global $ns3.parentPart)))
  )
  (func $ns3.deleteParent
    (call $ns3.deletePart (get_global $ns3.parentPart))
  )

;;"\$"


  ;; String manipulation
  
  (func $ns2.printStr (param $ns2.str i32)
    (call $ns1.print (call $ns1.pushFromMemory (call $ns3.getPartOffset (get_local $ns2.str)) (call $ns3.getPartLength (get_local $ns2.str))))
  )
  
  (func $ns2.createString (param $ns2.srcOffset i32) (result i32)
    (local $ns2.str i32)
    (local $ns2.len i32)
    (set_local $ns2.len (i32.const 0))
    (block(loop
      (br_if 1 (i32.eq (i32.load8_u (i32.add (get_local $ns2.srcOffset) (get_local $ns2.len))) (i32.const 0)))
      (set_local $ns2.len (i32.add (get_local $ns2.len) (i32.const 1)))
      (br 0)
    ))
    (set_local $ns2.str (call $ns3.createPart (get_local $ns2.len)))
    (call $ns3.copyMem (get_local $ns2.srcOffset) (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.len))
    (get_local $ns2.str)
  )

  (func $ns2.byteAt (param $ns2.str i32) (param $ns2.pos i32) (result i32)
    (i32.load8_u (i32.add (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.pos)))
  )
  
  (func $ns2.substr (param $ns2.str i32) (param $ns2.pos i32) (param $ns2.len i32) (result i32)
    (local $ns2.strc i32)
    (if (i32.gt_u (get_local $ns2.pos) (call $ns3.getPartLength (get_local $ns2.str))) (then
      (set_local $ns2.pos (call $ns3.getPartLength (get_local $ns2.str)))
    ))
    (if (i32.gt_u (get_local $ns2.len) (i32.sub (call $ns3.getPartLength (get_local $ns2.str)) (get_local $ns2.pos))) (then
      (set_local $ns2.len (i32.sub (call $ns3.getPartLength (get_local $ns2.str)) (get_local $ns2.pos)) )
    ))
    (set_local $ns2.strc (call $ns3.createPart (get_local $ns2.len)))
    (call $ns3.copyMem (i32.add (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.pos)) (call $ns3.getPartOffset (get_local $ns2.strc)) (get_local $ns2.len))
    (get_local $ns2.strc)
  )
  
  (func $ns2.concat (param $ns2.stra i32) (param $ns2.strb i32) (result i32)
    (local $ns2.strc i32)
    (set_local $ns2.strc (call $ns3.createPart (i32.add (call $ns3.getPartLength (get_local $ns2.stra)) (call $ns3.getPartLength (get_local $ns2.strb)))))
    (call $ns3.copyMem (call $ns3.getPartOffset (get_local $ns2.stra)) (call $ns3.getPartOffset (get_local $ns2.strc)) (call $ns3.getPartLength (get_local $ns2.stra)))
    (call $ns3.copyMem (call $ns3.getPartOffset (get_local $ns2.strb)) (i32.add (call $ns3.getPartOffset (get_local $ns2.strc)) (call $ns3.getPartLength (get_local $ns2.stra))) (call $ns3.getPartLength (get_local $ns2.strb)))
    (get_local $ns2.strc)
  )
  
  (func $ns2.appendBytes (param $ns2.str i32) (param $ns2.bytes i64)
    (local $ns2.l i32)
    (set_local $ns2.l (call $ns3.getPartLength (get_local $ns2.str)))
    (call $ns3.resizePart (get_local $ns2.str) (i32.add (get_local $ns2.l) (i32.const 9)))
    (set_local $ns2.l (i32.add (get_local $ns2.l) (i32.const 1)))
    (i64.store (i32.add (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.l)) (i64.const 0))
    (set_local $ns2.l (i32.sub (get_local $ns2.l) (i32.const 1)))
    (i64.store (i32.add (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.l)) (get_local $ns2.bytes))
    (set_local $ns2.l (i32.add (get_local $ns2.l) (i32.const 1)))
    (block(loop
      (br_if 1 (i32.eq (call $ns2.byteAt (get_local $ns2.str) (get_local $ns2.l)) (i32.const 0)))
      (set_local $ns2.l (i32.add (get_local $ns2.l) (i32.const 1)))
      (br 0)
    ))
    (call $ns3.resizePart (get_local $ns2.str) (get_local $ns2.l))
  )
  
  (func $ns2.usascii (param $ns2.str i32)
    (local $ns2.i i32)
    (local $ns2.l i32)
    (set_local $ns2.i (call $ns3.getPartOffset (get_local $ns2.str)))
    (set_local $ns2.l (call $ns3.getPartLength (get_local $ns2.str)))
    (block (loop
      (br_if 1 (i32.eq (get_local $ns2.l) (i32.const 0)))
      (if (i32.gt_u (i32.load8_u (get_local $ns2.i)) (i32.const 127)) (then
        (i32.store8 (get_local $ns2.i) (i32.const 63))
      ))
      (set_local $ns2.i (i32.add (get_local $ns2.i) (i32.const 1)))
      (set_local $ns2.l (i32.sub (get_local $ns2.l) (i32.const 1)))
      (br 0)
    ))
  )
  
  (func $ns2.getLine (param $ns2.str i32) (param $ns2.linenum i32) (result i32)
    (local $ns2.line i32)
    (local $ns2.col i32)
    (local $ns2.p i32)
    (local $ns2.strc i32)
    (block(loop
      (br_if 1 (get_local $ns2.strc))
      (set_local $ns2.col (i32.add (get_local $ns2.col) (i32.const 1)))
      (if (i32.eq (call $ns2.byteAt (get_local $ns2.str) (get_local $ns2.p)) (i32.const 10)) (then
        (if (i32.eq (get_local $ns2.line) (get_local $ns2.linenum)) (then
          (set_local $ns2.p (i32.sub (get_local $ns2.p) (get_local $ns2.col)))
          (set_local $ns2.strc (call $ns2.substr (get_local $ns2.str) (get_local $ns2.p) (get_local $ns2.col)))
          (set_local $ns2.p (i32.add (get_local $ns2.p) (get_local $ns2.col)))
        ))
        (set_local $ns2.line (i32.add (get_local $ns2.line) (i32.const 1)))
        (set_local $ns2.col (i32.const 0))
      ))
      (set_local $ns2.p (i32.add (get_local $ns2.p) (i32.const 1)))
      (br 0)
    ))
    (get_local $ns2.strc)
  )

  (func $ns2.countLines (param $ns2.str i32) (result i32)
    (local $ns2.line i32)
    (local $ns2.p i32)
    (local $ns2.l i32)
    (set_local $ns2.line (i32.const 1))
    (set_local $ns2.l (call $ns3.getPartLength (get_local $ns2.str)))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $ns2.p) (get_local $ns2.l)))
      (if (i32.eq (call $ns2.byteAt (get_local $ns2.str) (get_local $ns2.p)) (i32.const 10)) (then
        (set_local $ns2.line (i32.add (get_local $ns2.line) (i32.const 1)))
      ))
      (set_local $ns2.p (i32.add (get_local $ns2.p) (i32.const 1)))
      (br 0)
    ))
    (get_local $ns2.line)
  )

  (func $ns2.lineAt (param $ns2.str i32) (param $ns2.pos i32) (result i32)
    (local $ns2.line i32)
    (local $ns2.p i32)
    (block(loop
      (br_if 1 (i32.eq (get_local $ns2.p) (get_local $ns2.pos)))
      (if (i32.eq (call $ns2.byteAt (get_local $ns2.str) (get_local $ns2.p)) (i32.const 10)) (then
        (set_local $ns2.line (i32.add (get_local $ns2.line) (i32.const 1)))
      ))
      (set_local $ns2.p (i32.add (get_local $ns2.p) (i32.const 1)))
      (br 0)
    ))
    (get_local $ns2.line)
  )

  (func $ns2.columnAt (param $ns2.str i32) (param $ns2.pos i32) (result i32)
    (local $ns2.col i32)
    (local $ns2.p i32)
    (block(loop
      (br_if 1 (i32.eq (get_local $ns2.p) (get_local $ns2.pos)))
      (set_local $ns2.col (i32.add (get_local $ns2.col) (i32.const 1)))
      (if (i32.eq (call $ns2.byteAt (get_local $ns2.str) (get_local $ns2.p)) (i32.const 10)) (then
        (set_local $ns2.col (i32.const 0))
      ))
      (set_local $ns2.p   (i32.add (get_local $ns2.p)   (i32.const 1)))
      (br 0)
    ))
    (get_local $ns2.col)
  )
  
  (func $ns2.uintToStr (param $ns2.int i32) (result i32)
    (local $ns2.order i32)
    (local $ns2.digit i32)
    (local $ns2.str i32)
    (set_local $ns2.order (i32.const 1000000000))
    (set_local $ns2.str (call $ns3.createPart (i32.const 0)))
    (block(loop
      (br_if 1 (i32.eq (get_local $ns2.order) (i32.const 0)))
      (set_local $ns2.digit (i32.div_u (get_local $ns2.int) (get_local $ns2.order)))
      (if (i32.or (get_local $ns2.digit) (call $ns3.getPartLength (get_local $ns2.str))) (then
        (call $ns2.appendBytes (get_local $ns2.str) (i64.extend_u/i32 (i32.add (i32.const 0x30) (get_local $ns2.digit))))
      ))
      (set_local $ns2.int (i32.rem_u (get_local $ns2.int) (get_local $ns2.order)))
      (set_local $ns2.order (i32.div_u (get_local $ns2.order) (i32.const 10)))
      (br 0)
    ))
    (get_local $ns2.str)
  )
  
  (func $ns2.compare (param $ns2.stra i32) (param $ns2.strb i32) (result i32)
    (local $ns2.p i32)
    (local $ns2.l i32)
    (if (i32.ne (call $ns3.getPartLength (get_local $ns2.stra)) (call $ns3.getPartLength (get_local $ns2.strb))) (then
      (return (i32.const 0))
    ))
    (set_local $ns2.l (call $ns3.getPartLength (get_local $ns2.stra)))
    (block(loop
      (br_if 1 (i32.eq (get_local $ns2.p) (get_local $ns2.l)))
      (if (i32.ne (call $ns2.byteAt (get_local $ns2.stra) (get_local $ns2.p)) (call $ns2.byteAt (get_local $ns2.strb) (get_local $ns2.p))) (then
        (return (i32.const 0))
      ))
      (set_local $ns2.p (i32.add (get_local $ns2.p) (i32.const 1)))
      (br 0)
    ))
    (i32.const 1)
  )
  
  (func $ns2.indexOf (param $ns2.haystack i32) (param $ns2.needle i32) (param $ns2.pos i32) (result i32)
    (local $ns2.sub i32)
    (if (i32.lt_u (call $ns3.getPartLength (get_local $ns2.haystack)) (call $ns3.getPartLength (get_local $ns2.needle))) (then
      (return (i32.const -1))
    ))
    (set_local $ns2.sub (call $ns3.createPart (call $ns3.getPartLength (get_local $ns2.needle))))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $ns2.pos) (i32.sub (call $ns3.getPartLength (get_local $ns2.haystack)) (call $ns3.getPartLength (get_local $ns2.needle)))))
      (call $ns3.copyMem (i32.add (call $ns3.getPartOffset (get_local $ns2.haystack)) (get_local $ns2.pos)) (call $ns3.getPartOffset (get_local $ns2.sub)) (call $ns3.getPartLength (get_local $ns2.sub)))
      (if (call $ns2.compare (get_local $ns2.sub) (get_local $ns2.needle)) (then
        (return (get_local $ns2.pos))
      ))
      (set_local $ns2.pos (i32.add (get_local $ns2.pos) (i32.const 1)))
      (br 0)
    ))
    (i32.const -1)
  )

  (func $ns2.lastIndexOf (param $ns2.haystack i32) (param $ns2.needle i32) (param $ns2.pos i32) (result i32)
    (local $ns2.sub i32)
    (if (i32.lt_u (call $ns3.getPartLength (get_local $ns2.haystack)) (call $ns3.getPartLength (get_local $ns2.needle))) (then
      (return (i32.const -1))
    ))
    (set_local $ns2.sub (call $ns3.createPart (call $ns3.getPartLength (get_local $ns2.needle))))
    (block(loop
      (br_if 1 (i32.eq (get_local $ns2.pos) (i32.const 0)))
      (call $ns3.copyMem (i32.add (call $ns3.getPartOffset (get_local $ns2.haystack)) (get_local $ns2.pos)) (call $ns3.getPartOffset (get_local $ns2.sub)) (call $ns3.getPartLength (get_local $ns2.sub)))
      (if (call $ns2.compare (get_local $ns2.sub) (get_local $ns2.needle)) (then
        (return (get_local $ns2.pos))
      ))
      (set_local $ns2.pos (i32.sub (get_local $ns2.pos) (i32.const 1)))
      (br 0)
    ))
    (i32.const -1)
  )
  
  (func $ns2.trim (param $ns2.str i32)
    (local $ns2.p i32)
    (local $ns2.l i32)
    (set_local $ns2.p (call $ns3.getPartOffset (get_local $ns2.str)))
    (set_local $ns2.l (call $ns3.getPartLength (get_local $ns2.str)))
    (block(loop
      (br_if 1 (i32.or (i32.eqz (get_local $ns2.l)) (i32.gt_u (i32.load8_u (get_local $ns2.p)) (i32.const 32))))
      (set_local $ns2.p (i32.add (get_local $ns2.p) (i32.const 1)))
      (set_local $ns2.l (i32.sub (get_local $ns2.l) (i32.const 1)))
      (br 0)
    ))
    (call $ns3.copyMem (get_local $ns2.p) (call $ns3.getPartOffset (get_local $ns2.str)) (get_local $ns2.l))
    (block(loop
      (br_if 1 (i32.or (i32.eqz (get_local $ns2.l)) (i32.gt_u (call $ns2.byteAt (get_local $ns2.str) (i32.sub (get_local $ns2.l) (i32.const 1))) (i32.const 32))))
      (set_local $ns2.l (i32.sub (get_local $ns2.l) (i32.const 1)))
      (br 0)
    ))
    (call $ns3.resizePart (get_local $ns2.str) (get_local $ns2.l))
  )


;;"\$"

;;"\$"

;;"\$"



  ;; Graphic routines

  (global $ns4.display (mut i32) (i32.const -1))
  (global $ns4.font    (mut i32) (i32.const -1))

  (func $ns4.rgb (param $ns4.r i32) (param $ns4.g i32) (param $ns4.b i32) (result i32)
    (local $ns4.c i32)
    (set_local $ns4.c (i32.const 255))
    (set_local $ns4.c (i32.mul (get_local $ns4.c) (i32.const 256)))
    (set_local $ns4.c (i32.add (get_local $ns4.c) (get_local $ns4.b)))
    (set_local $ns4.c (i32.mul (get_local $ns4.c) (i32.const 256)))
    (set_local $ns4.c (i32.add (get_local $ns4.c) (get_local $ns4.g)))
    (set_local $ns4.c (i32.mul (get_local $ns4.c) (i32.const 256)))
    (set_local $ns4.c (i32.add (get_local $ns4.c) (get_local $ns4.r)))
    (get_local $ns4.c)
  )

  (func $ns4.createImg (param $ns4.w i32) (param $ns4.h i32) (result i32)
    (local $ns4.img i32)
    (local $ns4.imgOffset i32)
    (set_local $ns4.img (call $ns3.createPart (i32.add (i32.const 8) (i32.mul (i32.mul (get_local $ns4.w) (get_local $ns4.h)) (i32.const 4)))))
    (set_local $ns4.imgOffset (call $ns3.getPartOffset (get_local $ns4.img)))
    (i32.store (i32.add (get_local $ns4.imgOffset) (i32.const 0)) (get_local $ns4.w))
    (i32.store (i32.add (get_local $ns4.imgOffset) (i32.const 4)) (get_local $ns4.h))
    (get_local $ns4.img)
  )
  (func $ns4.getImgWidth (param $ns4.img i32) (result i32)
    (i32.load (call $ns3.getPartOffset (get_local $ns4.img)))
  )
  (func $ns4.getImgHeight (param $ns4.img i32) (result i32)
    (i32.load (i32.add (call $ns3.getPartOffset (get_local $ns4.img)) (i32.const 4)))
  )

  (func $ns4.pget (param $ns4.img i32) (param $ns4.x i32) (param $ns4.y i32) (result i32)
    (local $ns4.imgOffset i32)
    (local $ns4.imgWidth i32)
    (local $ns4.imgHeight i32)
    (local $ns4.i i32)
    (set_local $ns4.imgOffset (call $ns3.getPartOffset (get_local $ns4.img)))
    (set_local $ns4.imgWidth (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))
    (set_local $ns4.imgHeight (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))

    (set_local $ns4.i (i32.mul (i32.const 4) (i32.add (get_local $ns4.x) (i32.mul (get_local $ns4.y) (get_local $ns4.imgWidth)))))
    (i32.load (i32.add (get_local $ns4.imgOffset) (get_local $ns4.i)))
  )
  (func $ns4.pset (param $ns4.img i32) (param $ns4.x i32) (param $ns4.y i32) (param $ns4.c i32)
    (local $ns4.imgOffset i32)
    (local $ns4.imgWidth i32)
    (local $ns4.imgHeight i32)
    (local $ns4.i i32)
    (set_local $ns4.imgOffset (call $ns3.getPartOffset (get_local $ns4.img)))
    (set_local $ns4.imgWidth (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))
    (set_local $ns4.imgHeight (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))

    (br_if 0 (i32.ge_u (get_local $ns4.x) (get_local $ns4.imgWidth)))
    (br_if 0 (i32.ge_u (get_local $ns4.y) (get_local $ns4.imgHeight)))
    (set_local $ns4.i (i32.mul (i32.const 4) (i32.add (get_local $ns4.x) (i32.mul (get_local $ns4.y) (get_local $ns4.imgWidth)))))
    (i32.store (i32.add (get_local $ns4.imgOffset) (get_local $ns4.i)) (get_local $ns4.c))
  )

  (func $ns4.rect (param $ns4.img i32) (param $ns4.x i32) (param $ns4.y i32) (param $ns4.w i32) (param $ns4.h i32) (param $ns4.c i32)
    (local $ns4.i i32)
    (local $ns4.j i32)
    (local $ns4.imgOffset i32)
    (local $ns4.imgWidth i32)
    (local $ns4.imgHeight i32)
    (set_local $ns4.imgOffset (call $ns3.getPartOffset (get_local $ns4.img)))
    (set_local $ns4.imgWidth (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))
    (set_local $ns4.imgHeight (i32.load (get_local $ns4.imgOffset)))
    (set_local $ns4.imgOffset (i32.add (get_local $ns4.imgOffset) (i32.const 4)))
    
    (br_if 0 (i32.ge_s (get_local $ns4.x) (get_local $ns4.imgWidth)))
    (br_if 0 (i32.ge_s (get_local $ns4.y) (get_local $ns4.imgHeight)))
    (br_if 0 (i32.lt_s (i32.add (get_local $ns4.x) (get_local $ns4.w)) (i32.const 0)))
    (br_if 0 (i32.lt_s (i32.add (get_local $ns4.y) (get_local $ns4.h)) (i32.const 0)))
    (if (i32.lt_s (get_local $ns4.x) (i32.const 0)) (then
      (set_local $ns4.w (i32.add (get_local $ns4.w) (get_local $ns4.x)))
      (set_local $ns4.x (i32.const 0))
    ))
    (if (i32.lt_s (get_local $ns4.y) (i32.const 0)) (then
      (set_local $ns4.h (i32.add (get_local $ns4.h) (get_local $ns4.y)))
      (set_local $ns4.y (i32.const 0))
    ))
    (if (i32.gt_s (i32.add (get_local $ns4.x) (get_local $ns4.w)) (get_local $ns4.imgWidth)) (then
      (set_local $ns4.w (i32.sub (get_local $ns4.imgWidth) (get_local $ns4.x)))))
    (if (i32.gt_s (i32.add (get_local $ns4.y) (get_local $ns4.h)) (get_local $ns4.imgHeight)) (then
      (set_local $ns4.h (i32.sub (get_local $ns4.imgHeight) (get_local $ns4.y)))))
    (set_local $ns4.i (i32.mul (i32.const 4) (i32.add (get_local $ns4.x) (i32.mul (get_local $ns4.y) (get_local $ns4.imgWidth)))))
    (block (loop
      (br_if 1 (i32.eq (get_local $ns4.h) (i32.const 0)))
      (set_local $ns4.j (get_local $ns4.w))
      (block (loop
        (br_if 1 (i32.eq (get_local $ns4.j) (i32.const 0)))
        (i32.store (i32.add (get_local $ns4.imgOffset) (get_local $ns4.i)) (get_local $ns4.c))
        (set_local $ns4.i (i32.add (get_local $ns4.i) (i32.const 4)))
        (set_local $ns4.j (i32.sub (get_local $ns4.j) (i32.const 1)))
        (br 0)
      ))
      (set_local $ns4.i (i32.sub (i32.add (get_local $ns4.i) (i32.mul (i32.const 4) (get_local $ns4.imgWidth))) (i32.mul (i32.const 4) (get_local $ns4.w))))
      (set_local $ns4.h (i32.sub (get_local $ns4.h) (i32.const 1)))
      (br 0)
    ))
  )

  (func $ns4.copyImg (param $ns4.simg i32) (param $ns4.sx i32) (param $ns4.sy i32) (param $ns4.dimg i32) (param $ns4.dx i32) (param $ns4.dy i32) (param $ns4.w i32) (param $ns4.h i32)
    (local $ns4.x i32)
    (local $ns4.y i32)
    (local $ns4.c i32)
    (block (set_local $ns4.y (i32.const 0)) (loop
      (br_if 1 (i32.ge_u (get_local $ns4.y) (get_local $ns4.h)))
      (block (set_local $ns4.x (i32.const 0)) (loop
        (br_if 1 (i32.ge_u (get_local $ns4.x) (get_local $ns4.w)))
        (set_local $ns4.c (call $ns4.pget (get_local $ns4.simg)
          (i32.add (get_local $ns4.sx) (get_local $ns4.x))
          (i32.add (get_local $ns4.sy) (get_local $ns4.y))
        ))
        (if (i32.gt_u (get_local $ns4.c) (i32.const 0x77777777)) (then
          (call $ns4.pset (get_local $ns4.dimg)
            (i32.add (get_local $ns4.dx) (get_local $ns4.x))
            (i32.add (get_local $ns4.dy) (get_local $ns4.y))
            (get_local $ns4.c)
          )
        ))
        (set_local $ns4.x (i32.add (get_local $ns4.x) (i32.const 1)))
        (br 0)
      ))
      (set_local $ns4.y (i32.add (get_local $ns4.y) (i32.const 1)))
      (br 0)
    ))
  )

  (global $ns4.txtX (mut i32) (i32.const 0))
  (global $ns4.txtY (mut i32) (i32.const 0))

  (func $ns4.printChar (param $ns4.img i32) (param $ns4.char i32)
    (call $ns4.copyImg (get_global $ns4.font) (i32.const 0) (i32.mul (get_local $ns4.char) (i32.const 8)) (get_local $ns4.img) (get_global $ns4.txtX) (get_global $ns4.txtY) (i32.const 8) (i32.const 8))
    (set_global $ns4.txtX (i32.add (get_global $ns4.txtX) (i32.const 8)))
    (if (i32.eq (get_local $ns4.char) (i32.const 9)) (then
      (set_global $ns4.txtX (i32.sub (get_global $ns4.txtX) (i32.const 8)))
      (set_global $ns4.txtX (i32.div_u (get_global $ns4.txtX) (i32.const 32)))
      (set_global $ns4.txtX (i32.mul (get_global $ns4.txtX) (i32.const 32)))
      (set_global $ns4.txtX (i32.add (get_global $ns4.txtX) (i32.const 32)))
    ))
    (if (i32.eq (get_local $ns4.char) (i32.const 10)) (then
      (set_global $ns4.txtX (i32.const 0))
      (set_global $ns4.txtY (i32.add (get_global $ns4.txtY) (i32.const 8)))
    ))
    (if (i32.ge_u (get_global $ns4.txtX) (call $ns4.getImgWidth (get_local $ns4.img))) (then
      (set_global $ns4.txtX (i32.const 0))
      (set_global $ns4.txtY (i32.add (get_global $ns4.txtY) (i32.const 8)))
    ))
    (if (i32.ge_u (get_global $ns4.txtY) (call $ns4.getImgHeight (get_local $ns4.img))) (then
      (call $ns4.copyImg (get_local $ns4.img) (i32.const 0) (i32.const 8) (get_local $ns4.img) (i32.const 0) (i32.const 0) (call $ns4.getImgWidth (get_local $ns4.img)) (i32.sub (call $ns4.getImgHeight (get_local $ns4.img)) (i32.const 8)))
      (call $ns4.rect (get_local $ns4.img) (i32.const 0) (i32.sub (call $ns4.getImgHeight (get_local $ns4.img)) (i32.const 8)) (call $ns4.getImgWidth (get_local $ns4.img)) (i32.const 8) (call $ns4.pget (get_local $ns4.img) (i32.sub (call $ns4.getImgWidth (get_local $ns4.img)) (i32.const 1)) (i32.sub (call $ns4.getImgHeight (get_local $ns4.img)) (i32.const 1))))
      (set_global $ns4.txtY (i32.sub (get_global $ns4.txtY) (i32.const 8)))
    ))
  )

  (func $ns4.printStr (param $ns4.img i32) (param $ns4.str i32)
    (local $ns4.i i32)
    (local $ns4.len i32)
    (set_local $ns4.i (call $ns3.getPartOffset (get_local $ns4.str)))
    (set_local $ns4.len (call $ns3.getPartLength (get_local $ns4.str)))
    (if (i32.gt_u (get_local $ns4.len) (i32.const 0)) (then
      (loop
        (call $ns4.printChar (get_local $ns4.img) (i32.load8_u (get_local $ns4.i)))
        (set_local $ns4.i (i32.add (get_local $ns4.i) (i32.const 1)))
        (set_local $ns4.len (i32.sub (get_local $ns4.len) (i32.const 1)))
        (br_if 0 (i32.gt_u (get_local $ns4.len) (i32.const 0)))
      )
    ))
  )

  (func $ns4.printInput (param $ns4.img i32) (param $ns4.str i32) (param $ns4.pos i32) (param $ns4.sel i32) (param $ns4.c i32)
    (local $ns4.i i32)
    (local $ns4.len i32)
    (set_local $ns4.i (call $ns3.getPartOffset (get_local $ns4.str)))
    (set_local $ns4.len (call $ns3.getPartLength (get_local $ns4.str)))
    (if (i32.gt_u (get_local $ns4.len) (i32.const 0)) (then
      (loop
        (if (i32.eq (get_local $ns4.pos) (i32.const 0)) (then
          (if (i32.gt_u (get_local $ns4.sel) (i32.const 0)) (then
            (call $ns4.rect (get_local $ns4.img) (get_global $ns4.txtX) (get_global $ns4.txtY) (i32.const 8) (i32.const 8) (get_local $ns4.c))
            (set_local $ns4.sel (i32.sub (get_local $ns4.sel) (i32.const 1)))
          )(else
            (call $ns4.rect (get_local $ns4.img) (get_global $ns4.txtX) (get_global $ns4.txtY) (i32.const 1) (i32.const 8) (get_local $ns4.c))
            (set_local $ns4.pos (i32.sub (get_local $ns4.pos) (i32.const 1)))
          ))
        )(else
          (set_local $ns4.pos (i32.sub (get_local $ns4.pos) (i32.const 1)))
        ))
        (call $ns4.printChar (get_local $ns4.img) (i32.load8_u (get_local $ns4.i)))
        (set_local $ns4.i (i32.add (get_local $ns4.i) (i32.const 1)))
        (set_local $ns4.len (i32.sub (get_local $ns4.len) (i32.const 1)))
        (br_if 0 (i32.gt_u (get_local $ns4.len) (i32.const 0)))
      )
      (if (i32.eq (get_local $ns4.pos) (i32.const 0)) (then
        (if (i32.gt_u (get_local $ns4.sel) (i32.const 0)) (then
          (call $ns4.rect (get_local $ns4.img) (get_global $ns4.txtX) (get_global $ns4.txtY) (i32.const 8) (i32.const 8) (get_local $ns4.c))
          (set_local $ns4.sel (i32.sub (get_local $ns4.sel) (i32.const 1)))
        )(else
          (call $ns4.rect (get_local $ns4.img) (get_global $ns4.txtX) (get_global $ns4.txtY) (i32.const 1) (i32.const 8) (get_local $ns4.c))
          (set_local $ns4.pos (i32.sub (get_local $ns4.pos) (i32.const 1)))
        ))
      )(else
        (set_local $ns4.pos (i32.sub (get_local $ns4.pos) (i32.const 1)))
      ))
    ))
  )

;;"\$"

;;"\$"




;;--------;;--------;;--------;;--------;;--------;;--------;;--------;;







  ;; Table for callback functions.
  (table $ns0.table 8 anyfunc)
    (elem (i32.const 1) $ns0.storeImages)
    (elem (i32.const 2) $ns0.getStuff)
    (export "table" (table $ns0.table))

  ;; Linear memory.
  (memory $ns0.memory 1)
    (export "memory" (memory $ns0.memory))
    (data (i32.const 0xf100) "Hello again!\n\1b[1mBold!\1b[m\n\1b[3mItalic!\1b[m\n\1b[4mUnderline!\1b[m\n\1b[9mCrossed out!\1b[m\n")
    (data (i32.const 0xf200) "Colors!\n\1b[30mblack?\1b[m\n\1b[31mred\1b[m\n\1b[32mgreen\1b[m\n\1b[33myellow\1b[m\n\1b[34mblue")
    (data (i32.const 0xf300) "\1b[m\n\1b[35mmagenta\1b[m\n\1b[36mcyan\1b[m\n\1b[37mwhite\n")
    (data (i32.const 0xf400) "Colors!\n\1b[40mblack?\n\1b[41mred\n\1b[42mgreen\n\1b[43myellow\1b[m\n\1b[44mblue")
    (data (i32.const 0xf500) "\1b[m\n\1b[45mmagenta\1b[m\n\1b[0;46mcyan\1b[m\n\1b[47mwhite\1b[u")
    (data (i32.const 0xf600) "foo=bar&life=42");;15
    (data (i32.const 1010) "Hello world from WASM!");;22
    (data (i32.const 1040) "./images/sleepyhead.png");;23
    (data (i32.const 1080) "./images/pointer.png");;20
    (data (i32.const 1120) "./images/font.png");;17
    (data (i32.const 1160) "http://codeartistic.ninja");;25
    (data (i32.const 1190) "readImage");;9

  ;; Global variables
  (global $ns0.readImage (mut i32) (i32.const 0))
  (global $ns0.codeartistic (mut i32) (i32.const 0))
  (global $ns0.sleepyheadReq (mut i32) (i32.const 0))
  (global $ns0.sleepyhead    (mut i32) (i32.const 0))
  (global $ns0.pointerReq (mut i32) (i32.const 0))
  (global $ns0.pointer    (mut i32) (i32.const 0))
  (global $ns0.fontReq (mut i32) (i32.const 0))

  (global $ns0.left (mut i32) (i32.const 100))
  (global $ns0.leftV (mut i32) (i32.const 0))
  (global $ns0.leftColor (mut i32) (i32.const 100))
  (global $ns0.right (mut i32) (i32.const 100))
  (global $ns0.rightV (mut i32) (i32.const 0))
  (global $ns0.rightColor (mut i32) (i32.const 100))
  (global $ns0.ballX (mut f32) (f32.const 160))
  (global $ns0.ballY (mut f32) (f32.const 100))
  (global $ns0.ballVX (mut i32) (i32.const 1))
  (global $ns0.ballVY (mut i32) (i32.const 0))
  (global $ns0.bgColor (mut i32) (i32.const 0))
  (global $ns0.ballColor (mut i32) (i32.const 0xff0000ff))
  (global $ns0.beep (mut i32) (i32.const 1))
  (global $ns0.inputText (mut i32) (i32.const 1))

  ;; Init function is called once on start.
  (func $ns0.init
    (call $ns2.printStr (call $ns2.createString (i32.const 1010)))
    (call $ns1.setStepInterval (f64.div (f64.const 1000) (f64.const 60)))
    (set_global $ns4.display (call $ns4.createImg (i32.const 320) (i32.const 200)))
    (call $ns1.setDisplayMode (i32.const 1) (i32.const 320) (i32.const 200))
    (call $ns1.focusInput (i32.const 3))
  )
  (export "init" (func $ns0.init))

  (func $ns0.getStuff (param $ns0.success i32) (param $ns0.len i32) (param $ns0.req i32)
    (call $ns1.log)
  )

  (func $ns0.storeImages (param $ns0.success i32) (param $ns0.w i32) (param $ns0.h i32) (param $ns0.req i32)
    (if (i32.eq (get_local $ns0.req) (get_global $ns0.sleepyheadReq)) (then
      (set_global $ns0.sleepyhead (call $ns4.createImg (get_local $ns0.w) (get_local $ns0.h)))
      (call $ns1.popToMemory (i32.add (call $ns3.getPartOffset (get_global $ns0.sleepyhead)) (i32.const 8)))
    ))
    (if (i32.eq (get_local $ns0.req) (get_global $ns0.pointerReq)) (then
      (set_global $ns0.pointer (call $ns4.createImg (get_local $ns0.w) (get_local $ns0.h)))
      (call $ns1.popToMemory (i32.add (call $ns3.getPartOffset (get_global $ns0.pointer)) (i32.const 8)))
    ))
    (if (i32.eq (get_local $ns0.req) (get_global $ns0.fontReq)) (then
      (set_global $ns4.font (call $ns4.createImg (get_local $ns0.w) (get_local $ns0.h)))
      (call $ns1.popToMemory (i32.add (call $ns3.getPartOffset (get_global $ns4.font)) (i32.const 8)))
    ))
  )


  ;; Step function is called once every interval.
  (func $ns0.step (param $ns0.t f64)
    ;; (call $log2floats (call $fi.getGameAxisX) (call $fi.getGameAxisY) )
    (set_global $ns0.ballX (f32.add (get_global $ns0.ballX) (call $ns1.getGameAxisX)))
    (set_global $ns0.ballY (f32.add (get_global $ns0.ballY) (call $ns1.getGameAxisY)))
    (if (call $ns1.getMousePressed)(then
      (set_global $ns0.ballX (f32.convert_s/i32 (call $ns1.getMouseX)))
      (set_global $ns0.ballY (f32.convert_s/i32 (call $ns1.getMouseY)))
    ))
  )
  (export "step" (func $ns0.step))

  ;; Display function is called whenever the display needs to be redrawn.
  (func $ns0.display (param $ns0.t f64)
    (call $ns4.rect (get_global $ns4.display) (i32.const 0) (i32.const 0) (call $ns4.getImgWidth (get_global $ns4.display)) (call $ns4.getImgHeight (get_global $ns4.display)) (get_global $ns0.bgColor))
    (call $ns4.rect (get_global $ns4.display) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballX)) (i32.const 4)) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballY)) (i32.const 4)) (i32.const 8) (i32.const 8) (get_global $ns0.ballColor))
    (if (call $ns1.getGameButtonA)(then
      (call $ns4.rect (get_global $ns4.display) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballX)) (i32.const 0)) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballY)) (i32.const 2)) (i32.const 8) (i32.const 4) (get_global $ns0.ballColor))
    ))
    (if (call $ns1.getGameButtonX)(then
      (call $ns4.rect (get_global $ns4.display) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballX)) (i32.const 8)) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballY)) (i32.const 2)) (i32.const 8) (i32.const 4) (get_global $ns0.ballColor))
    ))
    (if (call $ns1.getGameButtonY)(then
      (call $ns4.rect (get_global $ns4.display) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballX)) (i32.const 2)) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballY)) (i32.const 0)) (i32.const 4) (i32.const 8) (get_global $ns0.ballColor))
    ))
    (if (call $ns1.getGameButtonB)(then
      (call $ns4.rect (get_global $ns4.display) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballX)) (i32.const 2)) (i32.sub (i32.trunc_s/f32 (get_global $ns0.ballY)) (i32.const 8)) (i32.const 4) (i32.const 8) (get_global $ns0.ballColor))
    ))
    (call $ns1.displayMemory (i32.add (call $ns3.getPartOffset (get_global $ns4.display)) (i32.const 8)) (i32.sub (call $ns3.getPartLength (get_global $ns4.display)) (i32.const 8)) (i32.const 0))
  )
  (export "display" (func $ns0.display))

  ;; Break function is called whenever Esc is pressed.
  (func $ns0.break
    (call $ns1.shutdown)
  )
  (export "break" (func $ns0.break))




;;--------;;--------;;--------;;--------;;--------;;--------;;--------;;





 
  

 








)

;;"\$"

;;"\$"

;;"\$"

;;"\$"

;;"\$"
