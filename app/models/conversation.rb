class Conversation < ActiveRecord::Base
	belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
	belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

	has_many :messages, dependent: :destroy

	validates_uniqueness_of :sender_id, scope: :recipient_id

	scope :involving, -> (user) do
		where("conversations.sender_id = ? OR conversations.recipient_id = ?", user.id, user.id)
	end

	scope :between, -> (sender_id, recipient_id) do
		where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)",
					sender_id, recipient_id, recipient_id, sender_id)
	end
SQL = <<-EOSQL
SELECT conversations.id
FROM messages INNER JOIN conversations
ON messages.conversation_id = conversations.id
WHERE conversations.sender_id = :id OR conversations.recipient_id = :id
GROUP BY conversations.id
EOSQL



    def self.for_user(user)
      conversation_ids = Conversation.find_by_sql([SQL, id: user.id]).map{|x| x.id }
      Conversation.where(id: conversation_ids)
    end


end
