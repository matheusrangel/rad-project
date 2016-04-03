require 'test_helper'

class ContactsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    get root_path
    log_in_as(@user, '12345')
    assert_redirected_to user_path(@user)
  end

  test 'create contact for an user' do
    before_count = Contact.count
    post contacts_path, contact: { nome: 'Victor', email: 'victor@email.com', phone: '88888888', address: 'Rua teste', user_id: @user.id }
    after_count = Contact.count
    assert_not_equal before_count, after_count
  end

  test 'edit a contact' do
    post contacts_path, contact: { nome: 'Victor', email: 'victor@email.com', phone: '88888888', address: 'Rua teste', user_id: @user.id }
    name = 'Pokemon'
    contact = @user.contacts.first
    assert_not_equal contact.nome, name
    patch contact_path(contact), contact: { nome: name, email: contact.email, phone: contact.phone, address: contact.address, user_id: @user.id }
    assert_not flash.empty?
    assert_redirected_to contacts_path
    contact.reload
    assert_equal contact.nome, name
  end

  test 'delete a contact' do
    post contacts_path, contact: { nome: 'Victor', email: 'victor@email.com', phone: '88888888', address: 'Rua teste', user_id: @user.id }
    contact = @user.contacts.first
    before_count = Contact.count
    delete contact_path(contact)
    after_count = Contact.count
    assert_not flash.empty?
    assert_redirected_to contacts_path
    assert_not_equal before_count, after_count
  end

end
