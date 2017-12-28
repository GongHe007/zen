class Api::V1::AdvertisementsController < ApiController
  def index
    advertisements = Advertisement.online.where(_type: params[:_type]).where.not(user_id: current_user.id).includes(:user)
    amount = advertisements.count
    advertisements = advertisements.paginate(page: params[:page], per_page: 15)
    render json: { success: true, amount: amount, advertisements: advertisements.as_json }
  end

  def show
    advertisement = Advertisement.find_by(id: params[:id], status: Advertisement::ONLINE)
    render json: { success: true, advertisement: advertisement.as_json }
  end

  def create
    advertisement = Advertisement.new(advertisement_info.merge(user_id: current_user.id))
    render json: { success: advertisement.save }
  end

  private

  def advertisement_info
    params.permit(:_type, :currency, :legal_tender, :price, :min_limit, :max_limit, :time_limit, :remark)
  end
end