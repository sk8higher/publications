require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:author) { create(:author) }
  let(:journal) { create(:journal) }
  let(:valid_attributes) do
    {
      orig_name: 'Название статьи',
      eng_name: 'Article Title',
      publish_date: Date.today,
      doi: '10.1234/5678',
      journal_id: journal.id,
      author_ids: [author.id]
    }
  end
  let(:invalid_attributes) do
    {
      orig_name: '',
      eng_name: '',
      publish_date: nil,
      journal_id: nil
    }
  end
  let(:article) { create(:article, journal: journal, authors: [author]) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all articles to @articles' do
      article
      get :index
      expect(assigns(:articles)).to eq([article])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns new article and collections' do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
      expect(assigns(:authors)).to eq(Author.all)
      expect(assigns(:journals)).to eq(Journal.all)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates new article' do
        expect do
          post :create, params: { article: valid_attributes }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to created article' do
        post :create, params: { article: valid_attributes }
        expect(response).to redirect_to(article_path(Article.last))
      end
    end

    context 'with invalid params' do
      it 'does not create article' do
        expect do
          post :create, params: { article: invalid_attributes }
        end.not_to change(Article, :count)
      end

      it 'renders new template' do
        post :create, params: { article: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end

      it 'assigns collections' do
        post :create, params: { article: invalid_attributes }
        expect(assigns(:authors)).to eq(Author.all)
        expect(assigns(:journals)).to eq(Journal.all)
      end
    end
  end

  describe 'GET #show' do
    it 'returns successful response' do
      get :show, params: { id: article.id }
      expect(response).to be_successful
    end

    it 'assigns article and journal' do
      get :show, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
      expect(assigns(:journal)).to eq(journal)
    end
  end

  describe 'GET #edit' do
    it 'returns successful response' do
      get :edit, params: { id: article.id }
      expect(response).to be_successful
    end

    it 'assigns article and collections' do
      get :edit, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
      expect(assigns(:authors)).to eq(Author.all)
      expect(assigns(:journals)).to eq(Journal.all)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { orig_name: 'Новое название' } }

      it 'updates article' do
        put :update, params: { id: article.id, article: new_attributes }
        article.reload
        expect(article.orig_name).to eq('Новое название')
      end

      it 'redirects to article' do
        put :update, params: { id: article.id, article: new_attributes }
        expect(response).to redirect_to(article)
      end
    end

    context 'with invalid params' do
      it 'does not update article' do
        put :update, params: { id: article.id, article: invalid_attributes }
        article.reload
        expect(article.orig_name).not_to be_empty
      end

      it 'renders edit template' do
        put :update, params: { id: article.id, article: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end

      it 'assigns collections' do
        put :update, params: { id: article.id, article: invalid_attributes }
        expect(assigns(:authors)).to eq(Author.all)
        expect(assigns(:journals)).to eq(Journal.all)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys article' do
      article
      expect do
        delete :destroy, params: { id: article.id }
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to articles list' do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(articles_path)
    end
  end
end
