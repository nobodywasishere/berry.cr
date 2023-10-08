lib LibBerry
  enum CompOpMask
    COMP_NAMED_GBL = 0x0
    COMP_STRICT    = 0x1
  end

  struct Global
    vtab : BMap*
    vlist : BVector
  end

  struct BuiltIn
    vtab : BMap*
    vlist : BVector
  end

  struct BGlobalDesc
    global : Global
    builtin : BuiltIn
  end

  struct BCallFrame
    func : BValue*
    top : BValue*
    reg : BValue*
    ip : BInstruction*
    lineinfo : BLineInfo*
    status : LibC::Int
  end

  struct BGC
    list : BGCObject*
    gray : BGCObject*
    fixed : BGCObject*
    pool16 : GC16*
    pool32 : GC32*
    usage : LibC::SizeT
    threshold : LibC::SizeT
    steprate : BByte
    status : BByte
  end

  struct BStringTable
    table : Pointer(Pointer(BString))
    count : LibC::Int
    size : LibC::Int
  end

  struct BModuleDesc
    loaded : BMap*
    path : BList*
  end

  struct BCallSnapshot
    func : BValue
    op : BInstruction*
  end

  union BValueUpVal
    value : BValue
    nxt : BUpVal*
  end

  struct BUpVal
    value : BValue*
    u : BValueUpVal
    refcnt : LibC::Int
  end

  struct BVM
    glbdesc : BGlobalDesc
    stack : BValue*
    stacktop : BValue*
    upvalist : BUpVal*
    callstack : BStack
    exceptstack : BStack
    cd : BCallFrame*
    reg : BValue*
    top : BValue*
    ip : BInstruction*
    errjmp : BLongJmp
    refstack : BStack
    mod : BModuleDesc
    strtab : BStringTable
    tracestack : BStack
    ntvclass : BMap*
    gc : BGC
    ctypefunc : BCTypeFunc
    compopt : BByte
    obshook : BObsHook
    counter_ins : UInt32
    counter_enter : UInt32
    counter_call : UInt32
    counter_get : UInt32
    counter_set : UInt32
    counter_try : UInt32
    counter_exc : UInt32
    counter_gc_kept : UInt32
    counter_gc_freed : UInt32
    hook : BValue
    hookmask : BByte
  end

  fun be_default_init_native_function(vm : BVM*) : LibC::Int
  fun be_dofunc(vm : BVM*, v : BValue*, argc : LibC::Int) : Void
  fun be_value2bool(vm : BVM*, v : BValue*) : BBool
  fun be_vm_iseq(vm : BVM*, a : BValue*, b : BValue*) : BBool
  fun be_vm_isneq(vm : BVM*, a : BValue*, b : BValue*) : BBool
  fun be_vm_islt(vm : BVM*, a : BValue*, b : BValue*) : BBool
  fun be_vm_isle(vm : BVM*, a : BValue*, b : BValue*) : BBool
  fun be_vm_isgt(vm : BVM*, a : BValue*, b : BValue*) : BBool
  fun be_vm_isge(vm : BVM*, a : BValue*, b : BValue*) : BBool
end
