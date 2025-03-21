require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:valid_attributes) { { fullname: 'John Doe', orcid: '0000-0000-0000-0000' } }
  let(:invalid_attributes) { { fullname: '', orcid: '' } }
  let(:author) { Author.create!(valid_attributes) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all authors to @authors' do
      author
      get :index
      expect(assigns(:authors)).to eq([author])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new author to @author' do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new author' do
        expect do
          post :create, params: { author: valid_attributes }
        end.to change(Author, :count).by(1)
      end

      it 'redirects to the created author' do
        post :create, params: { author: valid_attributes }
        expect(response).to redirect_to(author_path(Author.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new author' do
        expect do
          post :create, params: { author: invalid_attributes }
        end.not_to change(Author, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post :create, params: { author: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: author.id }
      expect(response).to be_successful
    end

    it 'assigns the requested author to @author' do
      get :show, params: { id: author.id }
      expect(assigns(:author)).to eq(author)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: author.id }
      expect(response).to be_successful
    end

    it 'assigns the requested author to @author' do
      get :edit, params: { id: author.id }
      expect(assigns(:author)).to eq(author)
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { fullname: 'Jane Doe', orcid: '0000-0000-0000-0001' } }

      it 'updates the requested author' do
        put :update, params: { id: author.id, author: new_attributes }
        author.reload
        expect(author.fullname).to eq('Jane Doe')
        expect(author.orcid).to eq('0000-0000-0000-0001')
      end

      it 'redirects to the author' do
        put :update, params: { id: author.id, author: new_attributes }
        expect(response).to redirect_to(author_path(author))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the author' do
        put :update, params: { id: author.id, author: invalid_attributes }
        author.reload
        expect(author.fullname).not_to eq('')
      end

      it 'renders the edit template with unprocessable_entity status' do
        put :update, params: { id: author.id, author: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested author' do
      author
      expect do
        delete :destroy, params: { id: author.id }
      end.to change(Author, :count).by(-1)
    end

    it 'redirects to the authors list' do
      delete :destroy, params: { id: author.id }
      expect(response).to redirect_to(authors_path)
    end
  end
end
