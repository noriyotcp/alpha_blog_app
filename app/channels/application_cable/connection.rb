module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/
    identified_by :current_user

    def connect
      self.current_user = find_varified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    def disconnect
    end

    protected

      def find_varified_user
        if varified_user = env['warden'].user
          varified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
