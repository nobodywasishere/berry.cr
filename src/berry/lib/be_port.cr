lib LibBerry
  alias WriteBufferIO = Void*
  alias ReadStringIO = Void*

  alias WriteBufferCallback = Proc(UInt8*, LibC::SizeT, Void*, Void)
  alias ReadStringCallback = Proc(UInt8*, LibC::SizeT, Void*, UInt8*)

  fun be_writebuffer_callback_register(callback : WriteBufferCallback, io : WriteBufferIO) : Void
  fun be_readstring_callback_register(callback : ReadStringCallback, io : ReadStringIO) : UInt8*
end
