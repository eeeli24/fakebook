require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    create(:user, email: 'mail@example.com')
    user = build(:user, email: 'mail@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
