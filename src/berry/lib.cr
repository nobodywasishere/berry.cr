@[Link(ldflags: "#{__DIR__}/../ext/berry.a -lm")]
lib LibBerry
end

require "./lib/berry"
require "./lib/default"
require "./lib/be_class"
require "./lib/be_exec"
require "./lib/be_list"
require "./lib/be_map"
require "./lib/be_mem"
require "./lib/be_module"
require "./lib/be_object"
require "./lib/be_repl"
require "./lib/be_vm"
