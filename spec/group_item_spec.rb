require 'spec_helper'

module SimpleGroup
  describe GroupItem, type: :model do
    it "should not be a groupable" do
      expect(Flower).not_to be_groupable
    end

    it "should be a groupable" do
      expect(Animal).to be_groupable
      expect(Fruit).to be_groupable
    end

    describe "grouping to my_group" do
      include_context 'prepare_data'
      subject { apple }

      it 'should add a apple in Favorites group' do
        expect(subject.add_to_group(my_group)).to be_truthy
      end

      it 'should not add a tulip in Favorites group' do
        expect {
          tulip.add_to_group(my_group)
        }.to raise_error NoMethodError
      end
    end
  end
end