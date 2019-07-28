class UsersController < ApplicationController
  def new
    
  end
  
  def db_move
    @every_post=Information.order("date desc").order("day desc")
  end
  
  def show
    if !logged_in? then
      flash[:danger]="관리자 로그인이 필요합니다."
      redirect_to '/likelion'
    end
    
    @post = Information.all
    @realtime = Realtime.all
    
  end
  
  def make_location_list
     @every_post=Information.order("id desc")
  end
  
  def day
    @every_post=Information.where(day:"낮").order("id desc")
  end
  
  def night
    @every_post=Information.where(day:"밤").order("id desc")
  end
  
  def make_realtime_save
    
    new_realtime = Realtime.new
    new_realtime.Title = params[:title]
    new_realtime.Content = params[:content]
    new_realtime.save
    
    flash[:success] = "성공적으로 데이터가 저장되었습니다. 사용자들이 메인 페이지에서 실시간으로 전광판을 통해 내용 확인이 가능합니다."
    redirect_to '/fest_manage/make/realtime'
  end
  
  def write
    new_post= Information.new
    new_post.title = params[:title]
    new_post.menu = params[:menu]
    new_post.x_loc = params[:location_x]
    new_post.y_loc = params[:location_y]
    new_post.date = params[:date]
    new_post.day = params[:day]
    new_post.like = params[:like]
    new_post.menu.gsub(/\n/, '<br>')
    if new_post.save then
      flash[:success] = "성공적으로 데이터가 저장되었습니다."
      redirect_to '/fest_manage/make/location/list'
    else
      flash[:red] = "저장 중 문제가 발생하였습니다. 양식을 올바르게 작성하였는지 확인하여주십시오."
      redirect_to '/fest_manage/make/location'
    end
    
  end

  def make_location_rewrite

    @post_post= Information.find(params[:id])

  end


  def update
    @post_post = Information.find(params[:id])
    @post_post.title = params[:title]
    @post_post.menu = params[:menu]
    @post_post.x_loc = params[:location_x]
    @post_post.y_loc = params[:location_y]
    @post_post.date = params[:date]
    @post_post.day = params[:day]
    if @post_post.save then
      flash[:modified]="데이터가 수정되었습니다."
      redirect_to '/fest_manage/make/location/list'
    else
      flash[:red]="저장 실패. 양식이 올바른지 확인하십시오."
      redirect_to '/fest_manage/make/location/rewrite/'+params[:id]
    end

  end
  
  def destroy
    @post_post = Information.find(params[:id])
    if @post_post.destroy then
      flash[:blue]="데이터를 삭제하였습니다."
      redirect_to '/fest_manage/make/location/list'
    end
  end


def vul_init
  User.new(name:"Ajou_Univ_Admin", email:"likelion.aju@gmail.com", password:"likelion.au").save
  User.new(name:"Ajou_APLUS", email:"aplus@ajou.ac.kr", password:"ajou_aplus").save
  Realtime.new(Title:"환영합니다", Content:"축제 정보 웹서비스입니다. 방문해주셔서 환영합니다. 실시간으로 전하는 정보는 이곳에 표시됩니다.").save
end

def like_init
  Information.where(like:nil).update_all(like:0)
end

end
