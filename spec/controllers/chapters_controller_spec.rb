require 'rails_helper'

RSpec.describe ChaptersController, type: :controller do
  let(:author) { create(:author) }
  let(:valid_attributes) do
    {
      orig_name: 'Название главы',
      eng_name: 'Chapter Title',
      publish_date: Date.today,
      publisher: 'Издательство',
      isbn: '978-3-16-148410-0',
      pages: 100,
      author_ids: [author.id]
    }
  end

  let(:invalid_attributes) do
    {
      orig_name: '',
      eng_name: '',
      publish_date: nil,
      publisher: nil,
      isbn: 'invalid-isbn',
      pages: -5
    }
  end

  let(:chapter) { create(:chapter, authors: [author]) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all chapters to @chapters' do
      chapter
      get :index
      expect(assigns(:chapters)).to eq([chapter])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new chapter and authors' do
      get :new
      expect(assigns(:chapter)).to be_a_new(Chapter)
      expect(assigns(:authors)).to eq(Author.all)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new chapter' do
        expect do
          post :create, params: { chapter: valid_attributes }
        end.to change(Chapter, :count).by(1)
      end

      it 'redirects to the created chapter' do
        post :create, params: { chapter: valid_attributes }
        expect(response).to redirect_to(chapter_path(Chapter.last))
      end
    end

    context 'with invalid params' do
      it 'does not create a new chapter' do
        expect do
          post :create, params: { chapter: invalid_attributes }
        end.not_to change(Chapter, :count)
      end

      it 'renders new template' do
        post :create, params: { chapter: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end

      it 'assigns authors' do
        post :create, params: { chapter: invalid_attributes }
        expect(assigns(:authors)).to eq(Author.all)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: chapter.id }
      expect(response).to be_successful
    end

    it 'assigns the requested chapter' do
      get :show, params: { id: chapter.id }
      expect(assigns(:chapter)).to eq(chapter)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: chapter.id }
      expect(response).to be_successful
    end

    it 'assigns the requested chapter and authors' do
      get :edit, params: { id: chapter.id }
      expect(assigns(:chapter)).to eq(chapter)
      expect(assigns(:authors)).to eq(Author.all)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { orig_name: 'Обновленное название' } }

      it 'updates the chapter' do
        put :update, params: { id: chapter.id, chapter: new_attributes }
        chapter.reload
        expect(chapter.orig_name).to eq('Обновленное название')
      end

      it 'redirects to the chapter' do
        put :update, params: { id: chapter.id, chapter: new_attributes }
        expect(response).to redirect_to(chapter)
      end
    end

    context 'with invalid params' do
      it 'does not update the chapter' do
        put :update, params: { id: chapter.id, chapter: invalid_attributes }
        chapter.reload
        expect(chapter.orig_name).not_to be_empty
      end

      it 'renders edit template' do
        put :update, params: { id: chapter.id, chapter: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the chapter' do
      chapter
      expect do
        delete :destroy, params: { id: chapter.id }
      end.to change(Chapter, :count).by(-1)
    end

    it 'redirects to chapters list' do
      delete :destroy, params: { id: chapter.id }
      expect(response).to redirect_to(chapters_path)
    end
  end
end
