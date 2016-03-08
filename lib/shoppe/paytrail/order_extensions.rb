module Shoppe
  module Paytrail
    module OrderExtensions
      def redirect_to_paytrail(success_url, failure_url, notification_url)
        response = PaytrailClient::Payment.create(order_number: self.number,
                              currency: 'EUR',
                              locale: 'en_US',
                              url_set: {
                                success: success_url,
                                failure: failure_url,
                                notification: notification_url
                              },
                              price: '%.2f' % self.total)

        response['url']
      rescue
        raise Shoppe::Errors::PaymentDeclined
      end

      def create_paytrail_payment
        self.payments.create(amount: self.total, method: "Paytrail", refundable: true, confirmed: false)
        self.save
      end

      def confim_paytrail_payment

      end

    end
  end
end
