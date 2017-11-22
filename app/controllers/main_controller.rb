class MainController < ApplicationController
  def list_switch
    @switches = Switch.order(:name).page(params[:page])
  end

  def list_port
    @ports = Port.order(:status, :switch_id).page(params[:page])
  end

  def switch_detail
    @switch = Switch.find(params[:switch_id] || Switch.first)
  end

  def vlans
    @vlans = Vlan.order(:switch_id)
    @vlans = @vlans.where(vlan: params[:vlan_id].to_i) if params[:vlan_id]
    @vlans = @vlans.page(params[:page])
  end
end
