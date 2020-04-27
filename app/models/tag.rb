class Tag < ActiveRecord::Base
  has_many :tag_connections, dependent: :delete_all
  has_many :transactions, through: :tag_connections, source: :subject, source_type: 'Transaction'
  has_many :ledgers, through: :tag_connections, source: :subject, source_type: 'Ledger'

  validates :name, presence: true
  validates_uniqueness_of :name
end
