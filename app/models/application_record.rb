class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true



  def separate
    if self.to_s.size > 20
      self.to_s[0..20]+'...'
    end
  end



end
