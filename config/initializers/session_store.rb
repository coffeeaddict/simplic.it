# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simplicity_dev_session',
  :secret      => '9d4375dcfcc350ef95c7f0bf7d5ab4aa0dc9b7ad500c15d5c06076fa2f2b2f2273805d9223f42de143c5ede98401a3706657f50333efdc73f4c1efe9ab8e3517'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
