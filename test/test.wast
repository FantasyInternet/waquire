(module
  ;;@require $fi "./_fantasyinternet.wast"
  ;;@require $str "./_strings.wast"
  ;;@require $gfx "./_graphics.wast"
  ;;@require $mem "./_memory.wast"


  ;; Table for callback functions.
  (table $table 8 anyfunc)
    (elem (i32.const 1) $storeImages)
    (elem (i32.const 2) $getStuff)
    (export "table" (table $table))

  ;; Linear memory.
  (memory $memory 1)
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
    (export "memory" (memory $memory))

  ;; Global variables
  (global $readImage (mut i32) (i32.const 0))
  (global $codeartistic (mut i32) (i32.const 0))
  (global $sleepyheadReq (mut i32) (i32.const 0))
  (global $sleepyhead    (mut i32) (i32.const 0))
  (global $pointerReq (mut i32) (i32.const 0))
  (global $pointer    (mut i32) (i32.const 0))
  (global $fontReq (mut i32) (i32.const 0))

  (global $left (mut i32) (i32.const 100))
  (global $leftV (mut i32) (i32.const 0))
  (global $leftColor (mut i32) (i32.const 100))
  (global $right (mut i32) (i32.const 100))
  (global $rightV (mut i32) (i32.const 0))
  (global $rightColor (mut i32) (i32.const 100))
  (global $ballX (mut f32) (f32.const 160))
  (global $ballY (mut f32) (f32.const 100))
  (global $ballVX (mut i32) (i32.const 1))
  (global $ballVY (mut i32) (i32.const 0))
  (global $bgColor (mut i32) (i32.const 0))
  (global $ballColor (mut i32) (i32.const 0xff0000ff))
  (global $beep (mut i32) (i32.const 1))
  (global $inputText (mut i32) (i32.const 1))

  ;; Init function is called once on start.
  (func $init
    (call $str.printStr (call $str.createString (i32.const 1010)))
    (call $fi.setStepInterval (f64.div (f64.const 1000) (f64.const 60)))
    (set_global $gfx.display (call $gfx.createImg (i32.const 320) (i32.const 200)))
    (call $fi.setDisplayMode (i32.const 1) (i32.const 320) (i32.const 200))
    (call $fi.focusInput (i32.const 3))
  )
  (export "init" (func $init))

  (func $getStuff (param $success i32) (param $len i32) (param $req i32)
    (call $fi.log)
  )

  (func $storeImages (param $success i32) (param $w i32) (param $h i32) (param $req i32)
    (if (i32.eq (get_local $req) (get_global $sleepyheadReq)) (then
      (set_global $sleepyhead (call $gfx.createImg (get_local $w) (get_local $h)))
      (call $fi.popToMemory (i32.add (call $mem.getPartOffset (get_global $sleepyhead)) (i32.const 8)))
    ))
    (if (i32.eq (get_local $req) (get_global $pointerReq)) (then
      (set_global $pointer (call $gfx.createImg (get_local $w) (get_local $h)))
      (call $fi.popToMemory (i32.add (call $mem.getPartOffset (get_global $pointer)) (i32.const 8)))
    ))
    (if (i32.eq (get_local $req) (get_global $fontReq)) (then
      (set_global $gfx.font (call $gfx.createImg (get_local $w) (get_local $h)))
      (call $fi.popToMemory (i32.add (call $mem.getPartOffset (get_global $gfx.font)) (i32.const 8)))
    ))
  )


  ;; Step function is called once every interval.
  (func $step (param $t f64)
    ;; (call $log2floats (call $fi.getGameAxisX) (call $fi.getGameAxisY) )
    (set_global $ballX (f32.add (get_global $ballX) (call $fi.getGameAxisX)))
    (set_global $ballY (f32.add (get_global $ballY) (call $fi.getGameAxisY)))
    (if (call $fi.getMousePressed)(then
      (set_global $ballX (f32.convert_s/i32 (call $fi.getMouseX)))
      (set_global $ballY (f32.convert_s/i32 (call $fi.getMouseY)))
    ))
  )
  (export "step" (func $step))

  ;; Display function is called whenever the display needs to be redrawn.
  (func $display (param $t f64)
    (call $gfx.rect (get_global $gfx.display) (i32.const 0) (i32.const 0) (call $gfx.getImgWidth (get_global $gfx.display)) (call $gfx.getImgHeight (get_global $gfx.display)) (get_global $bgColor))
    (call $gfx.rect (get_global $gfx.display) (i32.sub (i32.trunc_s/f32 (get_global $ballX)) (i32.const 4)) (i32.sub (i32.trunc_s/f32 (get_global $ballY)) (i32.const 4)) (i32.const 8) (i32.const 8) (get_global $ballColor))
    (if (call $fi.getGameButtonA)(then
      (call $gfx.rect (get_global $gfx.display) (i32.sub (i32.trunc_s/f32 (get_global $ballX)) (i32.const 0)) (i32.sub (i32.trunc_s/f32 (get_global $ballY)) (i32.const 2)) (i32.const 8) (i32.const 4) (get_global $ballColor))
    ))
    (if (call $fi.getGameButtonX)(then
      (call $gfx.rect (get_global $gfx.display) (i32.sub (i32.trunc_s/f32 (get_global $ballX)) (i32.const 8)) (i32.sub (i32.trunc_s/f32 (get_global $ballY)) (i32.const 2)) (i32.const 8) (i32.const 4) (get_global $ballColor))
    ))
    (if (call $fi.getGameButtonY)(then
      (call $gfx.rect (get_global $gfx.display) (i32.sub (i32.trunc_s/f32 (get_global $ballX)) (i32.const 2)) (i32.sub (i32.trunc_s/f32 (get_global $ballY)) (i32.const 0)) (i32.const 4) (i32.const 8) (get_global $ballColor))
    ))
    (if (call $fi.getGameButtonB)(then
      (call $gfx.rect (get_global $gfx.display) (i32.sub (i32.trunc_s/f32 (get_global $ballX)) (i32.const 2)) (i32.sub (i32.trunc_s/f32 (get_global $ballY)) (i32.const 8)) (i32.const 4) (i32.const 8) (get_global $ballColor))
    ))
    (call $fi.displayMemory (i32.add (call $mem.getPartOffset (get_global $gfx.display)) (i32.const 8)) (i32.sub (call $mem.getPartLength (get_global $gfx.display)) (i32.const 8)) (i32.const 0))
  )
  (export "display" (func $display))

  ;; Break function is called whenever Esc is pressed.
  (func $break
    (call $fi.shutdown)
  )
  (export "break" (func $break))
)
