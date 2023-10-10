class Berry::VM
  private getter vm : LibBerry::BVM* = LibBerry.be_vm_new

  property stdin : IO
  property stdout : IO

  def initialize(@stdin = STDIN, @stdout = STDOUT)
  end

  def finalize
    LibBerry.be_vm_delete(@vm)
  end

  def to_unsafe : LibBerry::BVM*
    vm
  end

  def self.exec(code : String, stdin : IO = STDIN, stdout : IO = STDOUT)
    vm = new(stdin, stdout)
    vm.exec(code)
  end

  def exec(code : String)
    register_callbacks
    LibBerry.be_loadbuffer(vm, "string", code.to_unsafe, code.size)
    LibBerry.be_pcall(vm, 0)
  end

  def register_function(name : String, &func : LibBerry::BNtvFunc)
    LibBerry.be_regfunc(vm, name.to_unsafe, func)
  end

  private def register_callbacks
    read_proc = ->(buffer : UInt8*, length : LibC::SizeT, io : Void*) : UInt8* {
      str = String.new(buffer, length)
      io.as(IO*).value.as(IO::Memory).read(str.to_slice)
      str.to_unsafe
    }

    write_proc = ->(buffer : UInt8*, length : LibC::SizeT, io : Void*) {
      str = String.new(buffer, length)
      io.as(IO*).value.write(str.to_slice)
    }

    LibBerry.be_readstring_callback_register(read_proc, pointerof(@stdin))
    LibBerry.be_writebuffer_callback_register(write_proc, pointerof(@stdout))
  end
end
