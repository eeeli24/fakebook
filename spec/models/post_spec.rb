require 'rails_helper'

RSpec.describe Post, type: :model do

  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end

  it 'is invalid without body' do
    post = build(:post, body: nil)
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end
end
