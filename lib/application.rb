# frozen_string_literal: true

class Application
  def self.call(...)
    new(...).call
  end

  def exit_with_warning(message)
    warn message
    exit
  end
end
