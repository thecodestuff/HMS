require 'rails_helper'
require 'factories/user2'

RSpec.describe Admin::UsersController, type: :controller do
  login_admin

  let!(:user) { FactoryBot.create(:valid_user) }

  it 'should have a current user' do
    expect(subject.current_user).to_not eq(nil)
  end

  it 'should get index' do
    get 'index'
    expect(response.status).to eq(200)
    expect(response).to render_template('index')
  end

  it 'should create new user' do
    get 'new'
    expect(response).to render_template('new')
  end

  context 'user created' do
    let!(:user) { FactoryBot.create :valid_user }

    it 'should creates a new user' do
      expect{
        User.create(FactoryBot.attributes_for(:valid_user) )
      }.to change(User, :count).by(1)
    end

    it 'should not create a new user when supplied invalid attr' do
      expect{
        User.create(FactoryBot.attributes_for(:invalid_user))
      }.to change(User, :count).by(0)
    end

    it 'should redirect to users new if user not created' do
      post :create, params: { user: FactoryBot.attributes_for(:invalid_user)}
      expect(response).to render_template('new')
      #expect(response.status).to eq(302)
    end
  end

  # describe 'Put #update/:id' do
  #   @user = FactoryBot.create(:valid_user)
  #   @user.reload
  #   it 'update user with valid attributes' do
  #     post :update, params: { user: {firstname:"foo"} }
  #     expect(user.firstname).to eql('foo')
  #   end
  # end

  describe "PUT update" do
    let(:attr) do
      { firstname: 'johnsnow' }
    end

    before(:each) do
      put :update, params: {:id => user.id, :user => attr[:firstname].permit}
      user.reload
    end

    it { 
      user.firstname.should eql(attr[:firstname]) 
    }
  end

end