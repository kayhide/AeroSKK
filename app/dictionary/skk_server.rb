module Dictionary
  class SkkServer
    attr_accessor :host, :port, :encoding
    attr_accessor :read_timeout, :write_timeout

    def initialize host = nil, port = nil, encoding = nil
      @host = host
      @port = port
      @encoding = encoding || Encoding::UTF_8
      @read_timeout = 0.1
      @write_timeout = 0.1
    end

    def to_s
      "skk server #{@host}:#{@port}"
    end

    def lookup base, tail = nil
      res =
        case @encoding
        when Encoding::EUC_JP
          `echo '1#{base} ' | nkf -W80 -e | nc #{@host} #{@port} | nkf -E -w80`
        else
          `echo '1#{base} ' | nc #{@host} #{@port}`
        end
      self.parse res.each_line.first.chomp
    end

    def parse line
      line.split('/').map do |str|
        str.split(';')
      end.drop(1)
    end
  end
end
