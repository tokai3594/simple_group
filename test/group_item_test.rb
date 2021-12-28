require 'test_helper'

describe SimpleGroup::GroupItem do
  it "should not be a groupable" do
    expect(Flower).wont_be :groupable?
  end

  it "should be a groupable" do
    expect(Animal).must_be :groupable?
    expect(Fruit).must_be :groupable?
  end

  describe "grouping to my_group" do
    include_context_prepare_data do
      subject { apple }

      it 'should add a apple in Favorites group' do
        assert_instance_of(SimpleGroup::Combination, subject.add_to_group(my_group))
      end

      it 'should not add a tulip in Favorites group' do
        assert_raises(NoMethodError) do
          tulip.add_to_group(my_group)
        end
      end
    end
  end
end
