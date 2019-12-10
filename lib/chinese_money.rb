require 'chinese_money/version'

# Display Chinese money
module ChineseMoney
  class Error < StandardError; end
  # main method
  def self.show_money(total_money)
    cn_upper_number =%w[零 壹 贰 叁 肆 伍 陆 柒 捌 玖]
    cn_upper_monetray_unit = %w[分 角 圆 拾 佰 仟 万 拾 佰 仟 亿 拾 佰 仟 兆 拾 佰 仟]
    cn_full = '整'
    cn_negative = '负'
    money_precision = 2
    cn_zeor_full = "零圆#{cn_full}"
    is_zero = false
    zero_size = 0
    num_index = 0
    num_unit = 0
    change_result = []
    my_total_price = total_money

    #  Too long too big/cannot support
    return '只支持总长度不超过17位的数字。' if my_total_price.to_i > 100000000000000

    #  For zero
    return cn_zeor_full if my_total_price.zero?

    #  For round
    my_number = my_total_price.round(money_precision) * 100
    scale = my_number % 100

    if scale.to_f.zero?
      num_index = 2
      my_number /= 100
      is_zero = true
    end

    if ((scale > 0) && (!(scale % 10 > 0))) 
      num_index = 1
      my_number /= 10
      is_zero = true
    end 

    loop do
      break if my_number <= 0

      num_unit = (my_number % 10).to_i
      if (num_unit > 0)
        change_result.prepend(cn_upper_monetray_unit[6]) if ((num_index == 9) && (zero_size >= 3))
        change_result.prepend(cn_upper_monetray_unit[10]) if ((num_index == 13) && (zero_size >= 3))
        change_result.prepend(cn_upper_monetray_unit[num_index])
        change_result.prepend(cn_upper_number[num_unit])
        is_zero = false
        zero_size = 0
      else
        zero_size += 1
        change_result.prepend(cn_upper_number[num_unit]) unless is_zero
        if num_index == 2
          change_result.prepend(cn_upper_monetray_unit[num_index]) if (my_number > 0) 
        elsif (((num_index - 2) % 4 == 0) && (my_number % 1000 > 0))
          change_result.prepend(cn_upper_monetray_unit[num_index])
        end
        is_zero = true
      end
      my_number = (my_number / 10).to_i
      num_index += 1
    end
    change_result.prepend(cn_negative) if my_total_price < 0
    change_result.append(cn_full) unless scale > 0
    change_result.join
  end
end