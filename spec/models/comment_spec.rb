require 'rails_helper'

RSpec.describe Comment, type: :model do

  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without body' do
    comment = build(:comment, body: nil)
    comment.valid?
    expect(comment.errors[:body]).to include("can't be blank")
  end
end
