module Shoppe
  module Paytrail
    class Engine < Rails::Engine
      config.before_initialize do
        config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
      end

      initializer "shoppe.paytrail.initializer" do
        Shoppe::Paytrail.configure
      end

      config.to_prepare do
        Shoppe::Order.send :include, Shoppe::Paytrail::OrderExtensions
      end
    end
  end
end
