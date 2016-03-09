module Shoppe
  module Paytrail
    module OrderExtensions
      def redirect_to_paytrail(success_url, failure_url, notification_url)
        response = PaytrailClient::Payment.create(order_number: number,
                                                  currency: 'EUR',
                                                  locale: 'en_US',
                                                  url_set: {
                                                    success: success_url,
                                                    failure: failure_url,
                                                    notification: notification_url
                                                  },
                                                  price: format('%.2f',total))

        response['url']
      rescue
        raise Shoppe::Errors::PaymentDeclined
      end

      def create_paytrail_payment
        payments.create(amount: total, method: 'Paytrail', refundable: true, confirmed: false)
        save
      end

      def confim_paytrail_payment
      end
    end
  end
end
