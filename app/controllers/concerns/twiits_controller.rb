class TwiitsController < ApplicationController
	def index
		@twiits = twiit.order(:message)
		respond_to do |format|
			format.html
			format.csv { send_data @twiits.to_csv}
			format.xls # { send_data @twiits.to_csv(col_spe: "\t")}
		end
	end

	def import
		Twiits.import(params[:file])
		redirect_to root_url, notice: "Information imported!"
	end
end
