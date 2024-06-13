module Admin
  module SurveysHelper
    def vote_percentage(votes, total_votes)
      return (votes.to_f / total_votes * 100).round(2) unless total_votes.zero?

      total_votes
    end

    def two_decimal_float(float)
      format('%.2f', float)
    end
  end
end
