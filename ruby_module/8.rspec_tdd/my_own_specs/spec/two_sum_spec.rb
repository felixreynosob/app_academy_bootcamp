require 'two_sum'

describe '#two_sum' do
    it "returns an array with the indexes of the pair of elements in given array that sum up given target. If no pair is found returns nil." do
        expect(two_sum([2, 7, 11, 15], 9)).to eq ([0,1])
    end
end
