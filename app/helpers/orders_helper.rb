module OrdersHelper
  def get_status(status)
    case status
      when '待確認'
        percent=20
      when '待出貨'
        percent=30
      when '已出貨'
        percent=45
      when '轉運中'
        percent=60
      when '配送中'
        percent=80
      when '完成'
        percent=100
      else 
        percent=0
    end
    
  end

end
