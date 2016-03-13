# Paytrail module for Shoppe

[![Code Climate](https://codeclimate.com/github/anakinj/shoppe-paytrail/badges/gpa.svg)](https://codeclimate.com/github/anakinj/shoppe-paytrail)

Integrate Paytrail to your Shoppe application, with ease.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shoppe-paytrail'
```

And then execute:

    $ bundle install

## Example Payment handling

````ruby
class PaymentsController < ApplicationController
  before_action(only: [:paytrail, :paytrail_ok, :paytrail_error, :paytrail_notification]) { Shoppe::Paytrail.configure }

  def paytrail
    redirect_to current_order.redirect_to_paytrail(payments_paytrail_ok_url, payments_paytrail_error_url, payments_paytrail_notification_url)
  end

  def paytrail_ok
    redirect_to root_path and return unless current_order.confirming?

    paytrail_order = Shoppe::Order.find(params['ORDER_NUMBER'])
    paytrail_order.handle_paytrail_payment(params, false)
    paytrail_order.confirm!

    clear_current_order

    respond_to do |wants|
      wants.html { redirect_to root_path, notice: 'Your order has now been completed!' }
    end
  rescue => e
    redirect_to root_path, alert: 'There was an error while completing the payment'
  end

  def paytrail_error
    redirect_to root_path, alert: 'The payment process was aborted'
  end

  def paytrail_notification
    paytrail_order = Shoppe::Order.find(params['ORDER_NUMBER'])
    paytrail_order.handle_paytrail_payment(params, true)
    render :text => ""
  end
end
````

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anakinj/shoppe-paytrail.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
