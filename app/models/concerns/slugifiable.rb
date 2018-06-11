module Slugifiable

  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def self.find_by_slug(slugified_name)
      self.all.detect{|user| user.slug == slugified_name}
    end
  end

  module InstanceMethods
    def slug
      if self.username.include?(" ")
        self.username.downcase.gsub(" ", "-")
      else
        self.username.downcase
      end
    end
  end

end
