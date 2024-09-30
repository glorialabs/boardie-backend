class SubmissionsController < ApiController
  def update
    @submission = Submission.find(params[:id])
    if valid_params? && @submission.update(submission_params)
      render json: { status: "ok" }
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  private

  def valid_params?
    @submission.transaction_hash.blank? &&
      submission_params[:address] == @submission.address &&
      submission_params[:board_id] == @submission.board_id
  end

  def submission_params
    params.require(:submission).permit(:address, :board_id, :transaction_hash)
  end
end
