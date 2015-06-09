module Linkscape
  class CurrentIndexData
    attr_reader :index, :sub_index, :locked

    def self.parse(data)
      new(data)
    end

    def initialize(data)
      indexs, lock = data.split(' ')
      @index, @sub_index = indexs.split('-').map {|x| x.to_i}
      @locked = (lock == "(L)")
    end
  end
end
