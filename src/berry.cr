module Berry
  VERSION = "1.1.0"
end

require "./berry/uint24"
require "./berry/lib"

puts LibBerry.test_method
vm = LibBerry.be_vm_new

LibBerry.be_vm_delete(vm)
