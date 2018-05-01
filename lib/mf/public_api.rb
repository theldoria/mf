module Mf
  module PublicApi
    # Handle most operators
    def method_missing(cmd, *args)
      eigenclass = class << self; self; end
      cmd_sym = cmd.to_sym
      eigenclass.class_eval do
        define_method(cmd_sym) do |b|
          proc { |a| a.send(cmd_sym, b) }
        end
      end
      send(cmd, *args)
    end

    # Comparators
    def >(b)
      proc { |a| a > b  }
    end

    def >=(b)
      proc { |a| a >= b }
    end

    def <(b)
      proc { |a| a < b  }
    end

    def <=(b)
      proc { |a| a <= b }
    end

    def <=>(b)
      proc { |a| a <=> b }
    end

    def ==(b)
      proc { |a| a == b  }
    end

    # Triple Equals black magic for pre-2.6

    def ===(b)
      proc { |a| b === a }
    end
  end
end
