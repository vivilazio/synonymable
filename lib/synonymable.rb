require "synonymable/version"
require 'active_support/concern'
require 'active_record'

module Synonymable
  class ActiveRecord::Base
    def self.acts_as_synonymable
      include Synonymable
    end
  end
  module Synonymable
    extend ActiveSupport::Concern

    included do
      has_many :synonyms, class_name: self.name, foreign_key: "master_#{self.name.downcase}_id"
      belongs_to :"master_#{self.name.downcase}", class_name: self.name


      scope :master, lambda {  where("#{self.name.pluralize.downcase}.master_#{self.name.downcase}_id": nil) }

      scope :not_master, lambda { where.not("#{self.name.pluralize.downcase}.master_#{self.name.downcase}_id": nil) }

      validate :master_is_different_from_id
      validate :master_must_exists
      def master
        self.method("master_#{self.class.name.downcase}").call || self
      end

      private
      def master_is_different_from_id
        master = self.method("master_#{self.class.name.downcase}_id").call
        if !master.blank? && self.id.to_i == master.to_i
          errors.add("master_#{self.class.name.downcase}_id", "non deve essere se stesso")
        end
      end

      def master_must_exists
        master = Kernel.const_get(self.class.name)
        master_id = self.method("master_#{self.class.name.downcase}_id").call
        if master_id && !master.find_by_id(master_id.to_i)
          errors.add("master_#{self.class.name.downcase}_id", "deve esistere")
        end
      end
    end
  end
  #require 'synonymable/railtie' #if defined?(Rails) && Rails::VERSION::MAJOR >= 4
end
