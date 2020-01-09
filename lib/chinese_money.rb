require 'chinese_money/version'

# Display Chinese money
module ChineseMoney
  class Error < StandardError; end
  # main method
  CN_UPPER_NUMBER = %w[零 壹 贰 叁 肆 伍 陆 柒 捌 玖]
  CN_BASE = ['', '拾', '佰', '仟']
  CN_ADVANCE = ['', '万', '亿', '兆']
  CN_UNIT = %w[角 分]
  CN_FULL = '整'
  CN_YUAN = '圆'
    
  def self.show_money(money)
    cn_negative = money < 0 ? '负' : ''
    money = money.abs
    is_full = money.to_i == money
    return '只支持总长度不超过17位的数字。' if money.to_i > 100000000000000
    return "#{CN_UPPER_NUMBER.first}#{CN_YUAN}#{CN_FULL}" if money.zero?

    money = money.to_s
    left, right = money.split('.')
    left_str, right_str = '', ''

    # 读取小数点左边数字, 把数字按4位一组分割, 每组用 format_basic 方法读成数字，最后拼接起来
    left_arr = []
    lefts = left.split('').reverse
    i = 0
    while i < lefts.length
      left_arr << lefts[i..(i+3)]
      i += 4
    end
    left_arr.each_with_index do |a, i|
      tmp = format_basic(a)
      left_str = "#{tmp}#{tmp.empty? ? '' : CN_ADVANCE[i]}" + left_str
    end
    left_str += CN_YUAN
    return [cn_negative, left_str, CN_FULL].join if is_full

    # 读取小数点右边数字
    right.split('').each_with_index do |r, i|
      next if r == '0'
      right_str += "#{CN_UPPER_NUMBER[r.to_i]}#{CN_UNIT[i]}"
    end
    right_str = "#{CN_UPPER_NUMBER.first}#{right_str}" unless right_str.start_with?(CN_UPPER_NUMBER.first)
    [cn_negative, left_str, right_str].join
  end

  # 将任意1-4位数读出来: X千Y百Z十M
  def self.format_basic(arr)
    res = ''
    arr.each.with_index do |r, i|
      tmp = r == '0' ? CN_UPPER_NUMBER[r.to_i] : "#{CN_UPPER_NUMBER[r.to_i]}#{CN_BASE[i]}"
      res = tmp + res
    end
    while res.end_with?(CN_UPPER_NUMBER[0])
      res = res[0...-1]
    end
    res.gsub(/#{CN_UPPER_NUMBER[0]}{1,}/, CN_UPPER_NUMBER[0])
  end
end