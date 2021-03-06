Given "I am a real person wanting to sign up for an account" do
  # no-op.. for documentation purposes only!
end

When /^I submit my registration information$/ do
  fill_in "Name", :with => 'Joe Someone'
  fill_in "Email", :with => 'example@example.com'
  click_button 'Sign up'
end

Then /^(?:I|they) should receive an email with a link to a confirmation page$/ do
  expect(unread_emails_for(current_email_address).size).to eq 1

  # this call will store the email and you can access it with current_email
  open_last_email_for(last_email_address)
  expect(current_email).to have_subject(/Account confirmation/)
  expect(current_email).to have_body_text('Joe Someone')

  click_email_link_matching /confirm/
  expect(page).to have_content("Confirm your new account")
end

# Basically aliases "I should see [text]", but for third person
Then /^they should see "([^\"]*)"$/ do |text|
  step "I should see \"#{text}\""
end
