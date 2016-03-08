module Shoppe::Paytrail
  class << self
    def setup
      Shoppe.add_settings_group :paytrail, [:paytrail_merchant_id, :paytrail_merchant_secret]

      Shoppe::Order.before_acceptance do
        Shoppe::Paytrail.configure

        self.payments.where(confirmed: false, method: 'Paytrail').each do |payment|
          # TODO: Can we confirm the payment?
        end
      end
    end

    def configure
      PaytrailClient.configuration do |config|
        config.merchant_id = Shoppe.settings.paytrail_merchant_id
        config.merchant_secret = Shoppe.settings.paytrail_merchant_secret
      end
    end
  end
end