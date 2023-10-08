class Berry::VM
  private getter vm : LibBerry::BVM*

  def initialize
    @vm = LibBerry.be_vm_new
  end

  def finalize
    LibBerry.be_vm_delete(@vm)
  end

  def to_unsafe : LibBerry::BVM*
    vm
  end
end
