require 'test_helper'

describe SimpleGroup::Group do
  it "should not added group function" do
    expect(User).wont_be :added_group_function?
  end

  it "should added group function" do
    expect(MyGroup).must_be :added_group_function?
  end

  describe "grouping to my_group" do
    include_context_prepare_data do
      subject { my_group }

      it 'should add a orange in Favorites group' do
        expect(subject.add(orange)).must_equal true
      end

      it 'should add a dog in Favorites group' do
        expect(subject.add(dog)).must_equal true
      end

      it 'should not add a sunflower in Favorites group' do
        assert_raises(SimpleGroup::GroupNotAllowError) do
          subject.add(sunflower)
        end
      end

      describe 'already add a dog in Favorites group' do
        before do
          subject.add(dog)
        end

        it 'should include in Favorites group' do
          expect(subject.include?(dog)).must_equal true
        end

        it 'should not exclude in Favorites group' do
          expect(subject.exclude?(dog)).must_equal false
        end

        it 'should remove a dog in Favorites group' do
          expect(subject.remove(dog)).must_be :destroyed?
        end

        it 'should not add a dog in Favorites group' do
          expect(subject.add(dog)).must_equal false
        end
      end

      describe 'already add animals and fruits in Favorites group' do
        before do
          [dog, cat, pig, orange, apple, grape].each do |item|
            subject.add(item)
          end
        end

        it 'should filter by Class' do
          expect(subject.count).must_equal 6
          expect(subject.for_type(Animal).count).must_equal 3
          expect(subject.for_type(Fruit).count).must_equal 3
        end

        it 'should filter by ClassName' do
          expect(subject.count).must_equal 6
          expect(subject.for_type(Animal.name).count).must_equal 3
          expect(subject.for_type(Fruit.name).count).must_equal 3
        end
      end
    end
  end

  describe 'when create group' do
    include_context_prepare_data do
      subject { MyGroup.new(name: 'New Group', user: user) }

      it 'should save with combinations' do
        subject.combinations.build(group_item: orange)
        subject.combinations.build(group_item: dog)
        expect(subject).must_be :valid?
        expect(subject.save).must_equal true
      end
    end
  end
end
