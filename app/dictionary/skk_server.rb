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
      self.load_okurigana
    end

    def to_s
      "skk server #{@host}:#{@port}"
    end

    def lookup base, tail = nil
      word = "#{base}#{@okurigana[tail]}"
      Logger.write "converting #{word}"
      res =
        case @encoding
        when Encoding::EUC_JP
          `echo '1#{word} ' | nkf -W80 -e | nc #{@host} #{@port} | nkf -E -w80`
        else
          `echo '1#{word} ' | nc #{@host} #{@port}`
        end
      Logger.write "conveted #{res}"
      cands = self.parse(res.each_line.first.chomp)
      if tail
        cands.each do |cand|
          cand[0] = cand[0] + tail
        end
      end
      cands
    end

    def parse line
      line.split('/').map do |str|
        str.split(';')
      end.drop(1)
    end

    def load_okurigana
      file = Dir[File.join('tables', 'okurigana').resource + '.*'].first
      text = open(file).read
      @okurigana = Hash[text.each_line.map(&:chomp).map{|line| line.split.map(&:strip)}]
    end
  end
end
