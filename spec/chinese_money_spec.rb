RSpec.describe ChineseMoney do
  it "has a version number" do
    expect(ChineseMoney::VERSION).not_to be nil
  end

  it "is the first version" do
    expect(ChineseMoney::VERSION).to eq('1.0.1')
  end

  it "can show money 0" do
    expect(ChineseMoney.show_money(0)).to eq('零圆整')
  end

  it "can show money 2" do
    expect(ChineseMoney.show_money(2)).to eq('贰圆整')
  end

  it "can show money 20" do
    expect(ChineseMoney.show_money(20)).to eq('贰拾圆整')
  end

  it "can show money 250" do
    expect(ChineseMoney.show_money(250)).to eq('贰佰伍拾圆整')
  end

  it "can show money 243" do
    expect(ChineseMoney.show_money(243)).to eq('贰佰肆拾叁圆整')
  end

  it "can show money 250.01" do
    expect(ChineseMoney.show_money(250.01)).to eq('贰佰伍拾圆零壹分')
  end

  it "can show money 250.10" do
    expect(ChineseMoney.show_money(250.10)).to eq('贰佰伍拾圆零壹角')
  end

  it "can show money 2500" do
    expect(ChineseMoney.show_money(2500)).to eq('贰仟伍佰圆整')
  end

  it "can change 25000" do
    expect(ChineseMoney.show_money(25000)).to eq('贰万伍仟圆整')
  end

  it "can change 2567890" do
    expect(ChineseMoney.show_money(2567890)).to eq('贰佰伍拾陆万柒仟捌佰玖拾圆整')
  end

  it "can change 20000" do
    expect(ChineseMoney.show_money(20000)).to eq('贰万圆整')
  end

  it "can change 200000.00" do
    expect(ChineseMoney.show_money(200000.00)).to eq('贰拾万圆整')
  end

  it "can change 20000000000000.01" do
    expect(ChineseMoney.show_money(20000000000000.01)).to eq('贰拾兆圆零壹分')
  end

  it "can not change 200000000000000.01" do
    expect(ChineseMoney.show_money(200000000000000.01)).to eq('只支持总长度不超过17位的数字。')
  end

  it "can not change 20000000000000000.01" do
    expect(ChineseMoney.show_money(20000000000000000.01)).to eq('只支持总长度不超过17位的数字。')
  end

end
