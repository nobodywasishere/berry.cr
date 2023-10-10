class Berry::REPL
  def self.run(vm : VM)
    get_line = ->(prompt : UInt8*) : UInt8* {
      print String.new(prompt)
      input = gets
      if input.nil?
        puts
        exit
      end
      input.to_unsafe
    }

    # Don't need to free the line as it's generated by Crystal,
    # the GC will collect it
    free_line = ->(_line : UInt8*) {}

    LibBerry.be_repl(vm.to_unsafe, get_line, free_line)
  end
end
