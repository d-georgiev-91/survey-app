class SurveysController < ApplicationController
  before_action :set_survey, only: %i[finished update]

  def index
    @state = sanitated_state(params[:state]) || 'active'
    @surveys = @state == 'inactive' ? Survey.inactive : Survey.active
  end

  def finished
    @answers = Answer.joins(:survey)
                     .joins('INNER JOIN users ON surveys.author_id = users.id')
                     .left_outer_joins(:author_answers)
                     .select(
                       <<-SQL
                         answers.content AS answer_content,
                         COUNT(author_answers.id) AS votes,
                         SUM(COUNT(author_answers.id)) OVER (PARTITION BY surveys.id) AS total_votes
                       SQL
                     )
                     .where(surveys: { id: params[:id] })
                     .group('answers.id, surveys.id')
                     .order(votes: :desc, answer_id: :asc)

    redirect_to surveys_path, alert: 'This survey is still active.' if @survey.active?
  end

  def edit
    survey_id = params[:id]
    @survey = Survey.includes(:answers).where(surveys: { id: survey_id }).first

    @user_votes = @survey.answers
                         .joins(:author_answers)
                         .where(author_answers: { author_id: current_user.id }).pluck(:id)
  end

  def update
    vote_params = params[:answer]

    unless @survey.active?
      redirect_to survey_path(@survey), alert: 'The survey is no longer active.'
      return
    end

    if vote_params.present?
      ActiveRecord::Base.transaction do
        AuthorAnswer.where(author: current_user, answer: @survey.answers).destroy_all
        AuthorAnswer.create!(author: current_user, answer_id: vote_params)
      end

      redirect_to edit_survey_path(@survey), notice: 'You have voted successfully.'
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_survey_path(@survey), alert: "There was an error recording your vote: #{e.message}"
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def sanitated_state(state)
    state.in?(%w[active inactive]) && state
  end
end
