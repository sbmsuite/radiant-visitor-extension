module UserModelExtension
  def self.included(base)
    base.class_eval do
      has_many :authentications

      # Remove the existing validates_presence_of block for :password
      @validate_callbacks.reject! do |c|
        if c.method.is_a?(Proc)
          true
        else
          false
        end
      end     
      
      validates_uniqueness_of :login

      validates_confirmation_of :password, :if => :confirm_password?

      validates_format_of :email, :allow_nil => true, :with => /^$|^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

      validates_length_of :name, :maximum => 100, :allow_nil => true
      validates_length_of :login, :within => 3..40, :allow_nil => true
      validates_length_of :password, :within => 5..40, :allow_nil => true, :if => :validate_length_of_password?
      validates_length_of :email, :maximum => 255, :allow_nil => true

      validates_numericality_of :id, :only_integer => true, :allow_nil => true, :message => 'must be a number'

      # Add new validates_presence_of with new conditional
      validates_presence_of :password, :password_confirmation, :login, :name, :if => :password_required?

      def apply_omniauth(omniauth)
        authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      end

      def password_required?
        authentications.empty? && new_record?
      end
    end
  end  
end