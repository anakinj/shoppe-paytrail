require 'paytrail-client'
require 'shoppe/paytrail/version'
require 'shoppe/paytrail/order_extensions'
require 'shoppe/paytrail/engine'

module Shoppe::Paytrail
  class << self
    def setup
      Shoppe.add_settings_group :paytrail, [:paytrail_merchant_id, :paytrail_merchant_secret]
    end

    def configure
      PaytrailClient.configuration do |config|
        config.merchant_id = Shoppe.settings.paytrail_merchant_id
        config.merchant_secret = Shoppe.settings.paytrail_merchant_secret
      end
    end
  end
end
