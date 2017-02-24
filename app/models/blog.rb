class Blog < ActiveRecord::Base
    validates :title, presence: true

    belongs_to :user

    def title_and_content
      [title, content].join(" ")
    end
end
