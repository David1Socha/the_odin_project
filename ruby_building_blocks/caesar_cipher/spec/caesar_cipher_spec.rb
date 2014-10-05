require_relative '../caesar_cipher'

describe "caesar_cipher method" do

  it "returns a string" do
    expect(caesar_cipher("testing", 38)).to be_an_instance_of(String)
  end

  it "shifts passed string by specified number of letters" do
    expect(caesar_cipher("hello", 13)).to eq("uryyb")
  end

  it "works correctly with both uppercase and lowercase letters" do
    expect(caesar_cipher("Peace", 8)).to eq("Xmikm")
  end

  it "handles shifts larger than 26" do
    expect(caesar_cipher("greetings", 27)).to eq("hsffujoht")
  end

  it "does not alter non-letter characters" do
    expect(caesar_cipher("hey, how are you?", 16)).to eq("xuo, xem qhu oek?")
  end

end
