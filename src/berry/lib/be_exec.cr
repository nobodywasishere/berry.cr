lib LibBerry
  alias BPFunc = Proc(BVM*, Void*, Void)

  type BJmpBuf = StaticArray(UInt32, 1)

  struct BLongJmp
    b : BJmpBuf
    prev : BLongJmp*
    status : LibC::Int
  end

  struct BExceptFrame
    errjmp : BLongJmp
    depth : LibC::Int
    ip : BInstruction*
    refcount : LibC::Int
  end

  fun be_throw(vm : BVM*, errorcode : LibC::Int) : Void
  fun be_execprotected(vm : BVM*, f : BPFunc, data : Void*) : LibC::Int
  fun be_protectedparser(vm : BVM*, fname : UInt8*, reader : BReader, data : Void*, is_local : BBool) : LibC::Int
  fun be_protectedcall(vm : BVM*, v : BValue*, argc : LibC::Int) : LibC::Int
  fun be_stackpush(vm : BVM*)
  fun be_stack_expansion(vm : BVM*, n : LibC::Int) : Void
  fun be_except_block_setup(vm : BVM*) : Void
  fun be_except_block_resume(vm : BVM*) : Void
  fun be_except_block_close(vm : BVM*, count : LibC::Int) : Void
  fun be_save_stacktrace(vm : BVM*) : Void
end
