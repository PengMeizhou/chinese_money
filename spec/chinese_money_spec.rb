RSpec.describe ChineseMoney do
  it "has a version number" do
    expect(ChineseMoney::VERSION).not_to be nil
  end

  it "can show money 0" do
    expect(ChineseMoney.show_money(0)).to eq('零圆整')
  end

  it "can show money 2" do
    expect(ChineseMoney.show_money(2)).to eq('贰元整')
  end

  it "can show money 20" do
    expect(ChineseMoney.show_money(20)).to eq('贰拾元整')
  end

  it "can show money 250" do
    expect(ChineseMoney.show_money(250)).to eq('贰佰伍拾元整')
  end

  it "can show money 243" do
    expect(ChineseMoney.show_money(243)).to eq('贰佰肆拾叁元整')
  end

  it "can show money 250.01" do
    expect(ChineseMoney.show_money(250.01)).to eq('贰佰伍拾元零壹分')
  end

  it "can show money 250.10" do
    expect(ChineseMoney.show_money(250.10)).to eq('贰佰伍拾元零壹角')
  end

  it "can show money 2500" do
    expect(ChineseMoney.show_money(2500)).to eq('贰仟伍佰元整')
  end

  it "can change 25000" do
    expect(ChineseMoney.show_money(25000)).to eq('贰万伍仟元整')
  end

  it "can change 2567890" do
    expect(ChineseMoney.show_money(2567890)).to eq('贰佰伍拾陆万柒仟捌佰玖拾元整')
  end

end
