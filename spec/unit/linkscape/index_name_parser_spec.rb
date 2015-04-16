require 'spec_helper'
require 'linkscape/current_index_data'

module Linkscape
  describe CurrentIndexData do
    def set_index_data_expectation(index_data, index, sub_index, locked)
      expect(index_data.index).to eq(index)
      expect(index_data.sub_index).to eq(sub_index)
      expect(index_data.locked).to eq(locked)
    end

    it "loads an unlocked index properly" do
      index_data = CurrentIndexData.parse("72-1")
      set_index_data_expectation(index_data, 72, 1, false)
    end

    it "loads a locked index properly" do
      index_data = CurrentIndexData.parse("38-2 (locked)")
      set_index_data_expectation(index_data, 38, 2, true)
    end
  end
end
