class CreateOrUpdatePlayers
  def initialize(players, current_user)
    @players = players
    @current_user = current_user
  end

  def self.call(players, current_user)
    new(players, current_user).call
  end

  def call
    @players.each do |player|
      idiot = Idiot.find_by(r_star_id: player[:r_star_id])
      idiot = Idiot.find_by(name: player[:name]) if idiot.nil?
      idiot = Idiot.new if idiot.nil?
      
      idiot.name = player[:name]
      idiot.r_star_id = player[:r_star_id]
      idiot.ip = player[:ip]
      idiot.author = @current_user
      idiot.draft = true
      idiot.imported = true
      idiot.save
    end
  end
end
