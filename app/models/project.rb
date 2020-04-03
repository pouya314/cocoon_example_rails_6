class Project < ApplicationRecord
  has_many :tasks, inverse_of: :project, dependent: :destroy
  has_many :members, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :members, reject_if: :all_blank, allow_destroy: true
end
