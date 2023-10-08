lib LibBerry
  struct BClass
    nxt : BGCObject*
    type : BByte
    marked : BByte

    nvar : UInt16
    parent : BClass*
    members : BMap*
    name : BString*
    gray : BGCObject*
  end

  struct BInstance
    nxt : BGCObject*
    type : BByte
    marked : BByte

    parent : BInstance*
    child : BInstance*
    klass : BClass*
    gray : BGCObject*
    members : StaticArray(BValue, 1)
  end

  fun be_newclass(vm : BVM*, name : BString*, parent : BClass*) : BClass*
  fun be_class_compress(vm : BVM*, c : BClass*) : Void
  fun be_class_attribute(vm : BVM*, c : BClass*, attr : BString*) : LibC::Int
  fun be_class_member_bind(vm : BVM*, c : BClass*, name : BString*, var : BBool) : Void
  fun be_class_method_bind(vm : BVM*, c : BClass*, name : BString*, p : BProto*, is_static : BBool) : Void
  fun be_class_native_method_bind(vm : BVM*, c : BClass*, name : BString*, f : BNtvFunc) : Void
  fun be_class_closure_method_bind(vm : BVM*, c : BClass*, name : BString*, cl : BClosure*) : Void
  fun be_class_member(vm : BVM*, obj : BClass*, name : BString*, dst : BValue*) : LibC::Int
  fun be_class_setmember(vm : BVM*, obj : BClass*, name : BString*, src : BValue*) : BBool
  fun be_class_closure_count(c : BClass*) : LibC::Int
  fun be_class_upvalue_init(vm : BVM*, c : BClass*) : Void
  fun be_class_newobj(vm : BVM*, c : BClass*, pos : LibC::Int, argc : LibC::Int, mode : LibC::Int) : BBool
  fun be_instance_member_simple(vm : BVM*, obj : BInstance*, name : BString*, dst : BValue*) : LibC::Int
  fun be_instance_member(vm : BVM*, obj : BInstance*, name : BString*, dst : BValue*) : LibC::Int
  fun be_instance_setmember(vm : BVM*, obj : BInstance*, name : BString*, src : BValue*) : BBool
end
