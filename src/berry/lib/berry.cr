lib LibBerry
  alias BByte = UInt8
  alias BInt = LibC::LongLong
  alias BReal = LibC::Double
  alias BBool = Bool
  alias BNtvFunc = Proc(BVM*, LibC::Int)

  struct BNFuncInfo
    name : UInt8*
    function : BNtvFunc
  end

  union Value
    i : BInt
    r : BReal
    b : BBool
    f : BNtvFunc
    s : UInt8*
    o : Void*
  end

  struct BNtvModObj
    name : UInt8*
    type : LibC::Int
    u : Value
  end

  struct BNtvModule
    name : UInt8*
    attrs : BNtvModObj*
    size : LibC::SizeT
    mod : BModule*
  end

  alias BClassPtr = BClass*
  alias BClassArray = BClassPtr*

  struct BHookInfo
    type : LibC::Int
    line : LibC::Int
    source : UInt8*
    func_name : UInt8*
    data : Void*
  end

  alias BNtvHook = Proc(BVM*, BHookInfo*, Void)
  alias BObsHook = Proc(BVM*, LibC::Int, Void) # Removed ...

  enum BEObShookEvents
    BE_OBS_PCALL_ERROR
    BE_OBS_GC_START
    BE_OBS_GC_END
    BE_OBS_VM_HEARTBEAT
    BE_OBS_STACK_RESIZE_START
  end

  alias BCTypeFunc = Proc(BVM*, Void*)

  fun be_str2int(str : UInt8*, endstr : UInt8**) : BInt
  fun be_str2real(str : UInt8*, endstr : UInt8**) : BReal
  fun be_str2num(vm : BVM*, str : UInt8*) : UInt8*

  fun be_top(vm : BVM*) : LibC::Int
  fun be_typename(vm : BVM*, index : LibC::Int) : UInt8*
  fun be_classname(vm : BVM*, index : LibC::Int) : UInt8*
  fun be_classof(vm : BVM*, index : LibC::Int) : BBool
  fun be_strlen(vm : BVM*, index : LibC::Int) : LibC::Int
  fun be_strconcat(vm : BVM*, index : LibC::Int) : Void
  fun be_pop(vm : BVM*, n : LibC::Int) : Void
  fun be_remove(vm : BVM*, index : LibC::Int) : Void
  fun be_absindex(vm : BVM*, index : LibC::Int) : LibC::Int

  fun be_isnil(vm : BVM*, index : LibC::Int) : BBool
  fun be_isbool(vm : BVM*, index : LibC::Int) : BBool
  fun be_isint(vm : BVM*, index : LibC::Int) : BBool
  fun be_isreal(vm : BVM*, index : LibC::Int) : BBool
  fun be_isnumber(vm : BVM*, index : LibC::Int) : BBool
  fun be_isstring(vm : BVM*, index : LibC::Int) : BBool
  fun be_isclosure(vm : BVM*, index : LibC::Int) : BBool
  fun be_isntvclos(vm : BVM*, index : LibC::Int) : BBool
  fun be_isfunction(vm : BVM*, index : LibC::Int) : BBool
  fun be_isproto(vm : BVM*, index : LibC::Int) : BBool
  fun be_isclass(vm : BVM*, index : LibC::Int) : BBool
  fun be_isinstance(vm : BVM*, index : LibC::Int) : BBool
  fun be_ismodule(vm : BVM*, index : LibC::Int) : BBool
  fun be_islist(vm : BVM*, index : LibC::Int) : BBool
  fun be_ismap(vm : BVM*, index : LibC::Int) : BBool
  fun be_iscomptr(vm : BVM*, index : LibC::Int) : BBool
  fun be_iscomobj(vm : BVM*, index : LibC::Int) : BBool
  fun be_isderived(vm : BVM*, index : LibC::Int) : BBool
  fun be_isbytes(vm : BVM*, index : LibC::Int) : BBool

  fun be_toint(vm : BVM*, index : LibC::Int) : BInt
  fun be_toreal(vm : BVM*, index : LibC::Int) : BReal
  fun be_toindex(vm : BVM*, index : LibC::Int) : LibC::Int
  fun be_tobool(vm : BVM*, index : LibC::Int) : BBool
  fun be_tostring(vm : BVM*, index : LibC::Int) : UInt8*
  fun be_toescape(vm : BVM*, index : LibC::Int, mode : LibC::Int) : UInt8*
  fun be_tocomptr(vm : BVM*, index : LibC::Int) : Void*
  fun be_moveto(vm : BVM*, from : LibC::Int, to : LibC::Int) : Void
  fun be_pushnil(vm : BVM*) : Void
  fun be_pushbool(vm : BVM*, b : LibC::Int) : Void
  fun be_pushint(vm : BVM*, i : BInt) : Void
  fun be_pushreal(vm : BVM*, r : BReal) : Void
  fun be_pushstring(vm : BVM*, str : UInt8*) : Void
  fun be_pushnstring(vm : BVM*, str : UInt8*, n : LibC::SizeT) : Void
  fun be_pushfstring(vm : BVM*, format : UInt8*) : UInt8* # Removed ...
  fun be_pushbuffer(vm : BVM*, size : LibC::SizeT) : Void*
  fun be_pushvalue(vm : BVM*, index : LibC::Int) : Void
  fun be_pushclosure(vm : BVM*, cl : Void*) : Void
  fun be_pushntvclosure(vm : BVM*, f : BNtvFunc, nupvals : LibC::Int) : Void
  fun be_pushntvfunction(vm : BVM*, f : BNtvFunc) : Void
  fun be_pushclass(vm : BVM*, name : UInt8*, lib : BNFuncInfo*) : Void
  fun be_pushntvclass(vm : BVM*, c : BClass*) : Void
  fun be_pushcomptr(vm : BVM*, ptr : Void*) : Void
  fun be_pushiter(vm : BVM*, index : LibC::Int) : BBool

  fun be_newlist(vm : BVM*) : Void
  fun be_newmap(vm : BVM*) : Void
  fun be_newmodule(vm : BVM*) : Void
  fun be_newcomobj(vm : BVM*, data : Void*, destroy : BNtvFunc) : Void
  fun be_newobject(vm : BVM*, name : UInt8*) : Void
  fun be_copy(vm : BVM*, index : LibC::Int) : BBool
  fun be_setname(vm : BVM*, index : LibC::Int, name : UInt8*) : BBool
  fun be_getglobal(vm : BVM*, name : UInt8*) : BBool
  fun be_setglobal(vm : BVM*, name : UInt8*) : Void
  fun be_getbuiltin(vm : BVM*, name : UInt8*) : BBool
  fun be_setmember(vm : BVM*, index : LibC::Int, k : UInt8*) : BBool
  fun be_getmember(vm : BVM*, index : LibC::Int, k : UInt8*) : BBool
  fun be_getmethod(vm : BVM*, index : LibC::Int, k : UInt8*) : BBool
  fun be_getindex(vm : BVM*, index : LibC::Int) : BBool
  fun be_setindex(vm : BVM*, index : LibC::Int) : BBool
  fun be_getupval(vm : BVM*, index : LibC::Int, pos : LibC::Int) : Void
  fun be_setupval(vm : BVM*, index : LibC::Int, pos : LibC::Int) : BBool
  fun be_setsuper(vm : BVM*, index : LibC::Int) : BBool
  fun be_getsuper(vm : BVM*, index : LibC::Int) : Void
  fun be_data_size(vm : BVM*, index : LibC::Int) : LibC::Int
  fun be_data_push(vm : BVM*, index : LibC::Int) : Void
  fun be_data_insert(vm : BVM*, index : LibC::Int) : BBool
  fun be_data_remove(vm : BVM*, index : LibC::Int) : BBool
  fun be_data_merge(vm : BVM*, index : LibC::Int) : BBool
  fun be_data_resize(vm : BVM*, index : LibC::Int) : Void
  fun be_data_reverse(vm : BVM*, index : LibC::Int) : Void
  fun be_iter_next(vm : BVM*, index : LibC::Int) : LibC::Int
  fun be_iter_hasnext(vm : BVM*, index : LibC::Int) : BBool
  fun be_refcontains(vm : BVM*, index : LibC::Int) : BBool
  fun be_refpush(vm : BVM*, index : LibC::Int) : Void
  fun be_refpop(vm : BVM*) : Void
  fun be_stack_require(vm : BVM*, count : LibC::Int) : Void
  fun be_getmodule(vm : BVM*, k : UInt8*) : BBool

  # /* relop operation APIs */
  fun be_iseq(vm : BVM*) : BBool
  fun be_isneq(vm : BVM*) : BBool
  fun be_islt(vm : BVM*) : BBool
  fun be_isle(vm : BVM*) : BBool
  fun be_isgt(vm : BVM*) : BBool
  fun be_isge(vm : BVM*) : BBool

  # /* Function call/return APIs */
  fun be_returnvalue(vm : BVM*) : LibC::Int
  fun be_returnnilvalue(vm : BVM*) : LibC::Int
  fun be_call(vm : BVM*, argc : LibC::Int) : Void
  fun be_pcall(vm : BVM*, argc : LibC::Int) : LibC::Int
  fun be_exit(vm : BVM*, status : LibC::Int) : Void

  # /* exception APIs */
  fun be_raise(vm : BVM*, except : UInt8*, msg : UInt8*) : Void
  fun be_getexcept(vm : BVM*, code : LibC::Int) : LibC::Int
  fun be_dumpvalue(vm : BVM*, index : LibC::Int) : Void
  fun be_dumpexcept(vm : BVM*) : Void
  fun be_stop_iteration(vm : BVM*) : Void

  fun be_regfunc(vm : BVM*, name : UInt8*, f : BNtvFunc) : Void
  fun be_regclass(vm : BVM*, name : UInt8*, lib : BNFuncInfo*) : Void

  # /* VM management APIs */
  fun be_vm_new : BVM*
  fun be_vm_delete(vm : BVM*) : Void

  # /* Observability hook */
  fun be_set_obs_hook(vm : BVM*, hook : BObsHook) : Void
  fun be_set_ctype_func_hanlder(vm : BVM*, handler : BCTypeFunc) : Void
  fun be_get_ctype_func_hanlder(vm : BVM*) : BCTypeFunc

  # /* code load APIs */
  fun be_loadbuffer(vm : BVM*, name : UInt8*, buffer : UInt8*, length : LibC::SizeT) : LibC::Int
  fun be_loadmode(vm : BVM*, name : UInt8*, islocal : BBool) : LibC::Int
  fun be_loadlib(vm : BVM*, path : UInt8*) : LibC::Int
  fun be_savecode(vm : BVM*, name : UInt8*) : LibC::Int

  # /* module path list APIs */
  fun be_module_path(vm : BVM*) : Void
  fun be_module_path_set(vm : BVM*, path : UInt8*) : Void

  # /* bytes operations */
  fun be_pushbytes(vm : BVM*, buf : UInt8*, len : LibC::SizeT) : Void*
  fun be_tobytes(vm : BVM*, index : LibC::Int, len : LibC::SizeT*) : Void*

  # /* debug APIs */
  fun be_sethook(vm : BVM*, mask : UInt8*) : Void
  fun be_setntvhook(vm : BVM*, hook : BNtvHook, data : Void*, mask : LibC::Int) : Void

  # /* basic character IO APIs */
  fun be_writebuffer(buffer : UInt8*, length : LibC::SizeT) : Void
  fun be_readstring(buffer : UInt8*, size : LibC::SizeT) : UInt8*
end
