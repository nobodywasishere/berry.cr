lib LibBerry
  struct BList
    nxt : BGCObject*
    type : BByte
    marked : BByte

    gray : BGCObject*
    count : LibC::Int
    capacity : LibC::Int
    data : BValue*
  end

  fun be_list_new(vm : BVM*) : BList*
  fun be_list_delete(vm : BVM*, list : BList*) : Void
  fun be_list_copy(vm : BVM*, original : BList*) : BList*
  fun be_list_index(list : BList*, index : LibC::Int) : BValue*
  fun be_list_push(vm : BVM*, list : BList*, value : BValue*) : BValue*
  fun be_list_insert(vm : BVM*, list : BList*, index : LibC::Int, value : BValue*) : BValue*
  fun be_list_remove(vm : BVM*, list : BList*, index : LibC::Int) : LibC::Int
  fun be_list_resize(vm : BVM*, list : BList*, count : LibC::Int) : Void
  fun be_list_merge(vm : BVM*, list : BList*, other : BList*) : Void
  fun be_list_reverse(vm : BVM*) : Void
  fun be_list_pool_init(vm : BVM*, list : BList*) : Void
  fun be_list_pool_alloc(vm : BVM*, list : BList*, src : BValue*) : LibC::Int
  fun be_list_pool_free(list : BList*, id : LibC::Int) : Void
end
