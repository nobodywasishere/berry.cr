describe Berry::VM do
  it "executes code" do
    stdout = IO::Memory.new

    vm = Berry::VM.new(stdout: stdout)

    vm.exec(<<-BERRY).should eq(0)
      var list = [ "Hello", "World" ]
      for text : list
          print(text)
      end
      return "hello"
    BERRY

    stdout.to_s.should eq("Hello\nWorld\n")
  end

  it "calculates pi" do
    stdout = IO::Memory.new

    vm = Berry::VM.new(stdout: stdout)

    vm.exec(<<-BERRY).should eq(0)
      def cpi(n)
        i = 2
        pi = 3
        while i <= n
          term = 4.0 / (i * (i + 1) * (i + 2))
          if i % 4
            pi = pi + term
          else
            pi = pi - term
          end
          i = i + 2
        end
        return pi
      end

      print("pi =", cpi(100))
    BERRY

    stdout.to_s.should eq("pi = 3.14159\n")
  end

  it "can register foreign functions" do
    stdout = IO::Memory.new
    vm = Berry::VM.new(stdout: stdout)

    vm.register_function "add" do |vm|
      if LibBerry.be_isint(vm, 1) && LibBerry.be_isint(vm, 2)
        a = LibBerry.be_toint(vm, 1)
        b = LibBerry.be_toint(vm, 2)
        LibBerry.be_pushint(vm, a + b)
      elsif LibBerry.be_isnumber(vm, 1) && LibBerry.be_isnumber(vm, 2)
        a = LibBerry.be_toreal(vm, 1)
        b = LibBerry.be_toreal(vm, 2)
        LibBerry.be_pushreal(vm, a + b)
      else
        LibBerry.be_pushnil(vm)
      end
      LibBerry.be_returnvalue(vm)
    end

    vm.exec(<<-BERRY).should eq(0)
      print(add(1, 1))
      print(add(2.5, 3.4))
      print(add(1.1, 1.0))
    BERRY

    stdout.to_s.should eq("2\n5.9\n2.1\n")
  end

  it "can exec multiple times on the same vm" do
    stdout = IO::Memory.new
    vm = Berry::VM.new(stdout: stdout)

    vm.exec(<<-BERRY).should eq(0)
    print("hello")
    BERRY

    vm.exec(<<-BERRY).should eq(0)
    print("world")
    BERRY

    vm.exec(<<-BERRY).should eq(0)
    print("!")
    BERRY

    stdout.to_s.should eq("hello\nworld\n!\n")
  end

  it "returns non-zero on an exception" do
    vm = Berry::VM.new

    # lexer error
    vm.exec(<<-BERRY).should eq(3)
    ``
    BERRY

    # runtime error
    vm.exec(<<-BERRY).should eq(3)
    "1" + 1
    BERRY
  end

  it "is still useful after error" do
    stdout = IO::Memory.new
    vm = Berry::VM.new(stdout: stdout)

    vm.exec("'1' + 1").should eq(3)
    vm.exec("print(1 + 1)").should eq(0)
    stdout.to_s.should eq("2\n")
  end
end
