require 'spec_helper'

RSpec.describe SimpleGroup::Group, type: :model do
  it "should not added group function" do
    expect(User).not_to be_added_group_function
  end

  it "should added group function" do
    expect(MyGroup).to be_added_group_function
  end

  describe "grouping to my_group" do
    include_context 'prepare_data'
    subject { my_group }

    it 'should add a orange in Favorites group' do
      expect(subject.add(orange)).to be_truthy
    end

    it 'should add a dog in Favorites group' do
      expect(subject.add(dog)).to be_truthy
    end

    it 'should not add a sunflower in Favorites group' do
      expect {
        subject.add(sunflower)
      }.to raise_error SimpleGroup::GroupNotAllowError
    end

    context 'already add a dog in Favorites group' do
      before do
        subject.add(dog)
      end

      it 'should include in Favorites group' do
        expect(subject.include?(dog)).to be_truthy
      end

      it 'should not exclude in Favorites group' do
        expect(subject.exclude?(dog)).to be_falsey
      end

      it 'should remove a dog in Favorites group' do
        expect(subject.remove(dog)).to be_truthy
      end

      it 'should not add a dog in Favorites group' do
        expect(subject.add(dog)).to be_falsey
      end
    end

    context 'already add animals and fruits in Favorites group' do
      before do
        [dog, cat, pig, orange, apple, grape].each do |item|
          subject.add(item)
        end
      end

      it 'should filter by Class' do
        expect(subject.count).to eq 6
        expect(subject.for_type(Animal).count).to eq 3
        expect(subject.for_type(Fruit).count).to eq 3
      end

      it 'should filter by ClassName' do
        expect(subject.count).to eq 6
        expect(subject.for_type(Animal.name).count).to eq 3
        expect(subject.for_type(Fruit.name).count).to eq 3
      end
    end
  end

  describe 'when create group' do
    include_context 'prepare_data'
    subject { MyGroup.new(name: 'New Group', user: user) }

    it 'should save with combinations' do
      subject.combinations.build(group_item: orange)
      subject.combinations.build(group_item: dog)
      expect(subject).to be_valid
      expect(subject.save).to be_truthy
    end
  end
end
