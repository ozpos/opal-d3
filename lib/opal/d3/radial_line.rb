module D3
  class RadialLineGenerator
    def initialize(native)
      raise unless native
      @native = native
    end

    def call(*args)
      result = @native.call(*args)
      `result === null ? nil : result`
    end

    attribute_d3_block :angle
    attribute_d3_block :radius
  end

  class << self
    def radial_line
      D3::RadialLineGenerator.new @d3.JS.radialLine
    end
  end
end