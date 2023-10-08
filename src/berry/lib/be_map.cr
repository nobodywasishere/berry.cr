lib LibBerry
  struct BMapKey
    v : BValData
    type : UInt8
    nxt : UInt32
  end

  struct BMapNode
    key : BMapKey
    value : BValue
  end

  alias BMapIter = BMapNode*

  struct BMap
    nxt : BGCObject*
    type : BByte
    marked : BByte

    gray : BGCObject*
    slots : BMapNode*
    lastfree : BMapNode*
    size : LibC::Int
    count : LibC::Int
  end

  fun be_map_new(vm : BVM*) : BMap*
  fun be_map_delete(vm : BVM*, map : BMap*) : Void
  fun be_map_find(vm : BVM*, map : BMap*, key : BValue*) : BValue*
  fun be_map_insert(vm : BVM*, map : BMap*, key : BValue*, value : BValue*) : BValue*
  fun be_map_remove(vm : BVM*, map : BMap*, key : BValue*) : LibC::Int
  fun be_map_findstr(vm : BVM*, map : BMap*, key : BString*) : BValue*
  fun be_map_insertstr(vm : BVM*, map : BMap*, key : BString*, value : BValue*) : BValue*
  fun be_map_removestr(vm : BVM*, map : BMap*, key : BString*) : Void
  fun be_map_next(map : BMap*, iter : BMapIter*) : BMapNode*
  fun be_map_val2node(value : BValue*) : BMapNode*
  fun be_map_compact(vm : BVM*, map : BMap*) : Void
end
