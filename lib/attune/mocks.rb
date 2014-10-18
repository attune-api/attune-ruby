module Attune
  MOCKS = {
    'Anonymous.create' => Proc.new{ |body| {:id => SecureRandom.uuid } },
    'Entities.get_rankings' => Proc.new{ |body| { :ranking => body.ids.map(&:to_s) } },
    'Entities.batch_get_rankings' => Proc.new{ |body|
        { :results =>  body.requests.map {
            |params| { :ranking => params.ids.map(&:to_s) }
        } }
    }
  }
end