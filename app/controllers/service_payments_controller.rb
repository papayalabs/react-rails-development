class ServicePaymentsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @service_payments = current_user.company.service_payments.all( :limit => 10, :order => "id DESC" )
  end

  def new
    @service_payment = ServicePayment.new
    @service_payment.domain = current_user.domain
    @service_payment.amount = params[:amount]
    @service_payment.description = params[:description]  
    @service_payment.period = params[:period] 
    @service_payment.return_url = service_payment_execute_url(":service_payment_id")
    @service_payment.cancel_url = service_payment_cancel_url(":service_payment_id")
    if @service_payment.save
      if @service_payment.approve_url
        redirect_to @service_payment.approve_url
      else
        redirect_to service_payments_path, :notice => "ServicePayment[#{@service_payment.description}] placed successfully"
      end
    else
      render companies_path, :alert  => @service_payment.errors.to_a.join(", ")
    end
  end

  def execute
    service_payment = current_user.company.service_payments.find(params[:service_payment_id])
    if service_payment.execute(params["PayerID"])
       if service_payment.period == "month"
         @company = current_user.company
         @company.plan = "PAGO"
         @company.initial_cycle = Time.new
         @company.final_cycle = Time.now.months_since(1)
         @company.counter = 0
         @company.limit = 1000000
         @company.save
       elsif service_payment.period == "year"
         @company = current_user.company
         @company.plan = "PAGO"
         @company.initial_cycle = Time.new
         @company.final_cycle = Time.now.years_since(1)
         @company.counter = 0
         @company.limit = 1000000
         @company.save
       end           
      redirect_to companies_path, :notice => "ServicePayment[#{service_payment.description}] placed successfully"
    else
      redirect_to companies_path, :alert => service_payment.payment.error.inspect
    end
  end

  def cancel
    service_payment = current_user.company.service_payments.find(params[:service_payment_id])
    unless service_payment.state == "approved"
      service_payment.state = "cancelled"
      service_payment.save
    end
    redirect_to companies_path, :notice => "ServicePayment cancelled"
  end

  def show
    @service_payment = current_user.company.service_payments.find(params[:id])
  end
end
