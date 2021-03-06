(
  ;;@require $fi "./_fantasyinternet.wast"

;;@require $mem "./_memory.wast"

  ;; String manipulation
  
  (func $printStr (param $str i32)
    (call $fi.print (call $fi.pushFromMemory (call $mem.getPartOffset (get_local $str)) (call $mem.getPartLength (get_local $str))))
  )
  
  
  (func $createString (param $srcOffset i32) (result i32)
    (local $str i32)
    (local $len i32)
    (set_local $len (i32.const 0))
    (block(loop
      (br_if 1 (i32.eq (i32.load8_u (i32.add (get_local $srcOffset) (get_local $len))) (i32.const 0)))
      (set_local $len (i32.add (get_local $len) (i32.const 1)))
      (br 0)
    ))
    (set_local $str (call $mem.createPart (get_local $len)))
    (call $mem.copyMem (get_local $srcOffset) (call $mem.getPartOffset (get_local $str)) (get_local $len))
    (get_local $str)
  )

  (func $byteAt (param $str i32) (param $pos i32) (result i32)
    (i32.load8_u (i32.add (call $mem.getPartOffset (get_local $str)) (get_local $pos)))
  )
  
  (func $substr (param $str i32) (param $pos i32) (param $len i32) (result i32)
    (local $strc i32)
    (if (i32.gt_u (get_local $pos) (call $mem.getPartLength (get_local $str))) (then
      (set_local $pos (call $mem.getPartLength (get_local $str)))
    ))
    (if (i32.gt_u (get_local $len) (i32.sub (call $mem.getPartLength (get_local $str)) (get_local $pos))) (then
      (set_local $len (i32.sub (call $mem.getPartLength (get_local $str)) (get_local $pos)) )
    ))
    (set_local $strc (call $mem.createPart (get_local $len)))
    (call $mem.copyMem (i32.add (call $mem.getPartOffset (get_local $str)) (get_local $pos)) (call $mem.getPartOffset (get_local $strc)) (get_local $len))
    (get_local $strc)
  )
  
  (func $concat (param $stra i32) (param $strb i32) (result i32)
    (local $strc i32)
    (set_local $strc (call $mem.createPart (i32.add (call $mem.getPartLength (get_local $stra)) (call $mem.getPartLength (get_local $strb)))))
    (call $mem.copyMem (call $mem.getPartOffset (get_local $stra)) (call $mem.getPartOffset (get_local $strc)) (call $mem.getPartLength (get_local $stra)))
    (call $mem.copyMem (call $mem.getPartOffset (get_local $strb)) (i32.add (call $mem.getPartOffset (get_local $strc)) (call $mem.getPartLength (get_local $stra))) (call $mem.getPartLength (get_local $strb)))
    (get_local $strc)
  )
  
  (func $appendBytes (param $str i32) (param $bytes i64)
    (local $l i32)
    (set_local $l (call $mem.getPartLength (get_local $str)))
    (call $mem.resizePart (get_local $str) (i32.add (get_local $l) (i32.const 9)))
    (set_local $l (i32.add (get_local $l) (i32.const 1)))
    (i64.store (i32.add (call $mem.getPartOffset (get_local $str)) (get_local $l)) (i64.const 0))
    (set_local $l (i32.sub (get_local $l) (i32.const 1)))
    (i64.store (i32.add (call $mem.getPartOffset (get_local $str)) (get_local $l)) (get_local $bytes))
    (set_local $l (i32.add (get_local $l) (i32.const 1)))
    (block(loop
      (br_if 1 (i32.eq (call $byteAt (get_local $str) (get_local $l)) (i32.const 0)))
      (set_local $l (i32.add (get_local $l) (i32.const 1)))
      (br 0)
    ))
    (call $mem.resizePart (get_local $str) (get_local $l))
  )
  
  (;;func $usascii (param $str i32)
    (local $i i32)
    (local $l i32)
    (set_local $i (call $mem.getPartOffset (get_local $str)))
    (set_local $l (call $mem.getPartLength (get_local $str)))
    (block (loop
      (br_if 1 (i32.eq (get_local $l) (i32.const 0)))
      (if (i32.gt_u (i32.load8_u (get_local $i)) (i32.const 127)) (then
        (i32.store8 (get_local $i) (i32.const 63))
      ))
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (set_local $l (i32.sub (get_local $l) (i32.const 1)))
      (br 0)
    ))
  ;;)
  
  (func $getLine (param $str i32) (param $linenum i32) (result i32)
    (local $line i32)
    (local $col i32)
    (local $p i32)
    (local $strc i32)
    (block(loop
      (br_if 1 (get_local $strc))
      (set_local $col (i32.add (get_local $col) (i32.const 1)))
      (if (i32.eq (call $byteAt (get_local $str) (get_local $p)) (i32.const 10)) (then
        (if (i32.eq (get_local $line) (get_local $linenum)) (then
          (set_local $p (i32.sub (get_local $p) (get_local $col)))
          (set_local $strc (call $substr (get_local $str) (get_local $p) (get_local $col)))
          (set_local $p (i32.add (get_local $p) (get_local $col)))
        ))
        (set_local $line (i32.add (get_local $line) (i32.const 1)))
        (set_local $col (i32.const 0))
      ))
      (set_local $p (i32.add (get_local $p) (i32.const 1)))
      (br 0)
    ))
    (get_local $strc)
  )

  (func $countLines (param $str i32) (result i32)
    (local $line i32)
    (local $p i32)
    (local $l i32)
    (set_local $line (i32.const 1))
    (set_local $l (call $mem.getPartLength (get_local $str)))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $p) (get_local $l)))
      (if (i32.eq (call $byteAt (get_local $str) (get_local $p)) (i32.const 10)) (then
        (set_local $line (i32.add (get_local $line) (i32.const 1)))
      ))
      (set_local $p (i32.add (get_local $p) (i32.const 1)))
      (br 0)
    ))
    (get_local $line)
  )

  (func $lineAt (param $str i32) (param $pos i32) (result i32)
    (local $line i32)
    (local $p i32)
    (block(loop
      (br_if 1 (i32.eq (get_local $p) (get_local $pos)))
      (if (i32.eq (call $byteAt (get_local $str) (get_local $p)) (i32.const 10)) (then
        (set_local $line (i32.add (get_local $line) (i32.const 1)))
      ))
      (set_local $p (i32.add (get_local $p) (i32.const 1)))
      (br 0)
    ))
    (get_local $line)
  )

  (func $columnAt (param $str i32) (param $pos i32) (result i32)
    (local $col i32)
    (local $p i32)
    (block(loop
      (br_if 1 (i32.eq (get_local $p) (get_local $pos)))
      (set_local $col (i32.add (get_local $col) (i32.const 1)))
      (if (i32.eq (call $byteAt (get_local $str) (get_local $p)) (i32.const 10)) (then
        (set_local $col (i32.const 0))
      ))
      (set_local $p   (i32.add (get_local $p)   (i32.const 1)))
      (br 0)
    ))
    (get_local $col)
  )
  
  (func $uintToStr (param $int i32) (result i32)
    (local $order i32)
    (local $digit i32)
    (local $str i32)
    (set_local $order (i32.const 1000000000))
    (set_local $str (call $mem.createPart (i32.const 0)))
    (block(loop
      (br_if 1 (i32.eq (get_local $order) (i32.const 0)))
      (set_local $digit (i32.div_u (get_local $int) (get_local $order)))
      (if (i32.or (get_local $digit) (call $mem.getPartLength (get_local $str))) (then
        (call $appendBytes (get_local $str) (i64.extend_u/i32 (i32.add (i32.const 0x30) (get_local $digit))))
      ))
      (set_local $int (i32.rem_u (get_local $int) (get_local $order)))
      (set_local $order (i32.div_u (get_local $order) (i32.const 10)))
      (br 0)
    ))
    (get_local $str)
  )
  
  (func $compare (param $stra i32) (param $strb i32) (result i32)
    (local $p i32)
    (local $l i32)
    (if (i32.ne (call $mem.getPartLength (get_local $stra)) (call $mem.getPartLength (get_local $strb))) (then
      (return (i32.const 0))
    ))
    (set_local $l (call $mem.getPartLength (get_local $stra)))
    (block(loop
      (br_if 1 (i32.eq (get_local $p) (get_local $l)))
      (if (i32.ne (call $byteAt (get_local $stra) (get_local $p)) (call $byteAt (get_local $strb) (get_local $p))) (then
        (return (i32.const 0))
      ))
      (set_local $p (i32.add (get_local $p) (i32.const 1)))
      (br 0)
    ))
    (i32.const 1)
  )
  
  (func $indexOf (param $haystack i32) (param $needle i32) (param $pos i32) (result i32)
    (local $sub i32)
    (if (i32.lt_u (call $mem.getPartLength (get_local $haystack)) (call $mem.getPartLength (get_local $needle))) (then
      (return (i32.const -1))
    ))
    (set_local $sub (call $mem.createPart (call $mem.getPartLength (get_local $needle))))
    (block(loop
      (br_if 1 (i32.ge_u (get_local $pos) (i32.sub (call $mem.getPartLength (get_local $haystack)) (call $mem.getPartLength (get_local $needle)))))
      (call $mem.copyMem (i32.add (call $mem.getPartOffset (get_local $haystack)) (get_local $pos)) (call $mem.getPartOffset (get_local $sub)) (call $mem.getPartLength (get_local $sub)))
      (if (call $compare (get_local $sub) (get_local $needle)) (then
        (return (get_local $pos))
      ))
      (set_local $pos (i32.add (get_local $pos) (i32.const 1)))
      (br 0)
    ))
    (i32.const -1)
  )

  (func $lastIndexOf (param $haystack i32) (param $needle i32) (param $pos i32) (result i32)
    (local $sub i32)
    (if (i32.lt_u (call $mem.getPartLength (get_local $haystack)) (call $mem.getPartLength (get_local $needle))) (then
      (return (i32.const -1))
    ))
    (set_local $sub (call $mem.createPart (call $mem.getPartLength (get_local $needle))))
    (block(loop
      (br_if 1 (i32.eq (get_local $pos) (i32.const 0)))
      (call $mem.copyMem (i32.add (call $mem.getPartOffset (get_local $haystack)) (get_local $pos)) (call $mem.getPartOffset (get_local $sub)) (call $mem.getPartLength (get_local $sub)))
      (if (call $compare (get_local $sub) (get_local $needle)) (then
        (return (get_local $pos))
      ))
      (set_local $pos (i32.sub (get_local $pos) (i32.const 1)))
      (br 0)
    ))
    (i32.const -1)
  )
  
  (func $trim (param $str i32)
    (local $p i32)
    (local $l i32)
    (set_local $p (call $mem.getPartOffset (get_local $str)))
    (set_local $l (call $mem.getPartLength (get_local $str)))
    (block(loop
      (br_if 1 (i32.or (i32.eqz (get_local $l)) (i32.gt_u (i32.load8_u (get_local $p)) (i32.const 32))))
      (set_local $p (i32.add (get_local $p) (i32.const 1)))
      (set_local $l (i32.sub (get_local $l) (i32.const 1)))
      (br 0)
    ))
    (call $mem.copyMem (get_local $p) (call $mem.getPartOffset (get_local $str)) (get_local $l))
    (block(loop
      (br_if 1 (i32.or (i32.eqz (get_local $l)) (i32.gt_u (call $byteAt (get_local $str) (i32.sub (get_local $l) (i32.const 1))) (i32.const 32))))
      (set_local $l (i32.sub (get_local $l) (i32.const 1)))
      (br 0)
    ))
    (call $mem.resizePart (get_local $str) (get_local $l))
  )

)