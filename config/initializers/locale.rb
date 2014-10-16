# tell the I18n library where to find your translations
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

# set default locale to something other than :en
I18n.default_locale = :ca
