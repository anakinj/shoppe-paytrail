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
                                                  price: format('%.2f', total))

        response['url']
      rescue
        raise Shoppe::Errors::PaymentDeclined
      end

      def handle_paytrail_payment(params)
        PaytrailClient::Payment.verify_payment!(params['ORDER_NUMBER'],
                                                params['TIMESTAMP'],
                                                params['PAID'],
                                                params['METHOD'],
                                                params['RETURN_AUTHCODE'])

        payments.create(amount:     total,
                        reference:  params['ORDER_NUMBER'],
                        method:     'Paytrail',
                        refundable: false,
                        confirmed:  false)
        save!
      rescue
        raise Shoppe::Errors::PaymentDeclined, 'Could not verify Paytrail payment'
      end

      def verify_paytrail_payment(params)
        PaytrailClient::Payment.verify_payment!(params['ORDER_NUMBER'],
                                                params['TIMESTAMP'],
                                                params['PAID'],
                                                params['METHOD'],
                                                params['RETURN_AUTHCODE'])
       payment = payments.find_by(reference: params['ORDER_NUMBER'])
       raise Shoppe::Errors::PaymentDeclined, 'Could not find payment to verify' if payment.nil?
       payment.update_attribute(confirmed: true)
      rescue
        raise Shoppe::Errors::PaymentDeclined, 'Could not verify Paytrail payment'
      end
    end
  end
end
