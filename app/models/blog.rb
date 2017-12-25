class Blog < ActiveRecord::Base
    validates :title, presence: true


    belongs_to :user
 # CommentモデルのAssociationを設定
    has_many :comments, dependent: :destroy

    def title_and_content
      [title, content].join(" ")
    end
end
