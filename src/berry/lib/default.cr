lib LibBerry
  struct ArgOpts
    idx : LibC::Int
    pattern : UInt8*
    optarg : UInt8*
    errarg : UInt8*
    src : UInt8*
    dst : UInt8*
  end

  fun berry_paths(vm : BVM*) : Void
  fun analysis_args(vm : BVM*, argc : LibC::Int, argv : UInt8*) : LibC::Int
  fun test_method : LibC::Int
end
