require 'rails_helper'

RSpec.describe JournalsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Journal of Science',
      issn: '1234-5678'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      issn: 'invalid'
    }
  end

  let(:journal) { create(:journal) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all journals to @journals' do
      journal
      get :index
      expect(assigns(:journals)).to eq([journal])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new journal' do
      get :new
      expect(assigns(:journal)).to be_a_new(Journal)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new journal' do
        expect do
          post :create, params: { journal: valid_attributes }
        end.to change(Journal, :count).by(1)
      end

      it 'redirects to the created journal' do
        post :create, params: { journal: valid_attributes }
        expect(response).to redirect_to(journal_path(Journal.last))
      end
    end

    context 'with invalid params' do
      it 'does not create a journal' do
        expect do
          post :create, params: { journal: invalid_attributes }
        end.not_to change(Journal, :count)
      end

      it 'renders new template' do
        post :create, params: { journal: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: journal.id }
      expect(response).to be_successful
    end

    it 'assigns the requested journal' do
      get :show, params: { id: journal.id }
      expect(assigns(:journal)).to eq(journal)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: journal.id }
      expect(response).to be_successful
    end

    it 'assigns the requested journal' do
      get :edit, params: { id: journal.id }
      expect(assigns(:journal)).to eq(journal)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Journal Name' } }

      it 'updates the journal' do
        put :update, params: { id: journal.id, journal: new_attributes }
        journal.reload
        expect(journal.name).to eq('Updated Journal Name')
      end

      it 'redirects to the journal' do
        put :update, params: { id: journal.id, journal: new_attributes }
        expect(response).to redirect_to(journal)
      end
    end

    context 'with invalid params' do
      it 'does not update the journal' do
        put :update, params: { id: journal.id, journal: invalid_attributes }
        journal.reload
        expect(journal.name).not_to be_empty
      end

      it 'renders edit template' do
        put :update, params: { id: journal.id, journal: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the journal' do
      journal
      expect do
        delete :destroy, params: { id: journal.id }
      end.to change(Journal, :count).by(-1)
    end

    it 'redirects to journals list' do
      delete :destroy, params: { id: journal.id }
      expect(response).to redirect_to(journals_path)
    end
  end
end
