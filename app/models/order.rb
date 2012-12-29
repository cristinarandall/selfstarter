class Order < ActiveRecord::Base
  attr_accessible :address_one, :address_two, :city, :country, :number, :state, :status, :token, :transaction_id, :zip, :shipping, :tracking_number, :name, :price, :phone, :expiration, :user_id, :item_id
  attr_readonly :uuid
  before_validation :generate_uuid!, :on => :create
  belongs_to :user
  self.primary_key = 'uuid'


def import_country_codes

require 'csv'

  CSV.foreach(Rails.root.join('public/data', 'state_abbreviations.csv'), :headers => true) do |row|
@state = Country.create(:name=>row[0],  :code=>row[1])

  end

end


 def self.to_csv_alternative(options = {})
    CSV.generate(options) do |csv|
#      csv << ["name", "email" ]
    csv << column_names

      all.each do |product|
#        csv << product.attributes.values
        csv << product.attributes.values_at(*column_names)
      end
    end
  end


  # This is where we create our Caller Reference for Amazon Payments, and prefill some other information.
  def self.prefill!(options = {})
    @order          = Order.new
    @order.name     = options[:name]
    @order.user_id  = options[:user_id]
    @order.price    = options[:price]
    @order.number   = Order.next_order_number || 1
    @order.save!

    @order
  end

  # After authenticating with Amazon, we get the rest of the details
  def self.postfill!(options = {})
    @order = Order.find_by_uuid!(options[:callerReference])
    @order.token                = options[:tokenID]
    if @order.token.present?
      @order.address_one     = options[:addressLine1]
      @order.address_two     = options[:addressLine2]
      @order.city            = options[:city]
      @order.state           = options[:state]
      @order.status          = options[:status]
      @order.zip             = options[:zip]
      @order.phone           = options[:phoneNumber]
      @order.country         = options[:country]
      @order.expiration      = Date.parse(options[:expiry])
      @order.save!

      @order
    end
  end

  def self.next_order_number
    Order.order("number DESC").limit(1).first.number.to_i + 1 if Order.count > 0
  end

  def generate_uuid!
    self.uuid = SecureRandom.hex(16)
  end

  # Implement these three methods to
  def self.goal
    Settings.project_goal
  end



def self.checksum(number)



d = number.to_s.split(//) 
sum_even = d[-2].to_i + d[-4].to_i + d[-6].to_i + d[-8].to_i + d[-10].to_i + d[-12].to_i + d[-14].to_i
sum_odd = d[-3].to_i + d[-5].to_i + d[-7].to_i + d[-9].to_i + d[-11].to_i + d[-13].to_i + d[-15].to_i
sum = sum_even * 3 + sum_odd
check_code = 10 - sum % 10


end


def self.checksum1(input)

b = (1..input.length).map{|i| i%2==0?2:1}
output = 10 - input.split('').map(&:to_i).zip(b).map{|i,j| k=i*j; k<10?k:1+k%10}.inject(&:+)%10

end

def self.checksum2(input)

sum = 0
input.split('').map(&:to_i).each_with_index{|v,i| k=(i%2==0)?v:(v*2<10)?v*2:1+(v*2)%10; sum= sum+k}
output = 10 - sum%10

end


def self.checksum3(input)


b=Hash[(0..9).collect{|i| [i,i*2<10?i*2:1+(i*2%10)]}]
sum = 0
input.split(//).collect(&:to_i).each_with_index{|v,i| sum=sum+(i%2==0?v:b[v])}
output = 10 - sum%10

end


def self.checksum4(input)

b=Hash[(0..9).collect{|i| [i,i*2<10?i*2:i*2-9]}]
output = 10 - input.split(//).collect(&:to_i).zip((1..input.length).to_a).map{|v,i| i%2==0?b[v]:v}.inject(&:+)%10

end




  def gritworks_number

#XXX-XXXX-XXXX-XXXX 
@count = Order.find(:all, :conditions => {:created_at => self.created_at.beginning_of_day..self.created_at.end_of_day}).count + 1

@count = @count.to_s


if self.country
code = IsoCountryCodes.find(self.country)
else
code = IsoCountryCodes.find("United States")
end

if code
@first = code.numeric
else
@first = "XXX"
end

if (@count.size == 1) 
@third = "000" + @count 
elsif (@count.size == 2) 
@third = "00" + @count 
elsif (@count.size == 3)
@third = "0" + @count 
end


@fourth_first = "001"


@date = self.created_at.to_date
@first_digit = self.created_at.year.to_s[3]
@julian = @date.mjd - self.created_at.beginning_of_year.to_date.mjd
@second = @first_digit + @julian.to_s

@number = @first + @second + @third + @fourth_first
@checksum = Order.checksum1(@number)


@final = @first.to_s  + "-" + @second.to_s  + "-" + @third.to_s + "-" + @fourth_first.to_s + @checksum.to_s
self.gritworks = @final
self.save
  end


  def self.percent
    (Order.current.to_f / Order.goal.to_f) * 100.to_f
  end

  # See what it looks like when you have some backers! Drop in a number instead of Order.count
  def self.current
    Order.where("token != ? OR token != ?", "", nil).count
  end

  def self.revenue
    Order.current.to_f * Settings.price
  end

  validates_presence_of :name, :price, :user_id
end
