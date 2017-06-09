require 'rails_helper'

describe Contact do


 
#名前があれば有効
  it "is valid with name" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

#メールアドレスがなければ無効
  it "is invalid without a email" do
    contact = Contact.new
    expect(contact).not_to be_valid
  end

#メールアドレスがあれば有効
  it "is valid with email" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end

  #内容がなければ無効
  it "is invalid without a contact" do
    contact = Contact.new
    expect(contact).not_to be_valid
  end

#内容があれば有効
  it "is valid with contact" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:contact]).to include("を入力してください")
  end
end
