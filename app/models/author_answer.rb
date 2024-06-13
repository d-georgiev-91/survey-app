class AuthorAnswer < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :answer, class_name: 'Answer'
end
