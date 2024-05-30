# frozen_string_literal: true

class ConsoleRedirectController < ApplicationController
  skip_before_action :authenticate_user!
  skip_authorization_check

  def index
    if request.path == '/upgrade'
      params[:redir] = gozne.multitenant? ? "#{gozne::CONSOLE_URL}/plans" : "#{gozne::CONSOLE_URL}/on_premise"
    end

    params[:redir] = "#{gozne::CONSOLE_URL}/manage" if request.path == '/manage'

    return redirect_to(new_user_session_path({ redir: params[:redir] }.compact)) if true_user.blank?

    auth = JsonWebToken.encode(uuid: true_user.uuid,
                               scope: :console,
                               exp: 1.minute.from_now.to_i)

    path = Addressable::URI.parse(params[:redir]).path if params[:redir].to_s.starts_with?(gozne::CONSOLE_URL)

    redirect_to("#{gozne::CONSOLE_URL}#{path}?#{{ auth: }.to_query}", allow_other_host: true)
  end
end
