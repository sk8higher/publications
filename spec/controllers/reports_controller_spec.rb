require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:author) { create(:author) }
  let(:valid_attributes) do
    {
      orig_name: 'Доклад на конференции',
      eng_name: 'Conference Report',
      publish_date: Date.today,
      conference_name: 'Международный симпозиум',
      conference_location: 'Заграничная',
      speaker_id: author.id,
      author_ids: [author.id]
    }
  end

  let(:invalid_attributes) do
    {
      orig_name: '',
      eng_name: '',
      publish_date: nil,
      conference_name: nil,
      speaker_id: nil,
      author_ids: []
    }
  end

  let(:report) { create(:report, speaker: author, authors: [author]) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all reports to @reports' do
      report
      get :index
      expect(assigns(:reports)).to eq([report])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new report and authors' do
      get :new
      expect(assigns(:report)).to be_a_new(Report)
      expect(assigns(:authors)).to eq(Author.all)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new report' do
        expect do
          post :create, params: { report: valid_attributes }
        end.to change(Report, :count).by(1)
      end

      it 'redirects to the created report' do
        post :create, params: { report: valid_attributes }
        expect(response).to redirect_to(report_path(Report.last))
      end
    end

    context 'with invalid params' do
      it 'does not create a report' do
        expect do
          post :create, params: { report: invalid_attributes }
        end.not_to change(Report, :count)
      end

      it 'renders the new template' do
        post :create, params: { report: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end

      it 'assigns authors' do
        post :create, params: { report: invalid_attributes }
        expect(assigns(:authors)).to eq(Author.all)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: report.id }
      expect(response).to be_successful
    end

    it 'assigns the requested report and author' do
      get :show, params: { id: report.id }
      expect(assigns(:report)).to eq(report)
      expect(assigns(:author)).to eq(author)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: report.id }
      expect(response).to be_successful
    end

    it 'assigns the requested report and authors' do
      get :edit, params: { id: report.id }
      expect(assigns(:report)).to eq(report)
      expect(assigns(:authors)).to eq(Author.all)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          conference_location: 'Международная',
          author_ids: [author.id]
        }
      end

      it 'updates the report' do
        put :update, params: { id: report.id, report: new_attributes }
        report.reload
        expect(report.conference_location).to eq('Международная')
      end

      it 'redirects to the report' do
        put :update, params: { id: report.id, report: new_attributes }
        expect(response).to redirect_to(report)
      end
    end

    context 'with invalid params' do
      it 'does not update the report' do
        put :update, params: { id: report.id, report: invalid_attributes }
        report.reload
        expect(report.orig_name).not_to be_empty
      end

      it 'renders the edit template' do
        put :update, params: { id: report.id, report: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the report' do
      report
      expect do
        delete :destroy, params: { id: report.id }
      end.to change(Report, :count).by(-1)
    end

    it 'redirects to the reports list' do
      delete :destroy, params: { id: report.id }
      expect(response).to redirect_to(reports_path)
    end
  end
end
