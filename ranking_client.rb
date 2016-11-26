require 'json'
require 'net/http'

class RankingClient

  def rank_raw(cards)
    json = JSON.dump(cards)
    response = Net::HTTP.post_form(URI("http://rainman.leanpoker.org/rank"), {cards: json})
    body = response.body
    JSON.parse(body)
  end

end
