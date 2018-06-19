(module
  (import "env" "pushFromMemory" (func $pushFromMemory (param $offset i32) (param $length i32)))
  (import "env" "popToMemory" (func $popToMemory (param $offset i32)))
  (import "env" "setDisplayMode" (func $setDisplayMode (param $mode i32) (param $width i32) (param $height i32)))
  (import "env" "print" (func $print ))
  (import "env" "read" (func $read (param $tableIndex i32) (result i32)))

  ;; Table for callback functions.
  (table $table 8 anyfunc)
    (export "table" (table $table))

  ;; Linear memory.
  (memory $memory 1)
    (data (i32.const 0) "./myfile.txt")
    (export "memory" (memory $memory))

  ;; Global variables
  (global $readRequest (mut i32) (i32.const 0))

  ;; Init function is called once on start.
  (func $init
    ;; initializing display
    (call $setDisplayMode (i32.const 0) (i32.const 80) (i32.const 20))
    ;; push filename to buffer stack
    (call $pushFromMemory (i32.const 0) (i32.const 12))
    ;; start reading the file, passing the callback function ($readCallback at table index 1), storing the requestId in $readRequest.
    (set_global $readRequest (call $read (i32.const 1)))
  )
  (export "init" (func $init))

  ;; The callback function will be called once the file has been read
  (func $readCallback (param $success i32) (param $length i32) (param $requestId i32)
    ;; Check that the operation succeeded
    (if (get_local $success)(then
      ;; Check which request called this callback. (Not needed if you know there is only one)
      (if (i32.eq (get_global $readRequest) (get_local $requestId))(then
        ;; store the file contents somewhere in memory
        (call $popToMemory (i32.const 16))

        ;; now, let's print it!
        (call $pushFromMemory (i32.const 16) (get_local $length))
        (call $print)
      ))
    ))
  )
  ;; remember to assign callbacks to the function table
  (elem (i32.const 1) $readCallback)
)
