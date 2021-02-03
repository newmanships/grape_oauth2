module Grape
  module OAuth2
    # Grape::OAuth2 responses namespace.
    module Responses
      # Authorization response.
      class Authorization < Base
        # [IMPORTANT]: need to be implemented!
        # Doubt this is the correct implementation
        # but I've forked this for a project and it
        # solves our use case.

        def body
          access_token = rack_response[2]
            .instance_variable_get(:@body)
            .instance_variable_get(:@access_token)
            .instance_variable_get(:@access_token)
          if access_token.blank?
            return { success: false, message: "Could not generate Oauth2 access token" }
          else
            token = OauthAccessToken.find_by(token: access_token)
            if token
              token.update(resource_owner_id: token.client.resource_owner_id)
              return token.as_json(except: [:id, :client_id, :resource_owner_id])
            else
              return { success: false, message: "Could not locate OauthAccessToken from access token" }
            end
          end
        end
      end
    end
  end
end
