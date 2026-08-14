class SendgridDeliveryMethod
  include HTTParty
  base_uri 'https://api.sendgrid.com/v3'

  def initialize(settings)
    @settings = settings
  end

  def deliver!(mail)
    response = self.class.post(
      '/mail/send',
      headers: {
        'Authorization' => "Bearer #{@settings[:api_key]}",
        'Content-Type' => 'application/json'
      },
      body: build_payload(mail).to_json
    )

    raise "SendGrid API error: #{response.code} #{response.body}" unless response.success?

    response
  end

  private

  def build_payload(mail)
    personalization = { to: mail.to.map { |address| { email: address } } }
    personalization[:bcc] = mail.bcc.map { |address| { email: address } } if mail.bcc.present?

    {
      personalizations: [personalization],
      from: { email: mail.from.first },
      subject: mail.subject,
      content: [{ type: 'text/html', value: mail.body.decoded }]
    }
  end
end
