class SupportRequest < ApplicationRecord
  # Despite the good arguments in
  # https://flatironschool.com/blog/why-you-dont-need-has-and-belongs-to-many
  # This association is sufficient for this simple project.
  has_and_belongs_to_many :orders

  has_rich_text :response
end
