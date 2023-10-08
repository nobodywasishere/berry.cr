lib LibBerry
  alias BReadLine = Proc(UInt8*, UInt8*)
  alias BFreeLine = Proc(UInt8*, Void)

  fun be_repl(vm : BVM*, getline : BReadLine, freeline : BFreeLine) : LibC::Int
end
