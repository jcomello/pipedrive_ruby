require 'spec_helper'

describe 'Organizations', :vcr=> true do

  let(:valid_new_org) {{:name => "New Company"}}
  let(:invalid_new_org) {{}}
  let(:not_found_org) {{"id" => 0}}

  before(:all) do
    @organizations = Organizations.new(ENV["API_TOKEN"])
    @organizations_response =[]
    2.times do |number|
      @organizations_response << @organizations.create({:name => "#{number} - New Company"})
    end
    all = @organizations.all
    @organization = all["data"].first
    @another_organization = all["data"].last
  end

  after(:all) do
    # delete what left from test on sandbox
  end

  describe '#all' do
    context 'when success' do
      it 'returns a list of organizations' do
        response = @organizations.all
        expect(response["success"]).to be_truthy
        expect(response["data"]).to respond_to(:each)
      end
    end
  end #end of all

  describe '#find' do
    context 'when success' do
      it 'returns success true' do
        response = @organizations.find(@organization["id"])
        expect(response["success"]).to be_truthy
      end
    end
    context 'when fails' do
      it 'return success false' do
        response = @organizations.find(not_found_org["id"])
        expect(response["success"]).to be_falsey
      end
    end
  end #end of find

  describe '#create' do
    context 'when success' do
      it 'return success true' do
        response = @organizations.create(valid_new_org)
        expect(response["success"]).to be_truthy
      end
      it 'return Hash with name inside data' do
        response = @organizations.create(valid_new_org)
        expect(response["data"]["name"]).to be == valid_new_org[:name]
      end
    end

    context 'when fails' do
      it 'return success false' do
        response = @organizations.create(invalid_new_org)
        expect(response["success"]).to be_falsey
      end
    end
  end #end of create


end #end of Deals Resource