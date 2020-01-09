require 'chinese_money/version'

# Display Chinese money
module ChineseMoney
  class Error < StandardError; end
  # main method
  def self.show_money(total_money)
    cn_upper_number =%w[零 壹 贰 叁 肆 伍 陆 柒 捌 玖]
    cn_upper_monetray_unit = %w[元 拾 佰 仟 万 拾 佰 仟 亿 拾 佰 仟 兆 拾 佰 仟]
    cn_unit = %w[角 分]
    cn_negative = money < 0 ? '负' : ''
    money = money.abs
    is_full = money.to_i == money
    #  Too long too big/cannot support
    return '只支持总长度不超过17位的数字。' if money.abs.to_i > 100000000000000

    money = money.to_s
    left, right = money.split('.')
    left_str, right_str = '', ''
    if right
      rs = right.split('')
      rs.each_with_index do |r, i|
        right_str += "#{cn_upper_number[r.to_i]}#{cn_unit[i]}"
      end
    end
    left.split('').reverse_each.with_index do |l, i|
      left_str = "#{cn_upper_number[l.to_i]}#{cn_upper_monetray_unit[i]}#{left_str}" 
    end
    return [cn_negative, left_str, '整'].join if is_full
      
    [cn_negative, left_str, right_str].join
  end
end