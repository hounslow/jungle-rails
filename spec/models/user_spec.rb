require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    context "with the same password" do
      it 'should have no errors' do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")
        @user.save
        @user.valid?
        expect(@user.errors.full_messages).not_to include('Password confirmation doesn\'t match Password')
      end
    end

    context "with different passwords" do
      it 'should give a matching error' do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "pass")
        @user.save
        @user.valid?
        expect(@user.errors.full_messages).to include('Password confirmation doesn\'t match Password')
      end
    end

    context "with no password" do
      it 'should give a can\'t be blank error ' do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        )
        @user.save
        @user.valid?
        expect(@user.errors.full_messages).to include('Password can\'t be blank')
      end
    end

    context "with no first name" do
      it 'should give a can\'t be blank error ' do
        @user = User.new(
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password"
        )
        @user.valid?
        expect(@user.errors.full_messages).to include('First name can\'t be blank')
      end
    end

    context "with no last_name" do
      it 'should give a can\'t be blank error ' do
        @user = User.new(
        first_name: "Matt",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password"
        )
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name can\'t be blank')
      end
    end

    context "with no email" do
      it 'should give a can\'t be blank error ' do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        password: "password",
        password_confirmation: "password"
        )
        @user.valid?
        expect(@user.errors.full_messages).to include('Email can\'t be blank')
      end
    end

    context "two of the same case sensitive emails" do
      it "should return an error" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")

        @user_two = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "HI@GMAIL.COM",
        password: "password",
        password_confirmation: "password")
        @user.save

        @user_two.valid?
        expect(@user_two.errors.full_messages).to include('Email has already been taken')
      end
    end

    context "password with less than 6 characters" do
      it 'should give a can\'t be blank error ' do
        @user = User.new(
        first_name: "Matt",
        email: "hi@gmail.com",
        password: "pass",
        password_confirmation: "pass"
        )
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context "input the wrong password" do
      it "should return false" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")
        @user.save!
        expect(User.authenticate_with_credentials(@user.email, "pass")).to be(false)
      end
    end

    context "input an incorrect email" do
      it "should return false" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")
        @user.save!
        expect(User.authenticate_with_credentials("hihi@gmail.com", @user.password)).not_to eq(@user)
        expect(User.authenticate_with_credentials("hihi@gmail.com", @user.password)).to eq(nil)
      end
    end

    context "input the correct email and password" do
      it "should return the user" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")
        @user.save!
        expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
      end
    end

    context "input the correct email (with leading and trailing spaces) and password" do
      it "should return the user" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "hi@gmail.com",
        password: "password",
        password_confirmation: "password")
        @user.save!
        expect(User.authenticate_with_credentials("  #{@user.email}   ", @user.password)).to eq(@user)
      end
    end

    context "input a case different email and the correct password" do
      it "should return the user" do
        @user = User.new(
        first_name: "Matt",
        last_name: "H",
        email: "HI@GMAil.com",
        password: "password",
        password_confirmation: "password")
        @user.save!
        expect(User.authenticate_with_credentials(@user.email.upcase, @user.password)).to eq(@user)
      end
    end
  end
end
