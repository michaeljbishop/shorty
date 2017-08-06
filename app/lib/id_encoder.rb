class IdEncoder
  def self.encode_mapping
    @encode_mapping ||= [('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten + ['-', '_', '~']
  end
  def self.decode_mapping
    @decode_mapping ||= {}.tap do |mapping|
      encode_mapping.each_with_index do |val, index|
        mapping[val] = index
      end
    end
  end
  def self.encoded_id(id)
    to_base(id, encode_mapping.length).map{|val| encode_mapping[val]}.join
  end
  def self.decoded_id(id_string)
    return nil if id_string.empty?
    digits = id_string.chars.map{ |char| decode_mapping[char] }
    from_base(digits, decode_mapping.length)
  end
  def self.from_base(digits, base)
    return nil if digits.empty?
    digits.each.with_index.reduce(0) do |acc, (digit, index)|
      position = (digits.length - index - 1)
      acc + digit * (base ** position)
    end
  end
  def self.to_base(num, base=10)
    return [0] if num.zero?
    [].tap do |digits|
      while num > 0
        digits.unshift num % base
        num /= base
      end
    end
  end
end
