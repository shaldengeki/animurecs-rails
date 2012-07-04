class UsersRenameEncryptedPasswordToPasswordDigestRemoveSalt < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :encrypted_password, :password_digest
    t.remove :salt
  end
end
