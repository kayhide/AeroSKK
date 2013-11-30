# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  if ARGV.join(' ') =~ /spec/
    Bundler.require :default, :spec
  else
    Bundler.require
  end
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'AeroSKK'
  app.identifier = 'com.runnable-inc.inputmethod.AeroSKK'
  app.frameworks << 'InputMethodKit'

  app.redgreen_style = :full if app.respond_to?(:redgreen_style)

  app.info_plist['CFBundleDevelopmentRegion'] = 'ja_JP'
  app.info_plist['CFBundleIconFile'] = ''
  app.info_plist['NSHumanReadableCopyright'] = 'Copyright © 2013 Runnable Inc. All rights reserved.'
  app.info_plist['ComponentInputModeDict'] = {
    'tsInputModeListKey' => {
      'com.apple.inputmethod.Japanese' => {
        'TISInputSourceID' => 'com.runnable-inc.inputmethod.AeroSKK',
        'TISIntendedLanguage' => 'ja',
        'tsInputModeDefaultStateKey' => false,
        'tsInputModeIsVisibleKey' => true,
        'tsInputModeJISKeyboardShortcutKey' => 0,
        'tsInputModeMenuIconFileKey' => 'Japanese.tif',
        'tsInputModeAlternateMenuIconFileKey' => 'Japanese.tif',
        'tsInputModePaletteIconFileKey' => 'Japanese.tif',
        'tsInputModePrimaryInScriptKey' => true,
        'tsInputModeScriptKey' => 'smJapanese'
      },
      'com.apple.inputmethod.Roman' => {
        'TISInputSourceID' => 'com.runnable-inc.inputmethod.AeroSKK.Roman',
        'TISIntendedLanguage' => 'en',
        'tsInputModeDefaultStateKey' => true,
        'tsInputModeIsVisibleKey' => true,
        'tsInputModeJISKeyboardShortcutKey' => 1,
        'tsInputModeMenuIconFileKey' => 'Roman.tiff',
        'tsInputModeAlternateMenuIconFileKey' => 'Roman.tiff',
        'tsInputModePaletteIconFileKey' => 'Roman.tiff',
        'tsInputModePrimaryInScriptKey' => true,
        'tsInputModeScriptKey' => 'smRoman',
      },
      'com.apple.inputmethod.Japanese.FullWidthRoman' => {
        'TISInputSourceID' => 'com.runnable-inc.inputmethod.AeroSKK.FullWidthRoman',
        'TISIntendedLanguage' => 'ja',
        'tsInputModeDefaultStateKey' => true,
        'tsInputModeIsVisibleKey' => true,
        'tsInputModeJISKeyboardShortcutKey' => 2,
        'tsInputModeMenuIconFileKey' => 'FullWidthRoman.tiff',
        'tsInputModeAlternateMenuIconFileKey' => 'FullWidthRoman.tiff',
        'tsInputModePaletteIconFileKey' => 'FullWidthRoman.tiff',
        'tsInputModePrimaryInScriptKey' => false,
        'tsInputModeScriptKey' => 'smJapanese',
      }
    }
  }

end

task :install do
  app = Dir['./**/*.app'].first.gsub(/ /, '\\ ')
  basename = File.basename(app)
  dst = '~/Library/Input Methods/'.gsub(/ /, '\\ ')
  puts "#{basename} => #{dst}"
  `rm -rf #{dst}/#{basename}`
  `cp -r #{app} #{dst}`
end
