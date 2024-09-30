class AddressNftGetter
  include Interactor

  QUERY = "query MyQuery {
    current_token_ownerships_v2(
      where: { owner_address: { _eq: \"%{address}\" }, amount: { _gte: \"1\" } }
    ) {
    current_token_data {
      token_data_id
      current_collection {
        collection_name
        collection_id
      }
      cdn_asset_uris {
        cdn_image_uri
      }
    token_name
    }
  }
}"

  def run
    context.nfts = [] if context.address.blank?
    RestClient.post("https://api.mainnet.aptoslabs.com/v1/graphql", { query: QUERY % { address: context.address } }.to_json, { content_type: :json, accept: :json }) do |response, request, result|
      case response.code
      when 200
        result = JSON.parse(response.body)["data"]["current_token_ownerships_v2"]
        collection_infos = CollectionInfo.where(collection_hash: result.map { |r| r["current_token_data"]["current_collection"]["collection_id"] }.uniq)
        result.each do |r|
          replace_image(r)
          collection_info = collection_infos.find { |ci| ci.collection_hash == r["current_token_data"]["current_collection"]["collection_id"] }
          r["current_token_data"]["cdn_asset_uris"] ||= {}
          r["current_token_data"]["cdn_asset_uris"]["cdn_image_uri"] ||= collection_info&.collection_image
          r["current_token_data"]["cdn_asset_uris"]["backup_cdn_image_uri"] = collection_info&.backup_collection_image
        end
        context.nfts = result
      else
        puts response.code
        puts response.body
        context.fail!(error: response.body)
      end
    end
  end

  private

  def replace_image(record)
    if %w[0x30fbc956f0f38db2d314bd9c018d34be3e047a804a71e30a4e5d43d8b7c539eb 0x63d26a4e3a8aeececf9b878e46bad78997fb38e50936efeabb2c4453f4d7f746].include? record["current_token_data"]["current_collection"]["collection_id"]
      record["current_token_data"]["cdn_asset_uris"]["cdn_image_uri"] = "https://aptos-names-api-u6smh7xtla-uw.a.run.app/v2/image/" + record["current_token_data"]["token_name"].split(".apt")[0]
    elsif record["current_token_data"]["current_collection"]["collection_id"] == "0x30e2f18b1f9c447e7dadd7a05966e721ab6512b81ee977cb053edb86cc1b1d65"
      record["current_token_data"]["cdn_asset_uris"]["cdn_image_uri"] = "https://api.cellana.finance/api/v1/ve-nft/uri/@" + record["current_token_data"]["token_data_id"].gsub(/^0x0*/, "0x")
    end
  end
end
