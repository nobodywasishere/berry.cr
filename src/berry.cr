module Berry
  VERSION = "1.1.0"
end

require "./berry/uint24"
require "./berry/lib"

get_line = ->(prompt : UInt8*) : UInt8* {
  print String.new(prompt)
  gets.try(&.to_unsafe) || "".to_unsafe
}

free_line = ->(_line : UInt8*) {
  GC.free(_line.as(Pointer(Void)))
}

def repl
  vm = LibBerry.be_vm_new

  LibBerry.be_repl(vm, get_line, free_line)

  LibBerry.be_vm_delete(vm)
end

repl
