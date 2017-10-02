class WebsiteController < ApplicationController
  def index
    @token = nil
  end

  def donate
    render_error and return unless check_of_params? params

    charity = Charity.find_by(id: params[:charity])
    if charity.nil?
      render_error and return unless params[:charity] == 'random'

      charity = Charity.rand_records.first
    end

    amount = params[:amount].to_i
    charity.credit_amount(amount * 100)

    flash[:notice] = t("website.donate.success")

    render(action: :index)
  end

  private

  def render_error(message = t("website.donate.failure"))
    flash.now[:alert] = message
    render(action: :index)
  end

  def check_of_params?(params)
    !params[:charity].blank? && !params[:amount].blank? &&
        params[:amount].to_i >= 20 && params[:amount].to_i != 999 &&
        !params[:omise_token].blank?
  end

  def retrieve_token(token)
    Omise::Token.retrieve(token)
  end
end
