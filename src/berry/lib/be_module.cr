lib LibBerry
  union Infodata
    native : BNtvModule*
    name : UInt8*
    sname : BString
  end

  struct BModule
    nxt : BGCObject*
    type : BByte
    marked : BByte

    table : BMap*
    info : Infodata
    gray : BGCObject
  end

  fun be_module_new(vm : BVM*) : BModule*
  fun be_module_delete(vm : BVM*, mod : BModule*) : Void
  fun be_module_load(vm : BVM*, path : BString*) : LibC::Int
  fun be_module_attr(vm : BVM*, mod : BModule*, attr : BString*, dst : BValue*) : LibC::Int
  fun be_module_setmember(vm : BVM*, mod : BModule*, attr : BString*, src : BValue*) : BBool
  fun be_module_name(mod : BModule*) : UInt8*
  fun be_module_setname(mod : BModule*, name : BString*)
end
