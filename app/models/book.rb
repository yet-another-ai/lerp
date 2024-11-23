class Book < Resource
  validates :isbn, presence: true
end
