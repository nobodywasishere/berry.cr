lib LibBerry
  alias Mem16 = StaticArray(UInt8, 16)
  alias Mem32 = StaticArray(UInt8, 32)

  struct GC16
    bitmap : UInt32
    nxt : GC16*
    lines : StaticArray(Mem16, 31)
  end

  struct GC32
    bitmap : UInt32
    nxt : GC32*
    lines : StaticArray(Mem32, 15)
  end

  fun be_os_malloc(size : LibC::SizeT) : Void*
  fun be_os_free(ptr : Void*) : Void
  fun be_os_realloc(ptr : Void*, size : LibC::SizeT) : Void*
  fun be_realloc(vm : BVM*, ptr : Void*, old_size : LibC::SizeT, new_size : LibC::SizeT) : Void*
  fun be_gc_memory_pools(vm : BVM*) : Void
  fun be_gc_free_memory_pools(vm : BVM*) : Void
  fun be_gc_init_memory_pools(vm : BVM*) : Void
  fun be_gc_memory_pools_info(vm : BVM*, slots_used : LibC::SizeT, slots_allocated : LibC::SizeT) : Void
  fun be_move_to_aligned(vm : BVM*, ptr : Void*, size : LibC::SizeT) : Void*
end
