module Wapal
  class CollectionInfoUpdater
    include Interactor
    URL = "https://aggregator-api.wapal.io/collection?page=1&take=5000&sortBy=ALL_TIME_VOLUME"

    def run
      response = RestClient.get(URL).body
      collections = JSON.parse(response)
      collections.each do |collection|
        collection_info = CollectionInfo.find_or_create_by(collection_hash: collection["collectionId"])
        collection_info.all_time_volume = convert_to_float collection["allTimeVolume"]
        collection_info.seven_days_volume = convert_to_float collection["sevenDaysVolume"]
        collection_info.one_day_volume = convert_to_float collection["oneDayVolume"]
        collection_info.floor_price = convert_to_float collection["floorPrice"]
        collection_info.top_bid = convert_to_float collection["topBid"]
        collection_info.unique_owners_count = collection["uniqueOwnersCount"]
        collection_info.creator_address = collection["creatorAddress"]
        collection_info.name = collection["collectionName"]
        collection_info.current_supply = collection["currentSupply"]
        collection_info.uri = collection["uri"]
        collection_info.slug = collection["slug"]
        collection_info.collection_image = collection["collectionImage"]
        collection_info.is_verified = collection["isVerified"]
        collection_info.one_day_change_percent = collection["oneDayChangePercent"]
        collection_info.seven_days_change_percent = collection["sevenDaysChangePercent"]
        collection_info.backup_collection_image ||= collection_info.collection_image
        collection_info.save
      end
    end

    private

    def convert_to_float(value)
      value.to_f * 10 ** -8
    end
  end
end
