module I18n
  
  class << self
    def missing_translations_logger
      @@missing_translations_logger ||= Logger.new("#{RAILS_ROOT}/log/missing_translations.log")
    end

    def missing_translations_log_handler(exception, locale, key, options)
      if MissingTranslationData === exception
        puts "logging #{exception.message}"
        missing_translations_logger.warn(exception.message)
        return exception.message
      else
        raise exception
      end
    end
  end
end

I18n.exception_handler = :missing_translations_log_handler