module Mf
  module PublicApi
    # Handle most operators
    def method_missing(cmd, *args)
      eigenclass = class << self; self; end
      eigenclass.class_eval do
        define_method(cmd) do |*b|
          proc { |a| a.send(cmd, *b) }
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
