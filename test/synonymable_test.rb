require 'test_helper'

class SynonymableTest < ActiveSupport::TestCase

  def test_that_it_has_a_version_number
    refute_nil ::Synonymable::VERSION
  end

  def test_include_synonymable
    assert Synonym.include? ::Synonymable::Synonymable
    assert !Article.include?(::Synonymable::Synonymable)
  end

  def test_load_master_synonym
    assert !Synonym.try(:master).blank?
    assert Article.try(:master).blank?
  end

  def test_load_non_master_synonyms
    assert !Synonym.try(:not_master).blank?
    assert Article.try(:not_master).blank?
  end

  def test_master_synonyms
    synonym = synonyms(:presente)
    assert synonym.master == synonyms(:regalo)
  end

  def test_has_many_synonyms
    synonym = synonyms(:regalo)
    assert synonym.synonyms.count > 0
  end

end
