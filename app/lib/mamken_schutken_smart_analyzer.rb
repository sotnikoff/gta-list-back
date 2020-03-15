
class MamkenSchutkenSmartAnalyzer
  def initialize(messages, current_user)
    @messages = messages
    @current_user = current_user
  end

  def perform
    @messages.each do |message|
      idiot = Idiot.find_by(name: message[:author])
      Idiot.create(name: message[:author], draft: true, author: @current_user) if idiot.nil?
      # MamkenSchutken.create(idiot: idiot, user: @current_user, message: message[:message])
    end
    analyze
  end

  def analyze
    result = {}
    User.all.each do |user|
      MamkenSchutken.where(user: user).pluck(:idiot_id).uniq.each do |id|
        shutken = MamkenSchutken.where(idiot_id: id, user: user).pluck(:message).join(' ').downcase
        ratio = 0
        MamkenSchutkenMamkenWords.list.each do |w|
          ratio = ratio + shutken.scan(w[0]).count * w[1].to_i
        end
        if result.key?(id)
          result[id] << ratio
        else
          result[id] = [ratio]
        end
      end
    end
    result.each do |k, v|
      idiot = Idiot.find(k)
      idiot.mom_joke_ratio = v.max
      idiot.save
    end
  end


end

