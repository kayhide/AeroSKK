$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  if ARGV.join(' ') =~ /spec/
    Bundler.require :default, :spec
    RUBYMOTION_ENV = 'test'
  else
    Bundler.require
    RUBYMOTION_ENV = 'development'
  end
rescue LoadError
end

require 'sugarcube-files'
require 'sugarcube-attributedstring'

Motion::Project::App.setup do |app|
  app.name = 'AeroSKK'
  app.identifier = 'com.runnable-inc.inputmethod.AeroSKK'
  app.icon = 'aero_skk.png'
  app.frameworks << 'InputMethodKit'

  app.redgreen_style = :full if app.respond_to?(:redgreen_style)

  app.info_plist['CFBundleDevelopmentRegion'] = 'ja_JP'
  app.info_plist['NSHumanReadableCopyright'] = 'Copyright 2013 Runnable Inc. All rights reserved.'

  app.info_plist['InputMethodConnectionName'] = "AeroSKKConnection_#{RUBYMOTION_ENV}"
  app.info_plist['InputMethodServerControllerClass'] = 'AeroSKKInputController'
  app.info_plist['LSBackgroundOnly'] = 1
  app.info_plist['ComponentInputModeDict'] = {
    'tsInputModeListKey' => {
      'com.apple.inputmethod.Japanese' => {
        'TISInputSourceID' => 'com.runnable-inc.inputmethod.AeroSKK.Japanese',
        'TISIntendedLanguage' => 'ja',
        'tsInputModeDefaultStateKey' => false,
        'tsInputModeIsVisibleKey' => true,
        'tsInputModeJISKeyboardShortcutKey' => 0,
        'tsInputModeMenuIconFileKey' => 'japanese.tiff',
        'tsInputModeAlternateMenuIconFileKey' => 'japanese.tiff',
        'tsInputModePaletteIconFileKey' => 'japanese.tiff',
        'tsInputModePrimaryInScriptKey' => true,
        'tsInputModeScriptKey' => 'smJapanese'
      },
      'com.apple.inputmethod.Roman' => {
        'TISInputSourceID' => 'com.runnable-inc.inputmethod.AeroSKK.Roman',
        'TISIntendedLanguage' => 'en',
        'tsInputModeDefaultStateKey' => true,
        'tsInputModeIsVisibleKey' => true,
        'tsInputModeJISKeyboardShortcutKey' => 1,
        'tsInputModeMenuIconFileKey' => 'roman.tiff',
        'tsInputModeAlternateMenuIconFileKey' => 'roman.tiff',
        'tsInputModePaletteIconFileKey' => 'roman.tiff',
        'tsInputModePrimaryInScriptKey' => true,
        'tsInputModeScriptKey' => 'smRoman',
      },
    },
    'tsVisibleInputModeOrderedArrayKey' =>
    [
     'com.apple.inputmethod.Japanese',
     'com.apple.inputmethod.Roman'
    ]
  }
  app.info_plist['tsInputMethodCharacterRepertoireKey'] = %w(Hira Latn)
  app.info_plist['tsInputMethodIconFileKey'] = 'aero_skk.png'
end

$app = App.config.app_bundle_raw(App.config.local_platform)
$dst_dir = '~/Library/Input Methods/'
$dst_app = File.join($dst_dir, File.basename($app))

task :install => ['build:development', 'uninstall'] do
  if $app && $dst_dir
    puts "copy: #{$dst_app}"
    `cp -r #{$app.gsub(/ /, '\\ ')} #{$dst_dir.gsub(/ /, '\\ ')}`
  end
end

task :uninstall do
  line = `ps x`.lines.grep(Regexp.new(Regexp.escape(File.expand_path($dst_app)))).first
  if line
    puts "kill: #{line}"
    `kill #{line.split.first}`
  end
  if File.exist?(File.expand_path($dst_app))
    puts "remove: #{$dst_app}"
    `rm -rf #{$dst_app.gsub(/ /, '\\ ')}`
  end
end
