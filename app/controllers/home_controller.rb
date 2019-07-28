class HomeController < ApplicationController
  
  def index
    @medal_img1 = "medal1.PNG"
    @medal_img2 = "medal2.PNG"
    @medal_img3 = "medal3.PNG"
    
    @realtime = Realtime.last
    @booth = Information.where(day:"낮").all.count
    @beer = Information.where(day:"밤").all.count
    
    @all = Information.all
    @booth_list = Information.where(day:"낮")
    @beer_list = Information.where(day:"밤")
    @booth_rank = Information.where(day:"낮").order(like: :desc).first(3)
    @beer_rank = Information.where(day:"밤").order(like: :desc).first(3)
  end
  
  def credit
    @realtime = Realtime.last
  end
  
  def day
    @realtime = Realtime.last
    if params.has_key?(:id) then
        @date = params[:id]
        @type = Information.where(date: params[:id], day:"낮").all
        @type_str_kor = '낮'
        @type_str = 'day'
        @type_str_rev = 'night'
    else
      redirect_to '/day/25'
    end
  end
  
  def night
    @realtime = Realtime.last
    if params.has_key?(:id) then
        @date = params[:id]
        @type = Information.where(date: params[:id], day:"밤").all
        @type_str_kor = '밤'
        @type_str = 'night'
        @type_str_rev = 'day'
    else
      redirect_to '/night/25'
    end
  end
  
  def realtime_data
    @info = Realtime.last
    render :json => @info
  end
  
  def increment
    post = Information.find(params[:id])
    post.like = post.like + 1
    if post.save
      render :json=>{message:"succeed"}
    else
      render :json=>{message:"failed"}
    end
  end
  
  def find
    info = Information.find(params[:id])
    date = info.date
    day = info.day
    if day == '낮' then
      redirect_to '/day/'+date.to_s+'?id='+params[:id].to_s
    else
      redirect_to '/night/'+date.to_s+'?id='+params[:id].to_s
    end
  end
end
