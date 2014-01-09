module Processor
  module TableCreate
    def create name
      file = Dir[File.join('tables', name.to_s).resource + '.*'].first
      text = open(file).read
      hash = Hash[text.each_line.map(&:chomp).map{|line| self.parse_line line}]
      Logger.write "open: #{name}"
      Logger.write "read: #{file}"
      self.new.tap do |p|
        p.table.merge! hash
      end
    end

    def special_chars
      @special_chars ||= {
        '<<Space>>' => ' ',
        '<<Return>>' => "\n",
        '<<Tab>>' => "\t",
        '<<wedge>>' => :wedge,
        '<<hammer>>' => :hammer,
      }
    end

    def special_chars_pattern
      @special_chars_pattern ||=
        Regexp.new(
        self.special_chars.keys.map do |k|
          Regexp.escape k
        end.join('|')
        )
    end

    def parse_line line
      key, value = line.split
      key = self.special_chars[key] || key
      value = value.scan(/#{self.special_chars_pattern}|./).map do |v|
        self.special_chars[v] || v
      end
      value = value.first if value.one?
      Logger.write line
      Logger.write value
      [key, value]
    end
  end
end
