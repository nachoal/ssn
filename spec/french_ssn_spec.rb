require_relative "../french_ssn"

describe "#french_ssn_info" do
  it "should detect an invalid ssn and return a string saying so" do
    result = french_ssn_info("")

    expect(result).to eq("The number is invalid")
  end

  it "should detect an invalid ssn and return a string saying so" do
    result = french_ssn_info("1 84 12 76 451 089 10")

    expect(result).to eq("The number is invalid")
  end

  it "should return a string containing the right info for the SSN" do
    result = french_ssn_info("1 84 12 76 451 089 46")

    expect(result).to eq("a man, born in December, 1984 in Seine-Maritime.")
  end

  it "should return a String" do
    result = french_ssn_info("1 84 12 76 451 089 46")

    expect(result).to be_a(String)
  end
end