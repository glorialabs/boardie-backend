class AddressNftSelector
  include Interactor

  def call
    if context.address.blank?
      context.status = "not_eligible"
      return
    end
    filter_active_collections
    check_uniq_collections
    check_single_collection
    check_collection_names
    check_min_floor_price
    check_min_supply
    check_min_holder_count
    check_max_holder_count
    filter_count
    set_status
  end

  private

  def filter_active_collections
    active_collections = CollectionInfo.active.pluck(:collection_hash)
    context.nfts = context.nfts.select { |nft| active_collections.include?(nft["current_token_data"]["current_collection"]["collection_id"]) }
  end

  def filter_count
    context.nfts = context.nfts.take(context.board["count"])
  end

  def check_uniq_collections
    if context.board["extra"]&.dig("uniq_collections")
      uniq_collections = context.nfts.map { |nft| nft["current_token_data"]["current_collection"]["collection_id"] }.uniq
      result = []
      copy = context.nfts.dup
      uniq_collections.each do |collection_id|
        result << copy.delete(copy.find { |nft| nft["current_token_data"]["current_collection"]["collection_id"] == collection_id })
        break if result.count >= context.board["count"]
      end
      context.nfts = result
    end
  end

  def check_single_collection
    if context.board["extra"]&.dig("single_collection")
      biggest_collection = context.nfts.group_by { |nft| nft["current_token_data"]["current_collection"]["collection_id"] }
                                 .transform_values(&:count).sort_by { |_, count| -count }&.first&.first
      context.nfts = context.nfts.select { |nft| nft["current_token_data"]["current_collection"]["collection_id"] == biggest_collection }
    end
  end

  def check_collection_names
    if mask = context.board["extra"]&.dig("collection_name")
      context.nfts = context.nfts.select { |nft| nft["current_token_data"]["current_collection"]["collection_name"].downcase.include? mask }
    end
  end

  def check_min_floor_price
    if floor_price = context.board["extra"]&.dig("min_floor_price")
      collections = CollectionInfo.active.where("floor_price >= ?", floor_price).pluck(:collection_hash)
      context.nfts = context.nfts.select { |nft| collections.include?(nft["current_token_data"]["current_collection"]["collection_id"]) }
    end
  end

  def check_min_supply
    if context.board["extra"]&.dig("min_supply")
      collections = CollectionInfo.active.where("current_supply >= ?", context.board["extra"]["min_supply"]).pluck(:collection_hash)
      context.nfts = context.nfts.select { |nft| collections.include?(nft["current_token_data"]["current_collection"]["collection_id"]) }
    end
  end

  def check_min_holder_count
    if context.board["extra"]&.dig("min_holder_count")
      collections = CollectionInfo.active.where("unique_owners_count >= ?", context.board["extra"]["min_holder_count"]).pluck(:collection_hash)
      context.nfts = context.nfts.select { |nft| collections.include?(nft["current_token_data"]["current_collection"]["collection_id"]) }
    end
  end

  def check_max_holder_count
    if context.board["extra"]&.dig("max_holder_count")
      collections = CollectionInfo.active.where("unique_owners_count <= ?", context.board["extra"]["max_holder_count"]).pluck(:collection_hash)
      context.nfts = context.nfts.select { |nft| collections.include?(nft["current_token_data"]["current_collection"]["collection_id"]) }
    end
  end

  def set_status
    eligible = context.nfts.count >= context.board["count"]
    if context.submission
      context.status = context.submission.transaction_hash.present? ? "minted" : "eligible"
    else
      context.status = eligible ? "eligible" : "not_eligible"
    end
  end
end
