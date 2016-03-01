class Synonym < ActiveRecord::Base
  acts_as_synonymable
  #include Synonymable::Synonymable
end
