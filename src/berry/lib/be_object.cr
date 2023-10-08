lib LibBerry
  struct BGCObject
    nxt : BGCObject*
    type : BByte
    marked : BByte
  end

  type BInstruction = UInt32

  struct BString
    nxt : BGCObject*
    type : BByte
    marked : BByte
  end

  struct BVector
    capacity : LibC::Int
    size : LibC::Int
    count : LibC::Int
    data : Void*
    last : Void*
  end

  alias BStack = BVector

  union BValData
    b : BBool
    r : BReal
    i : BInt
    p : Void*
    v : Void*
    s : BString*
    gc : BGCObject*
    nf : BNtvFunc
  end

  struct BValue
    v : BValData
    type : LibC::Int
  end

  struct BUpValDesc
    name : BString*
    instack : BByte
    idx : BByte
  end

  struct BLineInfo
    name : BString*
    linenumber : LibC::Int
    endpc : LibC::Int
  end

  struct BVarInfo
    name : BString*
    beginpc : LibC::Int
    endpc : LibC::Int
  end

  struct BProto
    nxt : BGCObject*
    type : BByte
    marked : BByte

    nstack : BByte
    nupvals : BByte
    argc : BByte
    varg : BByte
    gray : BGCObject*
    upvals : BUpValDesc*
    ktab : BValue*
    ptab : Pointer(Pointer(BProto))
    code : BInstruction*
    name : BString*
    codesize : LibC::Int
    nconst : LibC::Int
    nproto : LibC::Int
    source : BString*
    lineinfo : BLineInfo*
    nlineinfo : LibC::Int
    varinfo : BVarInfo*
    nvarinfo : LibC::Int
  end

  struct BClosure
    nxt : BGCObject*
    type : BByte
    marked : BByte

    nupvals : BByte
    gray : BGCObject*
    proto : BProto*
    upvals : StaticArray(BUpVal*, 1)
  end

  struct BNtvClos
    nxt : BGCObject*
    type : BByte
    marked : BByte

    nupvals : BByte
    gray : BGCObject*
    f : BNtvFunc
  end

  struct BCommonObj
    nxt : BGCObject*
    type : BByte
    marked : BByte

    data : Void*
    destroy : BNtvFunc
  end

  alias BReader = Proc(Void*, LibC::SizeT*, UInt8*)

  fun be_vtype2str(v : BValue*) : UInt8*
  fun be_indexof(vm : BVM*, obj : BGCObject*) : BValue*
  fun be_commonobj_delete(vm : BVM*, obj : BGCObject*) : Void
  fun be_commonobj_destroy_generic(vm : BVM*)
end
