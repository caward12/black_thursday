require_relative 'test_helper.rb'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_instance_of MerchantRepository, mr
  end

  def test_it_creates_new_instances_of_merchant
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_instance_of Merchant, mr.all.first
    assert_equal "Shopin1901", mr.all.first.name
  end

  def test_it_returns_all_instances_of_merchant
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_equal 4, mr.all.count
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_instance_of Merchant, mr.find_by_id("12334105")
    assert_equal "Shopin1901", mr.find_by_id("12334105").name
  end

  def test_it_returns_nil_if_it_does_not_find_id_number
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_nil mr.find_by_id("123341034")
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_instance_of Merchant, mr.find_by_name("Candisart")
    assert_equal "12334112", mr.find_by_name("Candisart").id
  end

  def test_it_knows_name_case_insensitive
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_equal "12334112", mr.find_by_name("candisart").id
  end

  def test_it_returns_nil_if_it_does_not_find_name
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_nil mr.find_by_name("target")
  end

  def test_it_can_find_all_by_name_fragment
    mr = MerchantRepository.new("./test/fixtures/temp_merchants.csv")

    assert_instance_of Merchant, mr.find_all_by_name("Candi").first
    assert_equal 2, mr.find_all_by_name("Candi").count
    assert_equal "12334112", mr.find_all_by_name("Candi").first.id
  end
end
