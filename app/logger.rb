module Logger
  extend self

  def write string
    @file ||= File.expand_path('~/aero_skk.log')
    open(@file, 'a+') do |io|
      io << "[#{Time.now}] #{string}\n"
    end
  end
end
