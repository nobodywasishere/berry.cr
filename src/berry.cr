module Berry
  VERSION = "1.1.0"
end

require "./berry/uint24"
require "./berry/lib"
require "./berry/vm"
require "./berry/repl"

vm = Berry::VM.new
Berry::REPL.run(vm)
