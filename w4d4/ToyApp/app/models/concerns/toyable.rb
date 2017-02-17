module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys, as: :toyable
  end

  def receive_toy(name)
    toy = self.class.find_or_create_by(name: name)
    self.toys = self.toys + toy
  end
end
