Rails.configuration.stripe = {
  :publishable_key => 'pk_test_awhaS1iVp4nGg3TmQwcPvDOS',
  :secret_key      => 'sk_test_f1muWJoJSNCFf77jTFL1imMW'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]