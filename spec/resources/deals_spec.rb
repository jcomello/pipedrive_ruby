require 'spec_helper'

describe 'Deals', :vcr=> true do

  let(:valid_new_deal) {{:title => "Novo Negocio"} }
  let(:invalid_new_deal) {{}}
  let(:not_found_deal) {{"id" => 0}}

  before(:all) do
    @deals = Deals.new(ENV["API_TOKEN"])
    @deals_response =[]
    2.times do |number|
      @deals_response << @deals.create({:title => "#{number} -Novo Negocio"})
    end
    all = @deals.all
    @deal = all["data"][0]
  end

  describe '#create' do
    context 'when success' do
      it 'return success true' do
        response = @deals.create(valid_new_deal)
        expect(response["success"]).to be_truthy
      end
      it 'return Hash with title inside data' do
        response = @deals.create(valid_new_deal)
        expect(response["data"]["title"]).to be == valid_new_deal[:title]
      end
    end

    context 'when fails' do
      it 'return success false' do
        response = @deals.create(invalid_new_deal)
        expect(response["success"]).to be_falsey
      end
    end
  end #end of create method

  describe '#all' do
    context 'when success' do
      it 'returns a list of deals' do
        response = @deals.all
        expect(response["success"]).to be_truthy
        expect(response["data"]).to respond_to(:each)
      end
    end
  end #end of all method

  describe '#update' do
    context 'when success' do
      it 'returns success true' do
        updated_deal = {"id" => @deal["id"], "value"=> rand(1000)}
        response = @deals.update(updated_deal)
        expect(response["success"]).to be_truthy
      end
    end

    context 'when not found' do
      it 'returns success false' do
        response = @deals.update(not_found_deal)
        expect(response["success"]).to be_falsey
      end
    end
  end #end of create method

  describe '#delete' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.delete(@deal)
        expect(response["success"]).to be_truthy
      end
    end
    context 'when fails' do
      it 'returns success false' do
        response = @deals.delete(not_found_deal)
        expect(response["success"]).to be_falsey
      end
    end
  end #end of delete method

  describe '#delete_many' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.delete_many(@deals_response)
        expect(response["success"]).to be_truthy
      end
    end
  end #end of delete_many method

  describe '#activities' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.activities(@deal)
        expect(response["success"]).to be_truthy
      end
    end
    context 'when fails' do
      it 'return success false' do
        response = @deals.activities(not_found_deal)
        expect(response["success"]).to be_falsey
      end
    end
  end #end of activities method

  describe '#find' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.find(@deal["id"])
        expect(response["success"]).to be_truthy
      end
    end
    context 'when fails' do
      it 'return success false' do
        response = @deals.find(not_found_deal["id"])
        expect(response["success"]).to be_falsey
      end
    end
  end #end of find method

  describe '#find_by_title' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.find_by_title(@deal["title"])
        expect(response["success"]).to be_truthy
      end
    end
    context 'when not found' do
      it 'return data nil' do
        response = @deals.find_by_title("not exist")
        expect(response["data"]).to be_nil
      end
    end
  end #end of find_by_title method

  describe '#followers' do
    context 'when success' do
      it 'returns success true' do
        response = @deals.followers(@deal["id"])
        expect(response["success"]).to be_truthy
      end
    end
    context 'when not found' do
      it 'return data nil' do
        response = @deals.followers(not_found_deal["id"])
        expect(response["data"]).to be_nil
      end
    end
  end #end of followers method

  describe '#duplicate' do
    context 'when success' do
      it 'return success true' do
        response = @deals.duplicate(@deal)
        expect(response["success"]).to be_truthy
      end
    end
  end


end #end of Deals Resource