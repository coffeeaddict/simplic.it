class Notifications < ActionMailer::Base
  

  def new_comment(comment, sent_at = Time.now)
    subject    '{ Simplic.IT } New comment'
    recipients 'hartog.de.mik@simplic.it'
    from       'webmaster@simplic.it'
    sent_on    sent_at
    
    body       :comment => comment
  end

end
