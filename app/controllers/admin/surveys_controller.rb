module Admin
  class SurveysController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_survey, only: %i[show edit update destroy]
    before_action :check_active_survey, only: %i[edit update]

    def index
      @state = sanitated_state(params[:state]) || 'active'
      @surveys = @state == 'inactive' ? Survey.inactive : Survey.active
    end

    def show
      @answers = Answer.joins(:survey)
                       .joins('INNER JOIN users ON surveys.author_id = users.id')
                       .left_outer_joins(:author_answers)
                       .select(
                         <<-SQL
                            answers.id AS answer_id,
                            answers.content AS answer_content,
                            COUNT(author_answers.id) AS votes,
                            surveys.id AS survey_id,
                            surveys.content AS survey_content,
                            SUM(COUNT(author_answers.id)) OVER (PARTITION BY surveys.id) AS total_votes
                         SQL
                       )
                       .where(surveys: { id: params[:id] })
                       .group('answers.id, surveys.id')
                       .order(votes: :desc, answer_id: :asc)
    end

    def new
      @survey = Survey.new
      @survey.answers.build
    end

    def create
      @survey = Survey.new(survey_params)
      @survey.author = current_user
      if @survey.save
        redirect_to admin_survey_path(@survey), notice: 'Survey was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @survey.update(survey_params)
        redirect_to admin_surveys_path
      else
        render :edit
      end
    end

    def destroy
      @survey.destroy
      redirect_to request.referer
    end

    private

    def check_active_survey
      redirect_to admin_surveys_path, alert: 'Cannot edit an inactive survey.' unless @survey.active?
    end

    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:content, :end_date, answers_attributes: %i[id content _destroy])
    end

    def sanitated_state(state)
      state.in?(%w[active inactive]) && state
    end

    def authorize_admin!
      redirect_to root_path, alert: 'Access Denied!' unless current_user.admin?
    end
  end
end
