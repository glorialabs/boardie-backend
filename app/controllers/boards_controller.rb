class BoardsController < ApiController
  def index
    boards = Board.enabled.map { |b| b.attributes.with_indifferent_access }
    if params[:address].to_s.start_with?("0x")
      submissions = Submission.where(address: params[:address])
      if submissions.count >= boards.count && submissions.all? { |s| s.transaction_hash.present? }
        boards.each do |b|
          b[:status] = "minted"
          b[:submission_id] = submissions.find { |s| s.board_id == b[:id] }.id
        end
      else
        all_nfts = AddressNftGetter.call(address: params[:address]).nfts
        boards_to_whitelist = boards.map do |board|
          submission = submissions.find { |s| s.board_id == board[:id] }
          board[:submission_id] = submission&.id
          result = AddressNftSelector.call(nfts: all_nfts,
                                           board: board,
                                           address: params[:address],
                                           submission: submission)
          board[:nfts] = result.nfts
          board[:my_count] = board[:nfts].count
          board[:status] = result.status
          (board[:status] == "eligible" && !submission) ? board[:id] : nil
        end.compact
        if boards_to_whitelist.present?
          PythonScriptExecutor.call(address: params[:address],
                                    board_ids: boards_to_whitelist.join(","))
          boards_to_whitelist.each do |board_id|
            submission = Submission.create(address: params[:address], board_id: board_id)
            submission.request_details = request.env.slice("HTTP_SEC_CH_UA",
                                                           "HTTP_SEC_CH_UA_MOBILE",
                                                           "HTTP_SEC_CH_UA_PLATFORM",
                                                           "HTTP_USER_AGENT",
                                                           "HTTP_COOKIE")
                                                .merge({ ip: request.env["action_dispatch.remote_ip"].calculate_ip })
            submission.ip = request.remote_ip
            submission.save
            boards.find { |b| b[:id] == board_id }[:submission_id] = submission.id
          end
        end
      end
    end

    render json: { boards: boards.each { |b| b.delete("extra") } }
  end
end
