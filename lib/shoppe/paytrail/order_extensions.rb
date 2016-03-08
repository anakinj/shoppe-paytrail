module Shoppe
  module Paytrail
    module OrderExtensions
      def redirect_to_paytrail
        # TODO: Call paytrail
      end

      def accept_paytrail_payment(payment_id, token, payer_id)
        self.payments.create(amount: self.total, method: "Paytrail", refundable: true, confirmed: false)
        self.save
      end

      def confim_paytrail_payment

      end

    end
  end
end
