class IdEncoder

  # A class used to take integer numbers and encode them as the smallest URL-safe
  # string possible. Also provides decoding.

  class << self

    # Changes an Integer id into a string id made from URL-safe characters
    def encoded_id(id)
      to_base(id, encode_mapping.length).map{|val| encode_mapping[val]}.join
    end

    # Changes a string id from URL-safe characters and returns an Integer
    def decoded_id(id_string)
      return nil if id_string.empty?
      digits = id_string.chars.map{ |char| decode_mapping[char] }
      from_base(digits, decode_mapping.length)
    end

    private

    # Takes a list of digits in their positions and a base and returns the value
    # as an integer
    def from_base(digits, base)
      return nil if digits.empty?
      digits.each.with_index.reduce(0) do |acc, (digit, index)|
        position = (digits.length - index - 1)
        acc + digit * (base ** position)
      end
    end

    # Takes an integer and converts it to a list of positions and numbers in the given
    # base
    def to_base(num, base)
      return [0] if num.zero?
      [].tap do |digits|
        while num > 0
          digits.unshift num % base
          num /= base
        end
      end
    end

    # Defines a unicode-safe array of characters that can be used in encoding
    # ids as short urls
    def encode_mapping
      @encode_mapping ||=
        [('0'..'9'), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten + ['-', '_', '~']
    end

    # Returns a hash with the reverse mapping of #encode_mapping
    def decode_mapping
      @decode_mapping ||= {}.tap do |mapping|
        encode_mapping.each_with_index do |val, index|
          mapping[val] = index
        end
      end
    end
  end
end
