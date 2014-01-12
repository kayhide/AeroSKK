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
        '<<space>>' => ' ',
        '<<return>>' => "\n",
        '<<tab>>' => "\t",
        '<<lt>>' => "<",
        '<<gt>>' => ">",
        '<<wedge>>' => :wedge,
        '<<hammer>>' => :hammer,
      }
    end

    def parse_line line
      key, value = line.split
      key = self.special_chars[key] || key
      value = value.scan(/<<[^>]*>>|./).map do |v|
        self.special_chars[v] || v
      end
      value = value.first if value.one?
      [key, value]
    end
  end
end
