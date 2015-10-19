class RegistrationsController < Devise::RegistrationsController
  before_filter:authenticate_user!, :only => :token
  
  def new
    super
  end
  
  def create
    @company = Company.new(:name => params[:user][:company_name])
    @company.plan = "GRATIS"
    @company.initial_cycle = Time.new
    @company.final_cycle = Time.now.months_since(1)
    @company.counter = 0
    @company.limit = 3
    @company.unit = "Bs."
    @company.separator = ","
    @company.delimiter = "."
    @company.date_format = "%d/%m/%Y"
    @user = User.new(params[:user])
    User.transaction do
       if @company.save
         @user.domain = @company.id
         if @user.save
           Notifier.welcome_email(@user).deliver
           @user.add_role :admin
           sign_in(resource_name, resource)
           defaults @company,@user   
           flash[:notice] = t("devise.sessions.signed_in")
           redirect_to companies_url
         else
           render :action => :new
         end
       else
         @user.errors[:base] << @company.errors.full_messages
          render :action => :new
       end
    end #End of User.transaction
  end #End of create
  
  def update
    super
  end
  
  def defaults company,user
    brand = Brand.new(:code => '00', :description => 'NONE/NINGUNO', :domain => company.id, :username => user.username).save
    category = Category.new(:code => '00', :description => 'NONE/NINGUNO', :domain => company.id, :username => user.username).save
    warehouse = Warehouse.new(:code => '01', :name => 'MAIN/PRINCIPAL', :domain => company.id, :username => user.username).save
    document_type_1 = DocumentType.new(:description => 'INVOICE/FACTURA', :account_type => 'Client', :stock => true, :stock_type => 'debit', :domain => company.id, :username => user.username).save 
    document_type_2 = DocumentType.new(:description => 'ESTIMATE/PRESUPUESTO', :account_type => 'Client', :stock => false, :stock_type => 'debit', :domain => company.id, :username => user.username).save 
    document_type_3 = DocumentType.new(:description => 'IN STOCK/ENTRADA', :account_type => 'Warehouse', :stock => true, :stock_type => 'credit', :domain => company.id, :username => user.username).save     
  end  
end
           